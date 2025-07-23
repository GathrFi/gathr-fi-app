import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/assets/assets.gen.dart';
import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/extensions/ext_misc.dart';
import '../../settings/managers/theme_bloc.dart';
import '../widgets/login_form_view.dart';

@RoutePage()
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  bool _showImage = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          spacing: context.spacingXs,
          mainAxisSize: MainAxisSize.min,
          children: [
            Assets.images.imgBrand.svg(height: 24.0),
            Text(context.l10n.appName),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.spacingXs),
            child: BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                return IconButton(
                  onPressed: () {
                    context.read<ThemeBloc>().add(
                      const ThemeEvent.toggleMode(),
                    );
                  },
                  icon: switch (state.mode) {
                    ThemeMode.light => Assets.icons.icLightMode,
                    ThemeMode.dark => Assets.icons.icDarkMode,
                    _ => Assets.icons.icAutoMode,
                  }.icon(context, size: context.spacingMd * 2),
                );
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(context.spacingXlg),
          child: Column(
            children: [
              if (_showImage)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(context.spacingMd),
                    child: Assets.images.imgOnboarding.image(),
                  ),
                ),
              LoginFormView(
                onFocusChanged: (hasFocus) {
                  setState(() => _showImage = !hasFocus);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
