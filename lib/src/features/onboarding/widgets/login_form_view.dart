import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/assets/assets.gen.dart';
import '../../../shared/assets/colors.gen.dart';
import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/extensions/ext_misc.dart';
import '../../../shared/extensions/ext_theme.dart';
import '../../../shared/widgets/global_button.dart';
import '../../../shared/widgets/global_label_wrapper.dart';
import '../managers/auth_bloc.dart';
import 'social_login_button.dart';

class LoginFormView extends StatefulWidget {
  const LoginFormView({super.key, this.onFocusChanged});
  final ValueChanged<bool>? onFocusChanged;

  @override
  State<LoginFormView> createState() => _LoginFormViewState();
}

class _LoginFormViewState extends State<LoginFormView> {
  final _emailController = TextEditingController();
  final _emailFocusNode = FocusNode();

  @override
  void initState() {
    _emailFocusNode.addListener(() {
      if (widget.onFocusChanged != null) {
        widget.onFocusChanged!(_emailFocusNode.hasFocus);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: context.spacingMd,
      children: [
        GlobalLabelWrapper(
          label: context.l10n.iEmailAddressLabel,
          child: TextField(
            controller: _emailController,
            focusNode: _emailFocusNode,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: context.l10n.iEmailAddressHint,
            ),
          ),
        ),
        SizedBox(
          width: context.deviceWidth,
          child: GlobalButton.filled(
            onTap: () => context.read<AuthBloc>().add(
              AuthEvent.loginWithEmail(_emailController.text),
            ),
            size: GlobalButtonSize.large,
            child: Text(context.l10n.btnLogin),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Divider(
                height: 0,
                color: switch (Theme.brightnessOf(context)) {
                  Brightness.dark => ColorName.borderDark,
                  Brightness.light => ColorName.border,
                },
                indent: context.spacingMd,
                endIndent: context.spacingMd,
              ),
            ),
            Text(
              context.l10n.otherLoginMethod,
              style: context.textTheme.bodyMedium?.copyWith(
                color: ColorName.textSecondary,
              ),
            ),
            Expanded(
              child: Divider(
                height: 0,
                color: switch (Theme.brightnessOf(context)) {
                  Brightness.dark => ColorName.borderDark,
                  Brightness.light => ColorName.border,
                },
                indent: context.spacingMd,
                endIndent: context.spacingMd,
              ),
            ),
          ],
        ),
        Row(
          spacing: context.spacingMd,
          mainAxisSize: MainAxisSize.min,
          children: [
            SocialLoginButton(
              onTap: () => context.read<AuthBloc>().add(
                const AuthEvent.loginWithGoogle(),
              ),
              icon: Assets.images.imgSocialGoogle.svg(),
              darkIcon: Assets.images.imgSocialGoogleNegative.svg(),
            ),
            SocialLoginButton(
              onTap: () => context.read<AuthBloc>().add(
                const AuthEvent.loginWithApple(),
              ),
              icon: Assets.images.imgSocialApple.svg(),
              darkIcon: Assets.images.imgSocialAppleNegative.svg(),
            ),
            SocialLoginButton(
              onTap: () => context.read<AuthBloc>().add(
                const AuthEvent.loginWithDiscord(),
              ),
              icon: Assets.images.imgSocialDiscord.svg(),
              darkIcon: Assets.images.imgSocialDiscordNegative.svg(),
            ),
          ],
        ),
      ],
    );
  }
}
