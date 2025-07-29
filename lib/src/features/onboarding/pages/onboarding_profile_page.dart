import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../gathrfi_app_di.dart';
import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/extensions/ext_misc.dart';
import '../../../shared/extensions/ext_overlays.dart';
import '../../../shared/widgets/global_button.dart';
import '../../../shared/widgets/global_scaffold.dart';
import '../../settings/managers/profile_bloc.dart';
import '../../settings/managers/profile_form_bloc.dart';
import '../../settings/widgets/profile_form_view.dart';

@RoutePage()
class OnboardingProfilePage extends StatefulWidget {
  const OnboardingProfilePage({super.key});

  @override
  State<OnboardingProfilePage> createState() => _OnboardingProfilePageState();
}

class _OnboardingProfilePageState extends State<OnboardingProfilePage> {
  late final ProfileFormBloc _profileFormBloc;

  @override
  void initState() {
    final userProfileState = context.read<ProfileBloc>().state;
    final userProfile = userProfileState.mapOrNull(
      loaded: (value) => value.userProfile,
    );

    _profileFormBloc = locator<ProfileFormBloc>();
    if (userProfile != null) {
      _profileFormBloc.add(ProfileFormEvent.update(userProfile));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileFormBloc>(
      create: (context) => _profileFormBloc,
      child: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          state.whenOrNull(
            loading: () => context.showLoading(),
            loaded: (_, _, _, _) => context.closeOverlay(),
            error: (e) {
              context.closeOverlay();
              context.showToast(message: e.toString());
            },
          );
        },
        child: GlobalScaffold(
          appBarTitle: Text(context.l10n.createProfile),
          body: Padding(
            padding: EdgeInsets.all(context.spacingXlg),
            child: const ProfileFormView(),
          ),
          bottomWidget: BlocBuilder<ProfileFormBloc, ProfileFormState>(
            builder: (context, state) {
              final isProfileComplete = state.userProfile.isComplete;
              final isUsernameAvailable = state.isUsernameAvailable;

              return GlobalButton.filled(
                onTap: isProfileComplete && isUsernameAvailable
                    ? () {
                        context.read<ProfileBloc>().add(
                          ProfileEvent.update(state.userProfile),
                        );
                      }
                    : null,
                size: GlobalButtonSize.large,
                child: Text(context.l10n.btnContinue),
              );
            },
          ),
        ),
      ),
    );
  }
}
