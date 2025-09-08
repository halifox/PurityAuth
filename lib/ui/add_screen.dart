import 'dart:io';

import 'package:auth/auth.dart';
import 'package:auth/dialog.dart';
import 'package:auth/repository.dart';
import 'package:auth/top_bar.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sembast/sembast.dart';

class AddScreenOption {
  AddScreenOption(this.icon, this.label, this.onTap);

  final IconData icon;
  final String label;
  final void Function(BuildContext context) onTap;
}

class AddScreen extends StatelessWidget {
  final MobileScannerController controller = MobileScannerController();

  late final List<AddScreenOption> options = [
    AddScreenOption(Icons.camera_enhance, '扫描二维码', scan),
    AddScreenOption(Icons.photo_library, '上传二维码', upload),
    AddScreenOption(Icons.keyboard, '输入密钥', enter),
    AddScreenOption(Icons.file_upload_outlined, '恢复备份', restore),
    AddScreenOption(Icons.file_download_outlined, '创建备份', backup),
  ];

  void scan(BuildContext context) async {
    if (kIsWeb || (!Platform.isAndroid && !Platform.isIOS)) {
      showAlertDialog(context, '提示', '该功能当前仅支持 Android 和 iOS 平台。');
      return;
    }

    final BarcodeCapture? barcodeCapture = await Navigator.pushNamed(context, '/scan') as BarcodeCapture?;
    handleScannedBarcodes(context, barcodeCapture?.barcodes);
  }

  void upload(BuildContext context) async {
    if (kIsWeb || (!Platform.isAndroid && !Platform.isIOS)) {
      showAlertDialog(context, '提示', '该功能当前仅支持 Android 和 iOS 平台。');
      return;
    }

    final XFile? selectedFile = await openFile(
      acceptedTypeGroups: [
        XTypeGroup(extensions: ['jpg', 'jpeg', 'png']),
      ],
    );
    if (selectedFile == null) {
      //没有选择图片
      return;
    }
    final BarcodeCapture? barcodeCapture = await controller.analyzeImage(selectedFile.path);
    handleScannedBarcodes(context, barcodeCapture?.barcodes);
  }

  void enter(BuildContext context) async {
    Navigator.pushNamed(context, '/from');
  }

  void restore(BuildContext context) async {
    try {
      XFile? selectedFile = await openFile(
        acceptedTypeGroups: [
          XTypeGroup(extensions: <String>['txt']),
        ],
        initialDirectory: "/sdcard/Documents",
      );
      if (selectedFile == null) {
        return;
      }
      final String data = await selectedFile.readAsString();
      final List<String> optUrls = data.split("\n");

      for (String optUrl in optUrls) {
        final AuthConfig config = AuthConfig.parse(optUrl);
        final bool verify = config.verify();
        if (!verify) {
          continue;
        }
        final int count = await authStore.count(db, filter: Filter.and([Filter.equals('account', config.account), Filter.equals('issuer', config.issuer)]));
        if (count > 0) {
          await showOverwriteDialog(context, config);
          continue;
        }
        await authStore.add(db, config.toJson());
      }

      showAlertDialog(context, "提示", "导入完成");
    } catch (e) {
      showAlertDialog(context, '错误', e.toString());
    }
  }

  void backup(context) async {
    try {
      final List<RecordSnapshot<String, Map<String, Object?>>> records = await authStore.find(db);
      final String optUrls = records.map((e) => AuthConfig.fromJson(e).toOtpUri()).join("\n");

      if (await Permission.storage.request().isGranted) {
        Directory? dir;
        if (Platform.isAndroid) {
          if (await Permission.manageExternalStorage.isGranted) {
            // Android 11+ 可用 MANAGE_EXTERNAL_STORAGE，大权限
            dir = Directory("/sdcard/Documents");
          } else {
            // Android 10- 或未授予大权限
            dir = Directory("/sdcard/Documents");
          }
        } else {
          dir = await getApplicationDocumentsDirectory();
        }

        if (!dir.existsSync()) {
          dir.createSync(recursive: true);
        }

        final String fn = generateFileNameWithTime("auth", "txt");
        final File file = File("${dir.path}/${fn}");
        await file.writeAsString(optUrls);
        showAlertDialog(context, "提示", "备份成功,文件位置:${file.path}");
      } else {
        throw Exception("Storage permission denied");
      }
    } catch (e) {
      showAlertDialog(context, '错误', e.toString());
    }
  }

  String generateFileNameWithTime(String prefix, String extension) {
    final DateTime now = DateTime.now();
    final String formatted = '${now.year}${twoDigits(now.month)}${twoDigits(now.day)}_${twoDigits(now.hour)}${twoDigits(now.minute)}${twoDigits(now.second)}';
    return '$prefix\_$formatted.$extension';
  }

  String twoDigits(int n) => n.toString().padLeft(2, '0');

  void handleScannedBarcodes(BuildContext context, List<Barcode>? barcodes) async {
    if (barcodes == null || barcodes.isEmpty) {
      return;
    }
    final Barcode barcode = barcodes[0];
    final String? uriString = barcode.rawValue;
    if (uriString == null) {
      return;
    }
    Navigator.popUntil(context, ModalRoute.withName('/'));
    final AuthConfig config = AuthConfig.parse(uriString);
    final bool verify = config.verify();
    if (!verify) {
      showAlertDialog(context, '提示', '暂不支持此类型的二维码链接，请确认来源是否正确。');
      return;
    }
    final int count = await authStore.count(db, filter: Filter.and([Filter.equals('account', config.account), Filter.equals('issuer', config.issuer)]));
    if (count > 0) {
      showOverwriteDialog(context, config);
      return;
    }
    await authStore.add(db, config.toJson());
    await showAlertDialog(context, '提示', '添加成功');
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: TopBar(context, '添加'),
      body: GridView.builder(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: EdgeInsets.symmetric(horizontal: 16),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 700, mainAxisSpacing: 16, crossAxisSpacing: 16, mainAxisExtent: 90),
        itemCount: options.length,
        itemBuilder: (context, index) {
          final AddScreenOption option = options[index];
          return HorizontalBarButton(option.icon, option.label, option.onTap);
        },
      ),
    );
  }
}

class HorizontalBarButton extends StatelessWidget {
  const HorizontalBarButton(this.icon, this.label, this.onTap, {super.key});

  final IconData icon;
  final String label;
  final void Function(BuildContext context) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap.call(context),
      child: Container(
        padding: EdgeInsets.all(16),
        alignment: Alignment.center,
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.primaryContainer, borderRadius: BorderRadius.all(Radius.circular(24))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 48,
              width: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Icon(icon, size: 24, color: Theme.of(context).colorScheme.onPrimary),
            ),
            SizedBox(width: 16),
            Text(
              label,
              maxLines: 1,
              style: TextStyle(height: 0, fontSize: 18, color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
