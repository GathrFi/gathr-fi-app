import 'package:flutter/material.dart';

import '../../../shared/assets/assets.gen.dart';
import '../../../shared/assets/colors.gen.dart';
import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/extensions/ext_misc.dart';
import '../../../shared/extensions/ext_theme.dart';

class GroupUtilityTooltip extends StatelessWidget {
  const GroupUtilityTooltip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.spacingSm,
        vertical: context.spacingXxs,
      ),
      decoration: BoxDecoration(
        color: switch (context.brightness) {
          Brightness.light => Colors.grey.shade50,
          Brightness.dark => Colors.grey.shade900,
        },
        borderRadius: context.spacingSm.borderRadius,
      ),
      child: Row(
        spacing: context.spacingMd,
        children: [
          Assets.images.imgGroup.image(width: 80),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.groupTooltip,
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  context.l10n.groupTooltipDesc,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: ColorName.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
