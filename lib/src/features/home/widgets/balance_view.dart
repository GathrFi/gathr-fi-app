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
    this.showAPYStats = true,
    this.showShortcuts = true,
  });

  final String? customLabel;
  final double? amount;
  final bool showAPYStats;
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
                Assets.images.imgBrandUsdcSvg.svg(width: context.spacingXlg),
              ],
            ),
            if (showAPYStats)
              Row(
                spacing: context.spacingXs,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.spacingSm,
                      vertical: context.spacingXxs,
                    ),
                    decoration: BoxDecoration(
                      color: switch (context.brightness) {
                        Brightness.dark => Colors.grey.shade900,
                        Brightness.light => Colors.grey.shade100,
                      },
                      borderRadius: (context.spacingMd * 2).borderRadius,
                    ),
                    child: Row(
                      spacing: context.spacingXs,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Assets.images.imgBrandAave.svg(
                          width: context.spacingXlg,
                          colorFilter: switch (context.brightness) {
                            Brightness.light => null,
                            Brightness.dark => const ColorFilter.mode(
                              ColorName.surface,
                              BlendMode.srcIn,
                            ),
                          },
                        ),
                        Text(
                          context.l10n.apyYieldPercentage,
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '+${1256.80.toCurrency()}',
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: switch (context.brightness) {
                        Brightness.light => Colors.green.shade700,
                        Brightness.dark => Colors.green,
                      },
                      fontWeight: FontWeight.w500,
                    ),
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
                  onTap: () => context.pushRoute(const TrxWithdrawFundsRoute()),
                  icon: Assets.icons.icArrowSend,
                  label: context.l10n.btnWithdraw,
                  color: ColorName.orange,
                ),
              ),
              Flexible(
                child: _ShortcutButton(
                  onTap: () => context.pushRoute(const TrxDepositFundsRoute()),
                  icon: Assets.icons.icArrowReceive,
                  label: context.l10n.btnDeposit,
                  color: ColorName.blue,
                ),
              ),
              Flexible(
                child: _ShortcutButton(
                  onTap: () => context.pushRoute(const GroupFormRoute()),
                  icon: Assets.icons.icGroup,
                  label: context.l10n.btnAddGroup,
                  color: ColorName.secondary,
                ),
              ),
              Flexible(
                child: _ShortcutButton(
                  onTap: () => context.pushRoute(const ExpensesFormRoute()),
                  icon: Assets.icons.icReceipt,
                  label: context.l10n.btnAddBill,
                  color: ColorName.yellow,
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
