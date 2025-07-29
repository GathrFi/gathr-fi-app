import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/assets/colors.gen.dart';
import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/extensions/ext_misc.dart';
import '../../../shared/widgets/global_button.dart';
import '../../onboarding/managers/auth_bloc.dart';

@RoutePage()
class HomeSettingsPage extends StatelessWidget {
  const HomeSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.settings)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(context.spacingMd).copyWith(
          // top: (kToolbarHeight * 2) + (context.spacingMd * 4),
          bottom: kBottomNavigationBarHeight + (context.spacingXlg * 4),
        ),
        child: Column(
          spacing: context.spacingMd,
          children: [
            GlobalButton.filled(
              onTap: () {
                context.read<AuthBloc>().add(const AuthEvent.logout());
              },
              child: Text(context.l10n.logout),
            ),
            const Placeholder(color: ColorName.border),
            const Placeholder(color: ColorName.border),
            const Placeholder(color: ColorName.border),
          ],
        ),
      ),
    );
  }
}
