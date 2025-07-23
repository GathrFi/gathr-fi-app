import 'dart:ui';

import 'package:flutter/material.dart';

import '../assets/colors.gen.dart';
import '../extensions/ext_dimens.dart';

class GlobalBlurBackdrop extends StatelessWidget {
  const GlobalBlurBackdrop({
    required this.child,
    super.key,
    this.color = ColorName.surface,
    this.opacity = 0.7,
    this.borderRadius,
  });

  final Color color;
  final double opacity;
  final BorderRadiusGeometry? borderRadius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: context.spacingXlg,
          sigmaY: context.spacingXlg,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(color: (color).withValues(alpha: opacity)),
          child: child,
        ),
      ),
    );
  }
}
