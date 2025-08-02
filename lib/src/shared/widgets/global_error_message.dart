import 'package:flutter/material.dart';

import '../assets/assets.gen.dart';
import '../extensions/ext_dimens.dart';
import '../extensions/ext_misc.dart';
import '../extensions/ext_theme.dart';

class GlobalErrorMessage extends StatelessWidget {
  const GlobalErrorMessage({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: context.spacingXxs,
      children: [
        Assets.icons.icInfo.icon(context, color: Colors.red),
        Flexible(
          child: Text(
            message,
            style: context.textTheme.bodyMedium?.copyWith(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
