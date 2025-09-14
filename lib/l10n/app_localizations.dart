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
  /// **'PurityAuth'**
  String get appTitle;

  /// 首页标签
  ///
  /// In zh, this message translates to:
  /// **'首页'**
  String get home;

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

  /// 手动添加选项
  ///
  /// In zh, this message translates to:
  /// **'手动添加'**
  String get addManually;

  /// 账户名称输入框标签
  ///
  /// In zh, this message translates to:
  /// **'账户名称'**
  String get accountName;

  /// 密钥输入框标签
  ///
  /// In zh, this message translates to:
  /// **'密钥'**
  String get secretKey;

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

  /// 周期设置标签
  ///
  /// In zh, this message translates to:
  /// **'周期'**
  String get period;

  /// 保存按钮
  ///
  /// In zh, this message translates to:
  /// **'保存'**
  String get save;

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

  /// 复制按钮
  ///
  /// In zh, this message translates to:
  /// **'复制'**
  String get copy;

  /// 复制成功提示
  ///
  /// In zh, this message translates to:
  /// **'已复制'**
  String get copied;

  /// 错误提示
  ///
  /// In zh, this message translates to:
  /// **'错误'**
  String get error;

  /// 成功提示
  ///
  /// In zh, this message translates to:
  /// **'成功'**
  String get success;

  /// 无效二维码错误提示
  ///
  /// In zh, this message translates to:
  /// **'无效的二维码'**
  String get invalidQRCode;

  /// 无效密钥错误提示
  ///
  /// In zh, this message translates to:
  /// **'无效的密钥'**
  String get invalidSecretKey;

  /// 账户名称必填提示
  ///
  /// In zh, this message translates to:
  /// **'请输入账户名称'**
  String get accountNameRequired;

  /// 密钥必填提示
  ///
  /// In zh, this message translates to:
  /// **'请输入密钥'**
  String get secretKeyRequired;

  /// 删除确认对话框
  ///
  /// In zh, this message translates to:
  /// **'确认删除此账户？'**
  String get confirmDelete;

  /// 确认按钮
  ///
  /// In zh, this message translates to:
  /// **'是'**
  String get yes;

  /// 取消按钮
  ///
  /// In zh, this message translates to:
  /// **'否'**
  String get no;
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
