// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'PurityAuth';

  @override
  String get home => '首页';

  @override
  String get add => '添加';

  @override
  String get scan => '扫描';

  @override
  String get settings => '设置';

  @override
  String get scanQRCode => '扫描二维码';

  @override
  String get addManually => '手动添加';

  @override
  String get accountName => '账户名称';

  @override
  String get secretKey => '密钥';

  @override
  String get algorithm => '算法';

  @override
  String get digits => '位数';

  @override
  String get period => '周期';

  @override
  String get save => '保存';

  @override
  String get cancel => '取消';

  @override
  String get delete => '删除';

  @override
  String get edit => '编辑';

  @override
  String get copy => '复制';

  @override
  String get copied => '已复制';

  @override
  String get error => '错误';

  @override
  String get success => '成功';

  @override
  String get invalidQRCode => '无效的二维码';

  @override
  String get invalidSecretKey => '无效的密钥';

  @override
  String get accountNameRequired => '请输入账户名称';

  @override
  String get secretKeyRequired => '请输入密钥';

  @override
  String get confirmDelete => '确认删除此账户？';

  @override
  String get yes => '是';

  @override
  String get no => '否';
}
