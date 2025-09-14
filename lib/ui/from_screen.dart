import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sembast/sembast.dart';

import '../repository/auth.dart';
import '../repository/repository.dart';
import 'result_screen.dart';
import 'top_bar.dart';

class FromScreen extends StatefulWidget {
  const FromScreen({super.key});

  @override
  State<FromScreen> createState() => _FromScreenState();
}

class _FromScreenState extends State<FromScreen> {
  late AuthConfig config = ModalRoute.of(context)?.settings.arguments as AuthConfig? ?? AuthConfig();

  final typeLabels = {'totp': '基于时间 (TOTP)', 'hotp': '基于计数器 (HOTP)', 'motp': 'Mobile-OTP (mOTP)'};
  final algorithmLabels = {'sha1': 'SHA1', 'sha256': 'SHA256', 'sha512': 'SHA512'};

  Future<void> onSave(BuildContext context) async {
    try {
      config.verifyThrow();
    } on ArgumentError catch (e) {
      showCupertinoModalPopup(
        context: context,
        builder: (ctx) => ResultScreen(state: 0, title: '保存失败', message: '${e.message}'),
      );
      return;
    }
    if (config.key.isEmpty) {
      final int count = await authStore.count(
        db,
        filter: Filter.and([Filter.equals('account', config.account), Filter.equals('issuer', config.issuer)]),
      );
      if (count > 0) {
        final bool? result = await showCupertinoModalPopup<bool?>(
          context: context,
          builder: (ctx) => ResultScreen(
            state: 0,
            title: '警告',
            message: '令牌${config.issuer}:${config.account}已经存在,是否覆盖它',
            falseButtonVisible: true,
          ),
        );
        if (result == null) {
          return;
        }
        if (result) {
          await authStore.update(
            db,
            config.toJson(),
            finder: Finder(
              filter: Filter.and([Filter.equals('account', config.account), Filter.equals('issuer', config.issuer)]),
            ),
          );
        }
        return;
      }
      await authStore.add(db, config.toJson());
      Navigator.popUntil(context, ModalRoute.withName('/'));
      showCupertinoModalPopup(
        context: context,
        builder: (ctx) => const ResultScreen(state: 1, title: '提示', message: '添加成功'),
      );
    } else {
      authStore.record(config.key).update(db, config.toJson());
      Navigator.popUntil(context, ModalRoute.withName('/'));
      showCupertinoModalPopup(
        context: context,
        builder: (ctx) => const ResultScreen(state: 1, title: '提示', message: '更新成功'),
      );
    }
  }

  Widget buildDigitsOnlyTextField(int initValue, Function(int) onChanged, String label) => buildTextField(
    initValue.toString(),
    (value) => onChanged(int.parse(value)),
    label,
    inputType: TextInputType.number,
    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
  );

  Widget buildTextField(
    String initValue,
    Function(String) onChanged,
    String label, {
    TextInputType? inputType,
    List<TextInputFormatter>? inputFormatters,
    suffixIcon,
  }) => TextField(
    key: ValueKey(label),
    controller: TextEditingController(text: initValue),
    onChanged: (value) {
      onChanged(value);
    },
    decoration: InputDecoration(
      labelText: label,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      border: const OutlineInputBorder(
        borderSide: BorderSide(),
        borderRadius: BorderRadius.all(Radius.circular(14.0)),
        gapPadding: 8.0,
      ),
      suffixIcon: suffixIcon,
    ),
    keyboardType: inputType,
    inputFormatters: inputFormatters,
  );

