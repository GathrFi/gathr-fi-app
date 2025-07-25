import 'package:flutter/material.dart';

import '../assets/colors.gen.dart';
import '../extensions/ext_dimens.dart';
import '../extensions/ext_theme.dart';

enum GlobalButtonStyle { filled, outlined, text }

enum GlobalButtonSize { small, large }

class GlobalButton extends StatelessWidget {
  const GlobalButton.filled({
    super.key,
    required this.onTap,
    required this.child,
    this.size = GlobalButtonSize.small,
    this.foregroundColor,
    this.backgroundColor,
  }) : style = GlobalButtonStyle.filled,
       outlineColor = null;

  const GlobalButton.outlined({
    super.key,
    required this.onTap,
    required this.child,
    this.size = GlobalButtonSize.small,
    this.foregroundColor,
    this.outlineColor,
  }) : style = GlobalButtonStyle.outlined,
       backgroundColor = Colors.transparent;

  const GlobalButton.text({
    super.key,
    required this.onTap,
    required this.child,
    this.size = GlobalButtonSize.small,
    this.foregroundColor = ColorName.textPrimary,
  }) : style = GlobalButtonStyle.text,
       backgroundColor = null,
       outlineColor = null;

  final VoidCallback? onTap;
  final GlobalButtonStyle style;
  final GlobalButtonSize size;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? outlineColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final buttonShape = RoundedRectangleBorder(
      borderRadius: context.spacingSm.borderRadius,
    );

    final buttonPadding = switch (size) {
      GlobalButtonSize.small => EdgeInsets.symmetric(
        horizontal: context.spacingMd,
        vertical: context.spacingXs,
      ),
      GlobalButtonSize.large => EdgeInsets.symmetric(
        horizontal: context.spacingXlg,
        vertical: context.spacingMd,
      ),
    };

    switch (style) {
      case GlobalButtonStyle.filled:
        return FilledButton(
          onPressed: onTap,
          style: FilledButton.styleFrom(
            textStyle: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            foregroundColor: foregroundColor ?? Colors.white,
            backgroundColor:
                backgroundColor ??
                switch (Theme.brightnessOf(context)) {
                  Brightness.dark => ColorName.primary,
                  Brightness.light => ColorName.surfaceDark,
                },
            padding: buttonPadding,
            shape: buttonShape,
          ),
          child: child,
        );

      case GlobalButtonStyle.outlined:
        return OutlinedButton(
          onPressed: onTap,
          style: OutlinedButton.styleFrom(
            textStyle: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            foregroundColor:
                foregroundColor ??
                switch (Theme.brightnessOf(context)) {
                  Brightness.dark => ColorName.primary,
                  Brightness.light => ColorName.surfaceDark,
                },
            side: BorderSide(
              color:
                  outlineColor ??
                  switch (Theme.brightnessOf(context)) {
                    Brightness.dark => ColorName.primary,
                    Brightness.light => ColorName.surfaceDark,
                  },
            ),
            padding: buttonPadding,
            shape: buttonShape,
          ),
          child: child,
        );
      case GlobalButtonStyle.text:
        return TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            textStyle: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            foregroundColor:
                foregroundColor ??
                switch (Theme.brightnessOf(context)) {
                  Brightness.dark => ColorName.primary,
                  Brightness.light => ColorName.surfaceDark,
                },
            padding: buttonPadding,
            shape: buttonShape,
          ),
          child: child,
        );
    }
  }
}

enum GlobalCircleButtonStyle { filled, outlined }

class GlobalCircleButton extends StatelessWidget {
  const GlobalCircleButton.filled({
    super.key,
    required this.onTap,
    required this.child,
  }) : style = GlobalCircleButtonStyle.filled;

  const GlobalCircleButton.outlined({
    super.key,
    required this.onTap,
    required this.child,
  }) : style = GlobalCircleButtonStyle.outlined;

  final GlobalCircleButtonStyle style;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final adaptiveColor = switch (context.brightness) {
      Brightness.dark => ColorName.textPrimaryDark,
      Brightness.light => ColorName.textPrimary,
    };

    return FilledButton(
      onPressed: onTap,
      style: FilledButton.styleFrom(
        foregroundColor: adaptiveColor,
        backgroundColor: style == GlobalCircleButtonStyle.filled
            ? adaptiveColor.withValues(alpha: 0.1)
            : Colors.transparent,
        side: style == GlobalCircleButtonStyle.outlined
            ? BorderSide(
                color: switch (context.brightness) {
                  Brightness.dark => ColorName.borderDark,
                  Brightness.light => ColorName.border,
                },
              )
            : null,
        minimumSize: Size(context.spacingLg * 2.5, context.spacingLg * 2.5),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.all(context.spacingXxs),
        shape: const CircleBorder(),
      ),
      child: child,
    );
  }
}
