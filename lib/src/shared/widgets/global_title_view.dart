import 'package:flutter/material.dart';

import '../assets/colors.gen.dart';
import '../extensions/ext_dimens.dart';
import '../extensions/ext_misc.dart';
import '../extensions/ext_theme.dart';

class GlobalTitleView extends StatelessWidget {
  const GlobalTitleView({super.key, required this.title, this.onSeeAllTap});

  final String title;
  final VoidCallback? onSeeAllTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: context.spacingMd,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            title,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        InkWell(
          onTap: onSeeAllTap,
          splashColor: ColorName.primary.withAlpha((0.1 * 255).round()),
          customBorder: const StadiumBorder(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: context.spacingXxs,
              horizontal: context.spacingXs,
            ),
            child: Text(
              context.l10n.btnSeeAll,
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: ColorName.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
