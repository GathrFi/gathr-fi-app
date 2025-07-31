part of 'group_form_bloc.dart';

@freezed
abstract class GroupFormState with _$GroupFormState {
  const factory GroupFormState({@Default(Group()) Group group}) =
      _GroupFormState;
}
