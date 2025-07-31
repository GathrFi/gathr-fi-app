import 'package:auto_route/auto_route.dart';
import 'features/expenses/pages/expenses_form_page.dart';
import 'features/groups/pages/group_form_page.dart';
import 'features/home/pages/home_dashboard_page.dart';
import 'features/home/pages/home_page.dart';
import 'features/home/pages/home_settings_page.dart';
import 'features/home/pages/home_history_page.dart';
import 'features/transactions/pages/trx_deposit_funds_page.dart';
import 'features/transactions/pages/trx_withdraw_funds_page.dart';
import 'features/onboarding/pages/onboarding_page.dart';
import 'features/onboarding/pages/onboarding_profile_page.dart';
import 'features/onboarding/pages/splash_page.dart';
import 'features/settings/pages/setting_appearance_page.dart';

part 'gathrfi_app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class GathrfiAppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(path: '/splash', page: SplashRoute.page, initial: true),
    AutoRoute(path: '/onboarding', page: OnboardingRoute.page),
    AutoRoute(path: '/onboarding-profile', page: OnboardingProfileRoute.page),
    AutoRoute(
      path: '/home',
      page: HomeRoute.page,
      children: [
        AutoRoute(path: 'dashboard', page: HomeDashboardRoute.page),
        AutoRoute(path: 'history', page: HomeHistoryRoute.page),
        AutoRoute(path: 'settings', page: HomeSettingsRoute.page),
        RedirectRoute(path: '*', redirectTo: 'dashboard'),
        RedirectRoute(path: '', redirectTo: 'dashboard'),
      ],
    ),
    AutoRoute(
      path: '/group-form',
      page: GroupFormRoute.page,
      fullscreenDialog: true,
    ),
    AutoRoute(
      path: '/expense-form',
      page: ExpensesFormRoute.page,
      fullscreenDialog: true,
    ),
    AutoRoute(
      path: '/withdraw-funds',
      page: TrxWithdrawFundsRoute.page,
      fullscreenDialog: true,
    ),
    AutoRoute(
      path: '/deposit-funds',
      page: TrxDepositFundsRoute.page,
      fullscreenDialog: true,
    ),
    AutoRoute(
      path: '/app-appearance',
      page: SettingAppearanceRoute.page,
      fullscreenDialog: true,
    ),
  ];
}
