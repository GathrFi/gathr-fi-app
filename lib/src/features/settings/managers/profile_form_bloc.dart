import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/user/user_profile.dart';
import '../../../data/repositories/auth/user_profile_repository.dart';
import '../../../shared/utils/result.dart';

part 'profile_form_event.dart';
part 'profile_form_state.dart';
part 'profile_form_bloc.freezed.dart';

@injectable
class ProfileFormBloc extends Bloc<ProfileFormEvent, ProfileFormState> {
  final UserProfileRepository profileRepository;
  ProfileFormBloc(this.profileRepository) : super(const _ProfileFormState()) {
    on<_Update>((event, emit) {
      emit(state.copyWith(userProfile: event.userProfile));
    });

    on<_CheckUsername>((event, emit) async {
      final username = state.userProfile.username;
      if (username == null || username.isEmpty) return;

      emit(state.copyWith(isLoading: true));
      final result = await profileRepository.checkUsername(username);

      switch (result) {
        case Ok<bool>():
          emit(state.copyWith(isUsernameAvailable: result.value));
        case Error<bool>():
          emit(state.copyWith(isUsernameAvailable: false));
      }

      emit(state.copyWith(isLoading: false));
    });
  }
}
