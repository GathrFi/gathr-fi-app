import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/extensions/ext_misc.dart';
import '../../../shared/widgets/global_scaffold.dart';

@RoutePage()
class SettingAppearancePage extends StatefulWidget {
  const SettingAppearancePage({super.key});

  @override
  State<SettingAppearancePage> createState() => _SettingAppearancePageState();
}

class _SettingAppearancePageState extends State<SettingAppearancePage> {
  @override
  Widget build(BuildContext context) {
    return GlobalScaffold(
      appBarTitle: Text(context.l10n.settingAppearance),
      body: Padding(
        padding: EdgeInsets.all(context.spacingXlg),
        child: Column(
          spacing: context.spacingMd,
          children: [
            const Placeholder(),
            const Placeholder(),
            const Placeholder(),
          ],
        ),
      ),
    );
  }
}
