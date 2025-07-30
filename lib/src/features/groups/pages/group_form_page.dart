import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../shared/assets/colors.gen.dart';
import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/extensions/ext_misc.dart';
import '../../../shared/widgets/global_scaffold.dart';

@RoutePage()
class GroupFormPage extends StatefulWidget {
  const GroupFormPage({super.key});

  @override
  State<GroupFormPage> createState() => _GroupFormPageState();
}

class _GroupFormPageState extends State<GroupFormPage> {
  @override
  Widget build(BuildContext context) {
    return GlobalScaffold(
      appBarTitle: Text(context.l10n.btnAddGroup),
      body: Padding(
        padding: EdgeInsets.all(context.spacingXlg),
        child: const Column(
          children: [
            Placeholder(color: ColorName.border),
            Placeholder(color: ColorName.border),
            Placeholder(color: ColorName.border),
          ],
        ),
      ),
    );
  }
}
