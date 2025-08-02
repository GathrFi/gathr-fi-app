import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/assets/assets.gen.dart';
import '../../../shared/assets/colors.gen.dart';
import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/extensions/ext_misc.dart';
import '../../../shared/widgets/global_button.dart';
import '../../../shared/widgets/global_scaffold.dart';
import '../../../shared/widgets/global_title_view.dart';
import '../../settings/managers/profile_bloc.dart';
import '../../settings/widgets/profile_view.dart';
import '../widgets/balance_view.dart';

@RoutePage()
class HomeDashboardPage extends StatelessWidget {
  const HomeDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalScaffold(
      appBarHeight: kTextTabBarHeight * 1.5,
      appBarTitle: Row(
        children: [
          const Expanded(child: ProfileView()),
          GlobalCircleButton.outlined(
            child: Assets.icons.icNotification.icon(context),
            onTap: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(context.spacingXlg),
        child: Column(
          spacing: context.spacingXlg,
          children: [
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                return BalanceView(
                  amount: state.whenOrNull(
                    loaded: (profile) => profile.balance,
                  ),
                );
              },
            ),
            Column(
              spacing: context.spacingMd,
              children: [
                GlobalTitleView(
                  title: context.l10n.ongoingExpenses,
                  onSeeAllTap: () {},
                ),
                const Placeholder(
                  color: ColorName.border,
                  fallbackHeight: 200,
                  strokeWidth: 1.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
