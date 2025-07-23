import 'package:flutter/material.dart';

import '../extensions/ext_dimens.dart';
import '../extensions/ext_theme.dart';

class GlobalLabelWrapper extends StatelessWidget {
  const GlobalLabelWrapper({
    required this.label,
    required this.child,
    super.key,
  });

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: context.spacingXs,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.textTheme.titleMedium,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        child,
      ],
    );
  }
}
