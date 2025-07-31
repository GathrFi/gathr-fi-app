import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/user/user_profile.dart';
import '../../../data/repositories/auth/user_profile_repository.dart';
import '../../../shared/utils/result.dart';

part 'profile_search_event.dart';
part 'profile_search_state.dart';
part 'profile_search_bloc.freezed.dart';

@injectable
class ProfileSearchBloc extends Bloc<ProfileSearchEvent, ProfileSearchState> {
  final UserProfileRepository repository;
  ProfileSearchBloc(this.repository) : super(const _Initial()) {
    on<_Search>((event, emit) async {
      if (event.query.isEmpty) {
        emit(const _Initial());
        return;
      }

      emit(const _Loading());
      final result = await repository.search(event.query);

      switch (result) {
        case Ok<List<UserProfile>>():
          emit(_Loaded(profiles: result.value));
        case Error<List<UserProfile>>():
          emit(_Error(e: result.error));
      }
    });

    on<_Select>((event, emit) {
      if (state is _Loaded) {
        final currentState = state as _Loaded;
        final selectedProfile = currentState.profiles[event.index];
        emit(currentState.copyWith(selectedProfile: selectedProfile));
      }
    });

    on<_Clear>((event, emit) => emit(const _Initial()));
  }
}
