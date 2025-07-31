import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../gathrfi_app_di.dart';
import '../../../shared/assets/colors.gen.dart';
import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/widgets/global_shimmer.dart';
import '../managers/group_list_bloc.dart';
import 'group_card.dart';

class GroupListView extends StatefulWidget {
  const GroupListView({super.key});

  @override
  State<GroupListView> createState() => _GroupListViewState();
}

class _GroupListViewState extends State<GroupListView> {
  late final GroupListBloc _groupListBloc;

  @override
  void initState() {
    _groupListBloc = locator<GroupListBloc>();
    _groupListBloc.add(const GroupListEvent.get());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GroupListBloc>(
      create: (context) => _groupListBloc,
      child: BlocBuilder<GroupListBloc, GroupListState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => GlobalShimmer(width: context.deviceWidth),
            loaded: (items) {
              return SizedBox(
                height: 150.0,
                child: ListView.separated(
                  shrinkWrap: true,
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return GroupCard(groupWithProfiles: items[index]);
                  },
                  separatorBuilder: (context, index) {
                    return context.spacingSm.hSpace;
                  },
                ),
              );
            },
            error: (e) {
              return const Placeholder(
                color: ColorName.border,
                fallbackHeight: 100,
              );
            },
          );
        },
      ),
    );
  }
}
