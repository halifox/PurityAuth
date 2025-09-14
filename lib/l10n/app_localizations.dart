import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
  ];

  /// 应用程序标题
  ///
  /// In zh, this message translates to:
  /// **'Purity Auth'**
  String get appTitle;

  /// 添加按钮
  ///
  /// In zh, this message translates to:
  /// **'添加'**
  String get add;

  /// 扫描按钮
  ///
  /// In zh, this message translates to:
  /// **'扫描'**
  String get scan;

  /// 设置标签
  ///
  /// In zh, this message translates to:
  /// **'设置'**
  String get settings;

  /// 扫描二维码提示
  ///
  /// In zh, this message translates to:
  /// **'扫描二维码'**
  String get scanQRCode;

  /// 密钥输入框标签
  ///
  /// In zh, this message translates to:
  /// **'密钥'**
  String get secret;

  /// 算法选择标签
  ///
  /// In zh, this message translates to:
  /// **'算法'**
  String get algorithm;

  /// 位数选择标签
  ///
  /// In zh, this message translates to:
  /// **'位数'**
  String get digits;

  /// 取消按钮
  ///
  /// In zh, this message translates to:
  /// **'取消'**
  String get cancel;

  /// 删除按钮
  ///
  /// In zh, this message translates to:
  /// **'删除'**
  String get delete;

  /// 编辑按钮
  ///
  /// In zh, this message translates to:
  /// **'编辑'**
  String get edit;

  /// 确定按钮
  ///
  /// In zh, this message translates to:
  /// **'确定'**
  String get ok;

  /// 代码复制成功提示
  ///
  /// In zh, this message translates to:
  /// **'代码已复制'**
  String get codeCopied;

  /// 提示标题
  ///
  /// In zh, this message translates to:
  /// **'提示'**
  String get tip;

  /// 警告标题
  ///
  /// In zh, this message translates to:
  /// **'警告'**
  String get warning;

  /// 导入失败标题
  ///
  /// In zh, this message translates to:
  /// **'导入失败'**
  String get importFailed;

  /// 导入成功标题
  ///
  /// In zh, this message translates to:
  /// **'导入成功'**
  String get importSuccess;

  /// 导出成功标题
  ///
  /// In zh, this message translates to:
  /// **'导出成功'**
  String get exportSuccess;

  /// 添加成功提示
  ///
  /// In zh, this message translates to:
  /// **'添加成功'**
  String get addSuccess;

  /// 更新成功提示
  ///
  /// In zh, this message translates to:
  /// **'更新成功'**
  String get updateSuccess;

  /// 保存失败标题
  ///
  /// In zh, this message translates to:
  /// **'保存失败'**
  String get saveFailed;

  /// 平台不支持提示
  ///
  /// In zh, this message translates to:
  /// **'该功能当前仅支持 Android 和 iOS 平台。'**
  String get platformNotSupported;

  /// 无法获取剪贴板数据提示
  ///
  /// In zh, this message translates to:
  /// **'无法获取剪贴板数据'**
  String get cannotGetClipboardData;

  /// 导入数据数量提示
  ///
  /// In zh, this message translates to:
  /// **'共导入{count}条数据'**
  String importedCount(int count);

  /// 导出数据数量提示
  ///
  /// In zh, this message translates to:
  /// **'共导出{count}条数据到剪贴板'**
  String exportedCount(int count);

  /// 不支持的二维码提示
  ///
  /// In zh, this message translates to:
  /// **'暂不支持此类型的二维码链接，请确认来源是否正确。'**
  String get unsupportedQRCode;

  /// 令牌已存在提示
  ///
  /// In zh, this message translates to:
  /// **'令牌{issuer}:{account}已经存在,是否覆盖它'**
  String tokenExists(String issuer, String account);

  /// 删除警告信息
  ///
  /// In zh, this message translates to:
  /// **'您即将删除当前的两步验证器。\n此操作将使您无法使用该验证器进行身份验证。\n请确保您已准备好其他身份验证方式以保障账户安全。'**
  String get deleteWarning;

  /// 上传二维码选项
  ///
  /// In zh, this message translates to:
  /// **'上传二维码'**
  String get uploadQRCode;

  /// 输入密钥选项
  ///
  /// In zh, this message translates to:
  /// **'输入密钥'**
  String get enterKey;

  /// 从剪贴板导入选项
  ///
  /// In zh, this message translates to:
  /// **'从剪贴板导入'**
  String get importFromClipboard;

  /// 导出到剪贴板选项
  ///
  /// In zh, this message translates to:
  /// **'导出到剪贴板'**
  String get exportToClipboard;

  /// 输入提供的密钥标题
  ///
  /// In zh, this message translates to:
  /// **'输入提供的密钥'**
  String get enterProvidedKey;

  /// 类型标签
  ///
  /// In zh, this message translates to:
  /// **'类型'**
  String get type;

  /// 发行方标签
  ///
  /// In zh, this message translates to:
  /// **'发行方'**
  String get issuer;

  /// 用户名标签
  ///
  /// In zh, this message translates to:
  /// **'用户名'**
  String get username;

  /// PIN码标签
  ///
  /// In zh, this message translates to:
  /// **'PIN码'**
  String get pin;

  /// 时间间隔标签
  ///
  /// In zh, this message translates to:
  /// **'时间间隔(秒)'**
  String get period;

  /// 计数器标签
  ///
  /// In zh, this message translates to:
  /// **'计数器'**
  String get counter;

  /// TOTP类型描述
  ///
  /// In zh, this message translates to:
  /// **'(TOTP) 基于时间'**
  String get totp;

  /// HOTP类型描述
  ///
  /// In zh, this message translates to:
  /// **'(HOTP) 基于计数器'**
  String get hotp;

  /// mOTP类型描述
  ///
  /// In zh, this message translates to:
  /// **'(mOTP) Mobile-OTP'**
  String get motp;

  /// 轻触显示验证码选项
  ///
  /// In zh, this message translates to:
  /// **'轻触显示验证码'**
  String get showCaptchaOnTap;

  /// 轻触复制验证码选项
  ///
  /// In zh, this message translates to:
  /// **'轻触复制验证码'**
  String get copyCaptchaOnTap;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
