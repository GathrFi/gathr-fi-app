import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../shared/assets/colors.gen.dart';
import '../../../shared/extensions/ext_dimens.dart';

@RoutePage()
class HomeWalletPage extends StatelessWidget {
  const HomeWalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(context.spacingMd).copyWith(
          // top: (kToolbarHeight * 2) + (context.spacingMd * 4),
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
