import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/group/group.dart';
import '../../../data/repositories/groups/groups_repository.dart';
import '../../../shared/utils/result.dart';

part 'group_ops_event.dart';
part 'group_ops_state.dart';
part 'group_ops_bloc.freezed.dart';

@injectable
class GroupOpsBloc extends Bloc<GroupOpsEvent, GroupOpsState> {
  final GroupsRepository repository;
  GroupOpsBloc(this.repository) : super(const _Initial()) {
    on<GroupOpsEvent>((event, emit) async {
      emit(const _Loading());
      final result = await repository.addGroup(event.group);

      switch (result) {
        case Ok<String>():
          emit(_Success(result.value));
        case Error<String>():
          emit(_Error(e: result.error));
      }
    });
  }
}
