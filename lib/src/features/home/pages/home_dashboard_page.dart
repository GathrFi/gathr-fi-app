import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../shared/assets/assets.gen.dart';
import '../../../shared/assets/colors.gen.dart';
import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/extensions/ext_misc.dart';
import '../../../shared/widgets/global_blur_backdrop.dart';
import '../../../shared/widgets/global_button.dart';
import '../../settings/widgets/profile_view.dart';

@RoutePage()
class HomeDashboardPage extends StatelessWidget {
  const HomeDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight * 2),
        child: GlobalBlurBackdrop(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(context.spacingMd),
              child: Row(
                children: [
                  const Expanded(child: ProfileView()),
                  GlobalCircleButton.outlined(
                    onTap: () {},
                    child: Assets.icons.icNotification.icon(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(context.spacingMd).copyWith(
          top: (kToolbarHeight * 2) + (context.spacingMd * 4),
          bottom: kBottomNavigationBarHeight + (context.spacingXlg * 4),
        ),
        child: Column(
          spacing: context.spacingMd,
          children: [
            const Placeholder(color: ColorName.border),
            const Placeholder(color: ColorName.border),
            const Placeholder(color: ColorName.border),
          ],
        ),
      ),
    );
  }
}
