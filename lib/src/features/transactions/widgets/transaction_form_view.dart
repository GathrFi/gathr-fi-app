import 'package:flutter/material.dart';

import '../../../shared/assets/assets.gen.dart';
import '../../../shared/assets/colors.gen.dart';
import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/extensions/ext_misc.dart';
import '../../../shared/extensions/ext_theme.dart';
import '../../../shared/utils/formatter.dart';
import '../../../shared/widgets/global_button.dart';
import '../../../shared/widgets/global_label_wrapper.dart';
import '../../home/widgets/balance_view.dart';

enum TransactionFormViewType { withdraw, deposit }

class TransactionFormView extends StatefulWidget {
  const TransactionFormView.withdraw({
    super.key,
    required this.controller,
    required this.balance,
    required this.onSubmitted,
  }) : type = TransactionFormViewType.withdraw;

  const TransactionFormView.deposit({
    super.key,
    required this.controller,
    required this.balance,
    required this.onSubmitted,
  }) : type = TransactionFormViewType.deposit;

  final double? balance;
  final TextEditingController controller;
  final Function(double amount) onSubmitted;
  final TransactionFormViewType type;

  @override
  State<TransactionFormView> createState() => _TransactionFormViewState();
}

class _TransactionFormViewState extends State<TransactionFormView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: context.spacingMd,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BalanceView(
          customLabel: context.l10n.yourWalletBalance,
          amount: widget.balance,
          showAPYStats: false,
          showShortcuts: false,
        ),
        GlobalLabelWrapper(
          label: switch (widget.type) {
            TransactionFormViewType.withdraw => context.l10n.iWithdrawLabel,
            TransactionFormViewType.deposit => context.l10n.iDepositLabel,
          },
          labelStyle: context.textTheme.bodyLarge?.copyWith(
            color: ColorName.textSecondary,
            fontWeight: FontWeight.w500,
          ),
          child: Row(
            children: [
              Text(
                context.l10n.usdSymbol,
                style: context.textTheme.displayMedium,
              ),
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  style: context.textTheme.displayMedium,
                  inputFormatters: [CurrencyInputFormatter()],
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    hintText: context.l10n.iAmountHint,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    hintStyle: context.textTheme.displayMedium?.copyWith(
                      color: ColorName.textSecondary.withAlpha(
                        (0.4 * 255).round(),
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    if (value.toDouble() <= 0) {
                      widget.controller.clear();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        ValueListenableBuilder(
          valueListenable: widget.controller,
          builder: (context, value, child) {
            final balance = widget.balance ?? 0;
            final amount = value.text.toDouble();

            return AnimatedSwitcher(
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              duration: const Duration(milliseconds: 300),
              child: amount > balance
                  ? Row(
                      spacing: context.spacingXxs,
                      children: [
                        Assets.icons.icInfo.icon(context, color: Colors.red),
                        Flexible(
                          child: Text(
                            context.l10n.iAmountExceedError,
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            );
          },
        ),
        ValueListenableBuilder(
          valueListenable: widget.controller,
          builder: (context, value, child) {
            final balance = widget.balance ?? 0;
            final amount = value.text.toDouble();

            return SizedBox(
              width: context.deviceWidth,
              child: GlobalButton.filled(
                onTap: amount > 0 && amount <= balance
                    ? () => widget.onSubmitted(amount)
                    : null,
                size: GlobalButtonSize.large,
                child: Text(context.l10n.btnContinue),
              ),
            );
          },
        ),
      ],
    );
  }
}
