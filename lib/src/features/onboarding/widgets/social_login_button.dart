import 'package:flutter/material.dart';

import '../../../shared/widgets/global_button.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.darkIcon,
  });

  final VoidCallback onTap;
  final Widget icon;
  final Widget darkIcon;

  @override
  Widget build(BuildContext context) {
    return GlobalCircleButton.filled(
      onTap: onTap,
      child: switch (Theme.brightnessOf(context)) {
        Brightness.light => icon,
        Brightness.dark => darkIcon,
      },
    );
  }
}
