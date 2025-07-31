import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/user/user_profile.dart';
import '../../../data/repositories/auth/user_profile_repository.dart';
import '../../../shared/utils/result.dart';

part 'profile_event.dart';
part 'profile_state.dart';
part 'profile_bloc.freezed.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserProfileRepository profileRepository;
  ProfileBloc(this.profileRepository) : super(const _Initial()) {
    on<_Load>((event, emit) async {
      emit(const _Loading());
      final result = await profileRepository.get();

      switch (result) {
        case Ok<UserProfile>():
          log(result.value.toString());
          emit(_Loaded(result.value));
        case Error<UserProfile>():
          emit(_Error(e: result.error));
      }
    });

    on<_Update>((event, emit) async {
      emit(const _Loading());
      final result = await profileRepository.update(event.userProfile);

      switch (result) {
        case Ok<bool>():
          add(const _Load());
        case Error<bool>():
          emit(_Error(e: result.error));
      }
    });
  }
}
