part of 'group_form_bloc.dart';

@freezed
class GroupFormEvent with _$GroupFormEvent {
  const factory GroupFormEvent.updateName(String name) = _UpdateName;
  const factory GroupFormEvent.addMember(UserProfile member) = _AddMember;
  const factory GroupFormEvent.removeMember(int index) = _RemoveMember;
}
