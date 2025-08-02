import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../shared/assets/assets.gen.dart';
import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/extensions/ext_misc.dart';
import '../../../shared/utils/formatter.dart';
import '../../../shared/widgets/global_label_wrapper.dart';
import '../../../shared/widgets/global_scaffold.dart';
import '../widgets/expense_utility_tooltip.dart';

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
        child: Column(
          spacing: context.spacingMd,
          mainAxisSize: MainAxisSize.min,
          children: [
            const ExpenseUtilityTooltip(),
            GlobalLabelWrapper(
              label: context.l10n.iDescriptionLabel,
              child: TextField(
                decoration: InputDecoration(
                  hintText: context.l10n.iDescriptionHint,
                ),
              ),
            ),
            GlobalLabelWrapper(
              label: 'Total Amount',
              child: TextField(
                inputFormatters: [CurrencyInputFormatter()],
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  hintText: context.l10n.iAmountHint,
                  prefixIcon: SizedBox(
                    width: context.spacingXlg,
                    child: Center(
                      child: Assets.images.imgBrandUsdcSvg.svg(
                        width: context.spacingXlg,
                        height: context.spacingXlg,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
