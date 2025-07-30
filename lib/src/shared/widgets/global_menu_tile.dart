import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../assets/colors.gen.dart';
import '../extensions/ext_dimens.dart';
import '../extensions/ext_theme.dart';

class GlobalMenuTile extends StatelessWidget {
  const GlobalMenuTile({
    super.key,
    this.onTap,
    required this.iconPath,
    this.iconColor,
    required this.title,
    this.subtitle,
    this.isDense = false,
  });

  final VoidCallback? onTap;
  final String iconPath;
  final Color? iconColor;
  final String title;
  final String? subtitle;
  final bool isDense;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        onTap: onTap,
        title: Text(title),
        titleTextStyle: context.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w700,
        ),
        subtitle: subtitle != null ? Text(subtitle!) : null,
        subtitleTextStyle: context.textTheme.bodyMedium?.copyWith(
          color: ColorName.textSecondary,
        ),
        leading: SvgPicture.asset(
          iconPath,
          width: context.spacingXlg,
          height: context.spacingXlg,
          colorFilter: iconColor != null
              ? ColorFilter.mode(iconColor!, BlendMode.srcIn)
              : null,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: context.spacingXs),
        visualDensity: isDense ? const VisualDensity(vertical: -4) : null,
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          size: context.spacingMd,
        ),
        tileColor: switch (context.brightness) {
          Brightness.light => ColorName.surface,
          Brightness.dark => ColorName.surfaceDark,
        },
        splashColor: switch (context.brightness) {
          Brightness.dark => Colors.grey.shade900,
          Brightness.light => Colors.grey.shade50,
        },
      ),
    );
  }
}
