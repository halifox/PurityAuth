// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'PurityAuth';

  @override
  String get home => 'Home';

  @override
  String get add => 'Add';

  @override
  String get scan => 'Scan';

  @override
  String get settings => 'Settings';

  @override
  String get scanQRCode => 'Scan QR Code';

  @override
  String get addManually => 'Add Manually';

  @override
  String get accountName => 'Account Name';

  @override
  String get secretKey => 'Secret Key';

  @override
  String get algorithm => 'Algorithm';

  @override
  String get digits => 'Digits';

  @override
  String get period => 'Period';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get copy => 'Copy';

  @override
  String get copied => 'Copied';

  @override
  String get error => 'Error';

  @override
  String get success => 'Success';

  @override
  String get invalidQRCode => 'Invalid QR Code';

  @override
  String get invalidSecretKey => 'Invalid Secret Key';

  @override
  String get accountNameRequired => 'Please enter account name';

  @override
  String get secretKeyRequired => 'Please enter secret key';

  @override
  String get confirmDelete => 'Are you sure you want to delete this account?';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get ok => 'OK';

  @override
  String get codeCopied => 'Code copied';

  @override
  String get tip => 'Tip';

  @override
  String get warning => 'Warning';

  @override
  String get importFailed => 'Import Failed';

  @override
  String get importSuccess => 'Import Success';

  @override
  String get exportSuccess => 'Export Success';

  @override
  String get addSuccess => 'Added Successfully';

  @override
  String get updateSuccess => 'Updated Successfully';

  @override
  String get saveFailed => 'Save Failed';

  @override
  String get platformNotSupported =>
      'This feature is currently only supported on Android and iOS platforms.';

  @override
  String get cannotGetClipboardData => 'Cannot get clipboard data';

  @override
  String importedCount(int count) {
    return 'Imported $count items';
  }

  @override
  String exportedCount(int count) {
    return 'Exported $count items to clipboard';
  }

  @override
  String get unsupportedQRCode =>
      'This type of QR code link is not supported, please confirm the source is correct.';

  @override
  String tokenExists(String issuer, String account) {
    return 'Token $issuer:$account already exists, do you want to overwrite it?';
  }

  @override
  String get deleteWarning =>
      'You are about to delete the current two-factor authenticator.\nThis action will prevent you from using this authenticator for authentication.\nPlease make sure you have other authentication methods ready to ensure account security.';

  @override
  String get uploadQRCode => 'Upload QR Code';

  @override
  String get enterKey => 'Enter Key';

  @override
  String get importFromClipboard => 'Import from Clipboard';

  @override
  String get exportToClipboard => 'Export to Clipboard';

  @override
  String get enterProvidedKey => 'Enter Provided Key';

  @override
  String get selectIcon => 'Select Icon';

  @override
  String get type => 'Type';

  @override
  String get issuer => 'Issuer';

  @override
  String get username => 'Username';

  @override
  String get pinCode => 'PIN Code';

  @override
  String get timeInterval => 'Time Interval (seconds)';

  @override
  String get counter => 'Counter';

  @override
  String get totpType => 'Time-based (TOTP)';

  @override
  String get hotpType => 'Counter-based (HOTP)';

  @override
  String get motpType => 'Mobile-OTP (mOTP)';

  @override
  String get biometricUnlock => 'Biometric Unlock';

  @override
  String get showCaptchaOnTap => 'Show Captcha on Tap';

  @override
  String get copyCaptchaOnTap => 'Copy Captcha on Tap';
}
