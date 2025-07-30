import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

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
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'GathrFi'**
  String get appName;

  /// No description provided for @onboardingTitle.
  ///
  /// In en, this message translates to:
  /// **'Meet GathrFi'**
  String get onboardingTitle;

  /// No description provided for @onboardingDesc.
  ///
  /// In en, this message translates to:
  /// **'Transform bill splitting from awkward IOU tracking to automated, yield-earning DeFi experience'**
  String get onboardingDesc;

  /// No description provided for @iEmailAddressLabel.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get iEmailAddressLabel;

  /// No description provided for @iEmailAddressHint.
  ///
  /// In en, this message translates to:
  /// **'username@email.com'**
  String get iEmailAddressHint;

  /// No description provided for @btnLogin.
  ///
  /// In en, this message translates to:
  /// **'Continue with Email'**
  String get btnLogin;

  /// No description provided for @otherLoginMethod.
  ///
  /// In en, this message translates to:
  /// **'or continue with'**
  String get otherLoginMethod;

  /// No description provided for @createProfile.
  ///
  /// In en, this message translates to:
  /// **'Create Profile'**
  String get createProfile;

  /// No description provided for @iUsernameLabel.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get iUsernameLabel;

  /// No description provided for @iUsernameHint.
  ///
  /// In en, this message translates to:
  /// **'Pick a cool username'**
  String get iUsernameHint;

  /// No description provided for @iUsernameError.
  ///
  /// In en, this message translates to:
  /// **'Taken! Try being even cooler.'**
  String get iUsernameError;

  /// No description provided for @btnContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get btnContinue;

  /// No description provided for @greeting.
  ///
  /// In en, this message translates to:
  /// **'Hello, {name}!'**
  String greeting(String name);

  /// No description provided for @addressCopied.
  ///
  /// In en, this message translates to:
  /// **'Address copied to clipboard!'**
  String get addressCopied;

  /// No description provided for @yourBalance.
  ///
  /// In en, this message translates to:
  /// **'Your Balance'**
  String get yourBalance;

  /// No description provided for @yourWalletBalance.
  ///
  /// In en, this message translates to:
  /// **'Your Wallet Balance'**
  String get yourWalletBalance;

  /// No description provided for @btnWithdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get btnWithdraw;

  /// No description provided for @btnDeposit.
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get btnDeposit;

  /// No description provided for @iDepositLabel.
  ///
  /// In en, this message translates to:
  /// **'Amount to Deposit'**
  String get iDepositLabel;

  /// No description provided for @iWithdrawLabel.
  ///
  /// In en, this message translates to:
  /// **'Amount to Withdraw'**
  String get iWithdrawLabel;

  /// No description provided for @iAmountHint.
  ///
  /// In en, this message translates to:
  /// **'0.00'**
  String get iAmountHint;

  /// No description provided for @iAmountExceedError.
  ///
  /// In en, this message translates to:
  /// **'Amount exceeds your available balance.'**
  String get iAmountExceedError;

  /// No description provided for @btnSend.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get btnSend;

  /// No description provided for @btnReceive.
  ///
  /// In en, this message translates to:
  /// **'Receive'**
  String get btnReceive;

  /// No description provided for @btnAddGroup.
  ///
  /// In en, this message translates to:
  /// **'Add Group'**
  String get btnAddGroup;

  /// No description provided for @btnAddBill.
  ///
  /// In en, this message translates to:
  /// **'Add Bill'**
  String get btnAddBill;

  /// No description provided for @apyYieldPercentage.
  ///
  /// In en, this message translates to:
  /// **'5% APY'**
  String get apyYieldPercentage;

  /// No description provided for @onlyUSDCAllowed.
  ///
  /// In en, this message translates to:
  /// **'Only send USDC to this address.'**
  String get onlyUSDCAllowed;

  /// No description provided for @walletAddress.
  ///
  /// In en, this message translates to:
  /// **'Wallet Address'**
  String get walletAddress;

  /// No description provided for @network.
  ///
  /// In en, this message translates to:
  /// **'Network'**
  String get network;

  /// No description provided for @networkDefault.
  ///
  /// In en, this message translates to:
  /// **'Lisk Sepolia Testnet (ERC20)'**
  String get networkDefault;

  /// No description provided for @myGroups.
  ///
  /// In en, this message translates to:
  /// **'My Groups'**
  String get myGroups;

  /// No description provided for @ongoingExpenses.
  ///
  /// In en, this message translates to:
  /// **'Ongoing Expenses'**
  String get ongoingExpenses;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @btnSeeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get btnSeeAll;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @settingWallet.
  ///
  /// In en, this message translates to:
  /// **'My Wallet'**
  String get settingWallet;

  /// No description provided for @settingWalletDesc.
  ///
  /// In en, this message translates to:
  /// **'Manage your Web3 wallet'**
  String get settingWalletDesc;

  /// No description provided for @settingAppearance.
  ///
  /// In en, this message translates to:
  /// **'App Appearance'**
  String get settingAppearance;

  /// No description provided for @settingAppearanceDesc.
  ///
  /// In en, this message translates to:
  /// **'Choose app appearance'**
  String get settingAppearanceDesc;

  /// No description provided for @colorScheme.
  ///
  /// In en, this message translates to:
  /// **'Color Scheme'**
  String get colorScheme;

  /// No description provided for @colorSchemeDesc.
  ///
  /// In en, this message translates to:
  /// **'Switch from light to dark mode and vice versa, or let GathrFi match your device settings.'**
  String get colorSchemeDesc;

  /// No description provided for @colorSchemeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get colorSchemeSystem;

  /// No description provided for @colorSchemeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get colorSchemeLight;

  /// No description provided for @colorSchemeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get colorSchemeDark;

  /// No description provided for @usdSymbol.
  ///
  /// In en, this message translates to:
  /// **'\$'**
  String get usdSymbol;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;
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
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
