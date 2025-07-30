import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../shared/assets/colors.gen.dart';
import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/extensions/ext_misc.dart';
import '../../../shared/widgets/global_scaffold.dart';

@RoutePage()
class HomeHistoryPage extends StatelessWidget {
  const HomeHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalScaffold(
      appBarTitle: Text(context.l10n.history),
      body: Padding(
        padding: EdgeInsets.all(context.spacingXlg),
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
