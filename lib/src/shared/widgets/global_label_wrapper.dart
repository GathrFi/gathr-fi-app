import 'package:flutter/material.dart';

import '../extensions/ext_dimens.dart';
import '../extensions/ext_theme.dart';

class GlobalLabelWrapper extends StatelessWidget {
  const GlobalLabelWrapper({
    required this.label,
    this.labelStyle,
    this.spacing,
    required this.child,
    super.key,
  });

  final String label;
  final TextStyle? labelStyle;
  final double? spacing;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: spacing ?? context.spacingXs,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: labelStyle ?? context.textTheme.titleMedium,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        child,
      ],
    );
  }
}
