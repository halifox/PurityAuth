// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Purity Auth';

  @override
  String get add => 'Add';

  @override
  String get scan => 'Scan';

  @override
  String get settings => 'Settings';

  @override
  String get scanQRCode => 'Scan QR Code';

  @override
  String get secret => 'Secret';

  @override
  String get algorithm => 'Algorithm';

  @override
  String get digits => 'Digits';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get ok => 'OK';

  @override
  String get codeCopied => 'Code Copied';

  @override
  String get tip => 'Tip';

  @override
  String get warning => 'Warning';

  @override
  String get importFailed => 'Import Failed';

  @override
  String get importSuccess => 'Import Successful';

  @override
  String get exportSuccess => 'Export Successful';

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
  String get cannotGetClipboardData => 'Failed to get clipboard data';

  @override
  String importedCount(int count) {
    return '$count items imported from clipboard';
  }

  @override
  String exportedCount(int count) {
    return 'Exported $count items to clipboard';
  }

  @override
  String get unsupportedQRCode => 'This type of QR code is not supported.';

  @override
  String tokenExists(String issuer, String account) {
    return 'Token $issuer:$account already exists. Do you want to overwrite it?';
  }

  @override
  String get deleteWarning =>
      'You are about to delete the current two-factor authenticator.\nThis action will prevent you from using this authenticator for authentication.\nPlease make sure you have other authentication methods ready to ensure account security.';

  @override
  String get uploadQRCode => 'Import QR Code';

  @override
  String get enterKey => 'Enter Secret Code';

  @override
  String get importFromClipboard => 'Import from Clipboard';

  @override
  String get exportToClipboard => 'Export to Clipboard';

  @override
  String get enterProvidedKey => 'Enter Secret Key';

  @override
  String get type => 'Type';

  @override
  String get issuer => 'Issuer';

  @override
  String get account => 'Account';

  @override
  String get pin => 'PIN Code';

  @override
  String get period => 'Period (seconds)';

  @override
  String get counter => 'Counter';

  @override
  String get totp => 'TOTP (Time-based)';

  @override
  String get hotp => 'HOTP (Counter-based)';

  @override
  String get motp => 'mOTP (Mobile-OTP)';

  @override
  String get showCaptchaOnTap => 'Tap to Reveal Code';

  @override
  String get copyCaptchaOnTap => 'Tap to Copy Code';
}
