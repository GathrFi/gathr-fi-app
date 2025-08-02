import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../gathrfi_app_router.dart';
import '../../../shared/assets/assets.gen.dart';
import '../../../shared/assets/colors.gen.dart';
import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/extensions/ext_misc.dart';
import '../../../shared/extensions/ext_theme.dart';

class BalanceView extends StatelessWidget {
  const BalanceView({
    super.key,
    this.customLabel,
    required this.amount,
    this.showShortcuts = true,
  });

  final String? customLabel;
  final double? amount;
  final bool showShortcuts;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: context.spacingMd,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          spacing: context.spacingXs,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              customLabel ?? context.l10n.yourBalance,
              style: context.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
                color: ColorName.textSecondary,
              ),
            ),
            Row(
              spacing: context.spacingXs,
              children: [
                Flexible(
                  child: Skeletonizer(
                    enabled: amount == null,
                    child: amount != null
                        ? Text(
                            amount!.toCurrency(),
                            style: context.textTheme.displayMedium,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          )
                        : Bone.text(
                            style: context.textTheme.displayMedium,
                            words: 1,
                          ),
                  ),
                ),
                Assets.images.imgBrandUsdcSvg.svg(
                  width: context.spacingXlg,
                  height: context.spacingXlg,
                ),
              ],
            ),
          ],
        ),
        if (showShortcuts)
          Row(
            spacing: context.spacingMd,
            children: [
              Flexible(
                child: _ShortcutButton(
                  onTap: () => context.pushRoute(const TrxSendFundsRoute()),
                  icon: Assets.icons.icArrowSend,
                  label: context.l10n.btnSend,
                  color: ColorName.orange,
                ),
              ),
              Flexible(
                child: _ShortcutButton(
                  onTap: () => context.pushRoute(const TrxReceiveFundsRoute()),
                  icon: Assets.icons.icArrowReceive,
                  label: context.l10n.btnReceive,
                  color: ColorName.blue,
                ),
              ),
              Flexible(
                child: _ShortcutButton(
                  onTap: () => context.pushRoute(const ExpensesFormRoute()),
                  icon: Assets.icons.icReceipt,
                  label: context.l10n.btnAddBill,
                  color: ColorName.secondary,
                ),
              ),
            ],
          ),
      ],
    );
  }
}

class _ShortcutButton extends StatelessWidget {
  const _ShortcutButton({
    required this.onTap,
    required this.icon,
    required this.label,
    required this.color,
  });

  final VoidCallback onTap;
  final SvgGenImage icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: context.spacingXs,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onTap,
          splashColor: color.withAlpha((0.1 * 255).round()),
          customBorder: const CircleBorder(),
          child: Container(
            padding: EdgeInsets.all(context.spacingMd),
            decoration: BoxDecoration(
              border: Border.all(color: color),
              shape: BoxShape.circle,
            ),
            child: icon.icon(context, size: context.spacingMd * 2),
          ),
        ),
        Text(label),
      ],
    );
  }
}