  bool _obscureText = true; // 是否隐藏密码
  Widget buildPasswordTextField(String initValue, Function(String) onChanged, String label) => TextField(
    key: ValueKey(label),
    controller: TextEditingController(text: initValue),
    onChanged: (value) {
      onChanged(value);
    },
    obscureText: _obscureText,
    decoration: InputDecoration(
      labelText: label,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      border: const OutlineInputBorder(
        borderSide: BorderSide(),
        borderRadius: BorderRadius.all(Radius.circular(14.0)),
        gapPadding: 8.0,
      ),
      suffixIcon: IconButton(
        icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText; // 切换显示/隐藏
          });
        },
      ),
    ),
  );

  Widget buildDropdown<T>(String label, T initialValue, Map<T, String> options, void Function(T) onChanged) =>
      DropdownMenuFormField<T>(
        width: double.infinity,
        label: Text(label),
        initialSelection: initialValue,
        dropdownMenuEntries: options.entries
            .map((MapEntry<T, String> entry) => DropdownMenuEntry(value: entry.key, label: entry.value))
            .toList(),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(),
            borderRadius: BorderRadius.all(Radius.circular(14.0)),
            gapPadding: 8.0,
          ),
        ),
        onSelected: (value) {
          setState(() {
            if (value != null) {
              onChanged(value);
            }
          });
        },
      );

  Widget buildIcon(String icon, void Function(String) onChange) => Padding(
    padding: const EdgeInsets.all(6.0),
    child: GestureDetector(
      onTap: () async {
        final icon = await Navigator.pushNamed(context, '/icons');
        if (icon != null) {
          onChange(icon as String);
        }
      },
      child: Container(
        height: 44,
        width: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: SvgPicture.asset(
          icon,
          width: 28,
          height: 28,
          colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onPrimary, BlendMode.srcIn),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    print(config.toJson());
    return Scaffold(
      appBar: TopBar(context, '输入提供的密钥', rightIcon: Icons.save, rightOnPressed: onSave),
      body: SizedBox.expand(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
              spacing: 16,
              children: [
                buildDropdown('类型', config.type, typeLabels, (value) => config.type = value),
                buildTextField(
                  config.issuer,
                  (it) => config.issuer = it,
                  '发行方',
                  suffixIcon: buildIcon(config.icon, (icon) => config.icon = icon),
                ),
                buildTextField(config.account, (it) => config.account = it, '用户名'),
                buildPasswordTextField(config.secret, (it) => config.secret = it, '密钥'),
                switch (config.type.toLowerCase()) {
                  'totp' => buildDropdown('算法', config.algorithm, algorithmLabels, (value) => config.algorithm = value),
                  'hotp' => buildDropdown('算法', config.algorithm, algorithmLabels, (value) => config.algorithm = value),
                  'motp' => buildTextField(config.pin, (it) => config.pin = it, 'PIN码'),
                  String() => throw UnimplementedError(),
                },
                Row(
                  spacing: 16,
                  children: <Widget>[
                    Expanded(child: buildDigitsOnlyTextField(config.digits, (it) => config.digits = it, '位数')),
                    Expanded(
                      child: switch (config.type.toLowerCase()) {
                        'totp' => buildDigitsOnlyTextField(config.period, (it) => config.period = it, '时间间隔(秒)'),
                        'hotp' => buildDigitsOnlyTextField(config.counter, (it) => config.counter = it, '计数器'),
                        'motp' => buildDigitsOnlyTextField(config.period, (it) => config.period = it, '时间间隔(秒)'),
                        String() => throw UnimplementedError(),
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IconsChooseScreen extends StatefulWidget {
  const IconsChooseScreen({super.key});

  @override
  State<IconsChooseScreen> createState() => _IconsChooseScreenState();
}

class _IconsChooseScreenState extends State<IconsChooseScreen> {
  List<String> iconList = <String>[];
  final textEditingController = TextEditingController();

  Future<void> loadIcons() async {
    final jsonString = await rootBundle.loadString('assets/icons.json');
    final List<dynamic> jsonList = jsonDecode(jsonString);
    setState(() {
      iconList = jsonList.cast<String>();
    });
  }

  @override
  void initState() {
    loadIcons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: TopBar(context, '选择图标'),
    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: TextField(
            controller: textEditingController,
            onChanged: (value) async {
              setState(() {
                iconList = iconList.where((element) => element.contains(value)).toList();
              });
            },
            decoration: const InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: OutlineInputBorder(
                borderSide: BorderSide(),
                borderRadius: BorderRadius.all(Radius.circular(14.0)),
                gapPadding: 8.0,
              ),
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: Scrollbar(
            interactive: true,
            thumbVisibility: true,
            thickness: 12,
            radius: const Radius.circular(12),
            child: GridView.builder(
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 60,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: iconList.length,
              itemBuilder: (context, index) {
                final icon = iconList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context, 'assets/icons/$icon');
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/$icon',
                      width: 28,
                      height: 28,
                      colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onPrimary, BlendMode.srcIn),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    ),
  );
}
