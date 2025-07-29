// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'GathrFi';

  @override
  String get onboardingTitle => 'Meet GathrFi';

  @override
  String get onboardingDesc =>
      'Transform bill splitting from awkward IOU tracking to automated, yield-earning DeFi experience';

  @override
  String get iEmailAddressLabel => 'Email Address';

  @override
  String get iEmailAddressHint => 'username@email.com';

  @override
  String get btnLogin => 'Continue with Email';

  @override
  String get otherLoginMethod => 'or continue with';

  @override
  String get createProfile => 'Create Profile';

  @override
  String get iUsernameLabel => 'Username';

  @override
  String get iUsernameHint => 'Pick a cool username';

  @override
  String get btnContinue => 'Continue';

  @override
  String greeting(String name) {
    return 'Hello, $name';
  }

  @override
  String get addressCopied => 'Address copied to clipboard!';

  @override
  String get settings => 'Settings';

  @override
  String get logout => 'Logout';
}
