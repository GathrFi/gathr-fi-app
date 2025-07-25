import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../gathrfi_app_router.dart';
import '../../../shared/assets/assets.gen.dart';
import '../../../shared/assets/colors.gen.dart';
import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/extensions/ext_misc.dart';
import '../../../shared/extensions/ext_theme.dart';
import '../../../shared/widgets/global_blur_backdrop.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _activeIndex = 0;
  final _routes = const [
    HomeDashboardRoute(),
    HomeWalletRoute(),
    HomeSettingsRoute(),
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.router.addListener(_onRouteChanged);
      _onRouteChanged();
    });
    super.initState();
  }

  @override
  void dispose() {
    context.router.removeListener(_onRouteChanged);
    super.dispose();
  }

  void _onRouteChanged() {
    final routePath = context.router.currentPath;

    if (routePath.contains('/home/dashboard')) {
      _updateActiveIndex(0);
    } else if (routePath.contains('/home/wallet')) {
      _updateActiveIndex(1);
    } else if (routePath.contains('/home/settings')) {
      _updateActiveIndex(2);
    }
  }

  void _updateActiveIndex(int index) {
    if (_activeIndex != index) {
      setState(() => _activeIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: const AutoRouter(),
      bottomNavigationBar: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GlobalBlurBackdrop(
              opacity: 0.2,
              color: switch (context.brightness) {
                Brightness.dark => ColorName.surface,
                Brightness.light => ColorName.surfaceDark,
              },
              borderRadius: BorderRadius.circular(100),
              child: Padding(
                padding: EdgeInsets.all(context.spacingXxs),
                child: Row(
                  spacing: context.spacingXs,
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(_routes.length, (index) {
                    final isActive = _activeIndex == index;
                    final iconAsset = switch (index) {
                      1 => Assets.icons.icWallet,
                      2 => Assets.icons.icSetting,
                      _ => Assets.icons.icHome,
                    };

                    return InkWell(
                      onTap: () => _onTap(context, index),
                      child: AnimatedContainer(
                        curve: Curves.easeInOut,
                        duration: const Duration(milliseconds: 300),
                        padding: EdgeInsets.all(context.spacingLg),
                        decoration: BoxDecoration(
                          color: isActive
                              ? ColorName.primary
                              : switch (context.brightness) {
                                  Brightness.dark => ColorName.surfaceDark,
                                  Brightness.light => ColorName.surface,
                                },
                          shape: BoxShape.circle,
                        ),
                        child: iconAsset.icon(
                          context,
                          size: context.spacingLg * 2,
                          color: isActive
                              ? ColorName.surface
                              : switch (context.brightness) {
                                  Brightness.dark => ColorName.surface,
                                  Brightness.light => ColorName.surfaceDark,
                                },
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    setState(() => _activeIndex = index);
    context.replaceRoute(switch (index) {
      1 => const HomeWalletRoute(),
      2 => const HomeSettingsRoute(),
      _ => const HomeDashboardRoute(),
    });
  }
}
