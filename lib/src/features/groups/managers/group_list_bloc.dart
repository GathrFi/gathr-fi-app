import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/group/group.dart';
import '../../../data/repositories/groups/groups_repository.dart';
import '../../../shared/utils/result.dart';

part 'group_list_event.dart';
part 'group_list_state.dart';
part 'group_list_bloc.freezed.dart';

@injectable
class GroupListBloc extends Bloc<GroupListEvent, GroupListState> {
  final GroupsRepository repository;
  GroupListBloc(this.repository) : super(const _Initial()) {
    on<_Get>((event, emit) async {
      emit(const _Loading());
      final result = await repository.getList();

      switch (result) {
        case Ok<List<GroupWithProfiles>>():
          emit(_Loaded(result.value));
        case Error<List<GroupWithProfiles>>():
          emit(_Error(e: result.error));
      }
    });
  }
}
