import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../shared/assets/assets.gen.dart';
import '../../../shared/assets/colors.gen.dart';
import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/extensions/ext_misc.dart';
import '../../../shared/utils/debounce.dart';
import '../../../shared/widgets/global_label_wrapper.dart';
import '../managers/profile_form_bloc.dart';

class ProfileFormView extends StatefulWidget {
  const ProfileFormView({super.key});

  @override
  State<ProfileFormView> createState() => _ProfileFormViewState();
}

class _ProfileFormViewState extends State<ProfileFormView> {
  final _usernameController = TextEditingController();
  final _debounce = Debounce(milliseconds: 500);

  @override
  void dispose() {
    _usernameController.dispose();
    _debounce.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileFormBloc, ProfileFormState>(
      listenWhen: (prev, curr) =>
          prev.userProfile.username != curr.userProfile.username,
      listener: (context, state) {
        context.read<ProfileFormBloc>().add(
          const ProfileFormEvent.checkUsername(),
        );
      },
      builder: (context, state) {
        final username = state.userProfile.username.orEmpty;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GlobalLabelWrapper(
              label: context.l10n.iUsernameLabel,
              child: TextField(
                controller: _usernameController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                  LengthLimitingTextInputFormatter(20),
                ],
                decoration: InputDecoration(
                  hintText: context.l10n.iUsernameHint,
                  errorText:
                      username.isNotEmpty &&
                          !state.isLoading &&
                          !state.isUsernameAvailable
                      ? context.l10n.iUsernameError
                      : null,
                  suffixIcon: state.isLoading
                      ? SizedBox(
                          width: context.spacingXlg,
                          height: context.spacingXlg,
                          child: Center(
                            child: SpinKitFadingCircle(
                              color: ColorName.border,
                              size: context.spacingXlg,
                            ),
                          ),
                        )
                      : username.orEmpty.isNotEmpty
                      ? SizedBox(
                          width: context.spacingXlg,
                          height: context.spacingXlg,
                          child: Center(
                            child: state.isUsernameAvailable
                                ? Assets.icons.icTick.icon(
                                    context,
                                    color: Colors.green,
                                  )
                                : Assets.icons.icCross.icon(
                                    context,
                                    color: Colors.red,
                                  ),
                          ),
                        )
                      : const SizedBox(),
                ),
                onChanged: (value) {
                  _debounce.run(() {
                    context.read<ProfileFormBloc>().add(
                      ProfileFormEvent.update(
                        state.userProfile.copyWith(username: value),
                      ),
                    );
                  });
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
