import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../shared/assets/colors.gen.dart';
import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/extensions/ext_misc.dart';
import '../../../shared/widgets/global_scaffold.dart';

@RoutePage()
class ExpensesFormPage extends StatefulWidget {
  const ExpensesFormPage({super.key});

  @override
  State<ExpensesFormPage> createState() => _ExpensesFormPageState();
}

class _ExpensesFormPageState extends State<ExpensesFormPage> {
  @override
  Widget build(BuildContext context) {
    return GlobalScaffold(
      appBarTitle: Text(context.l10n.btnAddBill),
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
