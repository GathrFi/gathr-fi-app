import 'package:auto_route/auto_route.dart';
import 'features/home/pages/home_page.dart';
import 'features/onboarding/pages/onboarding_page.dart';
import 'features/onboarding/pages/splash_page.dart';

part 'gathrfi_app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class GathrfiAppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(path: '/splash', page: SplashRoute.page, initial: true),
    AutoRoute(path: '/onboarding', page: OnboardingRoute.page),
    AutoRoute(path: '/home', page: HomeRoute.page),
  ];
}
