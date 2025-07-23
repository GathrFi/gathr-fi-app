import 'package:auto_route/auto_route.dart';
import 'features/onboarding/pages/onboarding_page.dart';

part 'gathrfi_app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class GathrfiAppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(path: '/onboarding', page: OnboardingRoute.page, initial: true),
  ];
}
