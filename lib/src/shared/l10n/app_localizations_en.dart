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
  String get iUsernameError => 'Taken! Try being even cooler.';

  @override
  String get btnContinue => 'Continue';

  @override
  String greeting(String name) {
    return 'Hello, $name!';
  }

  @override
  String get addressCopied => 'Address copied to clipboard!';

  @override
  String get yourBalance => 'Your Balance';

  @override
  String get yourWalletBalance => 'Your Wallet Balance';

  @override
  String get apyYieldPercentage => '5% APY';

  @override
  String get btnSend => 'Send';

  @override
  String get btnReceive => 'Receive';

  @override
  String get iSendLabel => 'Amount to Send';

  @override
  String get iAmountHint => '0.00';

  @override
  String get iAmountExceedError => 'Amount exceeds your available balance.';

  @override
  String get iRecipientLabel => 'Recipient Address';

  @override
  String get iRecipientHint => '0x1a2b...3c4d';

  @override
  String get btnPaste => 'Paste';

  @override
  String get onlyUSDCAllowed => 'Only send USDC to this address.';

  @override
  String get walletAddress => 'Wallet Address';

  @override
  String get network => 'Network';

  @override
  String get networkDefault => 'Lisk Sepolia Testnet (ERC20)';

  @override
  String get btnAddGroup => 'Add Group';

  @override
  String get groupTooltip => 'Why create a group?';

  @override
  String get groupTooltipDesc =>
      'Easily split bills with your friends, no need to re-add them each time.';

  @override
  String get iGroupNameLabel => 'Group Name';

  @override
  String get iGroupNameHint => 'e.g. Weekend Trip, Office Lunch';

  @override
  String get iGroupMembersLabel => 'Group Members';

  @override
  String get iGroupMembersHint => 'e.g. @alice, @bob, @calista';

  @override
  String get searching => 'Searching...';

  @override
  String get btnAddBill => 'Add Bill';

  @override
  String get myGroups => 'My Groups';

  @override
  String get ongoingExpenses => 'Ongoing Bills';

  @override
  String get iDescriptionLabel => 'Description';

  @override
  String get iDescriptionHint => 'e.g. Dinner at Sushi Bar';

  @override
  String get history => 'History';

  @override
  String get btnSeeAll => 'See All';

  @override
  String get settings => 'Settings';

  @override
  String get transactionSuccess => 'Transaction successful';

  @override
  String get btnView => 'View';

  @override
  String get settingWallet => 'My Wallet';

  @override
  String get settingWalletDesc => 'Manage your Web3 wallet';

  @override
  String get settingAppearance => 'App Appearance';

  @override
  String get settingAppearanceDesc => 'Choose app appearance';

  @override
  String get colorScheme => 'Color Scheme';

  @override
  String get colorSchemeDesc =>
      'Switch from light to dark mode and vice versa, or let GathrFi match your device settings.';

  @override
  String get colorSchemeSystem => 'System';

  @override
  String get colorSchemeLight => 'Light';

  @override
  String get colorSchemeDark => 'Dark';

  @override
  String get usdSymbol => '\$';

  @override
  String get logout => 'Logout';
}
