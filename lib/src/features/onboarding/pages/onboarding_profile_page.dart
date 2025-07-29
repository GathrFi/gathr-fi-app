import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/extensions/ext_misc.dart';
import '../../../shared/widgets/global_button.dart';
import '../../../shared/widgets/global_scaffold.dart';
import '../../settings/widgets/profile_form_view.dart';

@RoutePage()
class OnboardingProfilePage extends StatefulWidget {
  const OnboardingProfilePage({super.key});

  @override
  State<OnboardingProfilePage> createState() => _OnboardingProfilePageState();
}

class _OnboardingProfilePageState extends State<OnboardingProfilePage> {
  @override
  Widget build(BuildContext context) {
    return GlobalScaffold(
      appBarTitle: Text(context.l10n.createProfile),
      body: Padding(
        padding: EdgeInsets.all(context.spacingXlg),
        child: const ProfileFormView(),
      ),
      bottomWidget: GlobalButton.filled(
        onTap: () {},
        size: GlobalButtonSize.large,
        child: Text(context.l10n.btnContinue),
      ),
    );
  }
}
