import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../extensions/ext_dimens.dart';
import '../extensions/ext_theme.dart';

class GlobalShimmer extends StatelessWidget {
  const GlobalShimmer({super.key, this.width, this.height});

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: context.spacingSm.borderRadius,
      child: Skeletonizer(
        enabled: true,
        effect: PulseEffect(
          from: switch (context.brightness) {
            Brightness.dark => Colors.grey.shade900,
            Brightness.light => Colors.grey.shade200,
          }.withAlpha((0.4 * 255).round()),
          to: switch (context.brightness) {
            Brightness.dark => Colors.grey.shade900,
            Brightness.light => Colors.grey.shade200,
          }.withAlpha((0.6 * 255).round()),
        ),
        child: Container(
          width: width ?? 100.0,
          height: height ?? 100.0,
          color: switch (context.brightness) {
            Brightness.dark => Colors.grey.shade900,
            Brightness.light => Colors.grey.shade200,
          },
        ),
      ),
    );
  }
}
