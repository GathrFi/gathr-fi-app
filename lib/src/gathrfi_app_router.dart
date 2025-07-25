import 'package:auto_route/auto_route.dart';
import 'features/home/pages/home_dashboard_page.dart';
import 'features/home/pages/home_page.dart';
import 'features/home/pages/home_settings_page.dart';
import 'features/home/pages/home_wallet_page.dart';
import 'features/onboarding/pages/onboarding_page.dart';
import 'features/onboarding/pages/splash_page.dart';

part 'gathrfi_app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class GathrfiAppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(path: '/splash', page: SplashRoute.page, initial: true),
    AutoRoute(path: '/onboarding', page: OnboardingRoute.page),
    AutoRoute(
      path: '/home',
      page: HomeRoute.page,
      children: [
        AutoRoute(path: 'dashboard', page: HomeDashboardRoute.page),
        AutoRoute(path: 'wallet', page: HomeWalletRoute.page),
        AutoRoute(path: 'settings', page: HomeSettingsRoute.page),
        RedirectRoute(path: '*', redirectTo: 'dashboard'),
        RedirectRoute(path: '', redirectTo: 'dashboard'),
      ],
    ),
  ];
}
