import 'package:flutter/material.dart';

import '../assets/colors.gen.dart';
import '../extensions/ext_dimens.dart';
import '../extensions/ext_theme.dart';

class GlobalDivider extends StatelessWidget {
  const GlobalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 0,
      indent: context.spacingXxs,
      endIndent: context.spacingXxs,
      color: switch (context.brightness) {
        Brightness.dark => ColorName.borderDark,
        Brightness.light => ColorName.border,
      },
    );
  }
}
