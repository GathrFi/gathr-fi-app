import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/group/group.dart';
import '../../../data/models/user/user_profile.dart';

part 'group_form_event.dart';
part 'group_form_state.dart';
part 'group_form_bloc.freezed.dart';

@injectable
class GroupFormBloc extends Bloc<GroupFormEvent, GroupFormState> {
  GroupFormBloc() : super(const _GroupFormState()) {
    on<_UpdateName>((event, emit) {
      emit(state.copyWith(group: state.group.copyWith(name: event.name)));
    });

    on<_AddMember>((event, emit) {
      final members = List<UserProfile>.from(state.group.members ?? []);
      members.add(event.member);

      emit(state.copyWith(group: state.group.copyWith(members: members)));
    });

    on<_RemoveMember>((event, emit) {
      final members = List<UserProfile>.from(state.group.members ?? []);
      members.removeAt(event.index);

      emit(state.copyWith(group: state.group.copyWith(members: members)));
    });
  }
}
