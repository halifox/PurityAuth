// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'Purity Auth';

  @override
  String get add => '添加';

  @override
  String get scan => '扫描';

  @override
  String get settings => '设置';

  @override
  String get scanQRCode => '扫描二维码';

  @override
  String get secretKey => '密钥';

  @override
  String get algorithm => '算法';

  @override
  String get digits => '位数';

  @override
  String get cancel => '取消';

  @override
  String get delete => '删除';

  @override
  String get edit => '编辑';

  @override
  String get ok => '确定';

  @override
  String get codeCopied => '代码已复制';

  @override
  String get tip => '提示';

  @override
  String get warning => '警告';

  @override
  String get importFailed => '导入失败';

  @override
  String get importSuccess => '导入成功';

  @override
  String get exportSuccess => '导出成功';

  @override
  String get addSuccess => '添加成功';

  @override
  String get updateSuccess => '更新成功';

  @override
  String get saveFailed => '保存失败';

  @override
  String get platformNotSupported => '该功能当前仅支持 Android 和 iOS 平台。';

  @override
  String get cannotGetClipboardData => '无法获取剪贴板数据';

  @override
  String importedCount(int count) {
    return '共导入$count条数据';
  }

  @override
  String exportedCount(int count) {
    return '共导出$count条数据到剪贴板';
  }

  @override
  String get unsupportedQRCode => '暂不支持此类型的二维码链接，请确认来源是否正确。';

  @override
  String tokenExists(String issuer, String account) {
    return '令牌$issuer:$account已经存在,是否覆盖它';
  }

  @override
  String get deleteWarning =>
      '您即将删除当前的两步验证器。\n此操作将使您无法使用该验证器进行身份验证。\n请确保您已准备好其他身份验证方式以保障账户安全。';

  @override
  String get uploadQRCode => '上传二维码';

  @override
  String get enterKey => '输入密钥';

  @override
  String get importFromClipboard => '从剪贴板导入';

  @override
  String get exportToClipboard => '导出到剪贴板';

  @override
  String get enterProvidedKey => '输入提供的密钥';

  @override
  String get type => '类型';

  @override
  String get issuer => '发行方';

  @override
  String get username => '用户名';

  @override
  String get pinCode => 'PIN码';

  @override
  String get timeInterval => '时间间隔(秒)';

  @override
  String get counter => '计数器';

  @override
  String get totpType => '基于时间 (TOTP)';

  @override
  String get hotpType => '基于计数器 (HOTP)';

  @override
  String get motpType => 'Mobile-OTP (mOTP)';

  @override
  String get showCaptchaOnTap => '轻触显示验证码';

  @override
  String get copyCaptchaOnTap => '轻触复制验证码';
}
