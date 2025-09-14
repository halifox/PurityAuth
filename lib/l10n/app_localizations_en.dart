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
}
