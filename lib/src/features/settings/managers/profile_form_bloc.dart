import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/user/user_profile.dart';

part 'profile_form_event.dart';
part 'profile_form_state.dart';
part 'profile_form_bloc.freezed.dart';

@injectable
class ProfileFormBloc extends Bloc<ProfileFormEvent, ProfileFormState> {
  ProfileFormBloc() : super(_ProfileFormState(UserProfile())) {
    on<_Update>((event, emit) {
      emit(state.copyWith(userProfile: event.userProfile));
    });
  }
}
