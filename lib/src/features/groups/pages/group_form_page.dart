import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../gathrfi_app_di.dart';
import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/extensions/ext_misc.dart';
import '../../../shared/extensions/ext_overlays.dart';
import '../../../shared/utils/debounce.dart';
import '../../../shared/widgets/global_button.dart';
import '../../../shared/widgets/global_label_wrapper.dart';
import '../../../shared/widgets/global_scaffold.dart';
import '../../settings/widgets/profile_search_field.dart';
import '../managers/group_form_bloc.dart';
import '../managers/group_ops_bloc.dart';
import '../widgets/group_members_view.dart';
import '../widgets/group_utility_tooltip.dart';

@RoutePage()
class GroupFormPage extends StatefulWidget {
  const GroupFormPage({super.key});

  @override
  State<GroupFormPage> createState() => _GroupFormPageState();
}

class _GroupFormPageState extends State<GroupFormPage> {
  late final GroupFormBloc _groupFormBloc;
  late final GroupOpsBloc _groupOpsBloc;
  late final Debounce _debounce;

  @override
  void initState() {
    _groupFormBloc = locator<GroupFormBloc>();
    _groupOpsBloc = locator<GroupOpsBloc>();
    _debounce = Debounce(milliseconds: 500);
    super.initState();
  }

  @override
  void dispose() {
    _debounce.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GroupFormBloc>(create: (context) => _groupFormBloc),
        BlocProvider<GroupOpsBloc>(create: (context) => _groupOpsBloc),
      ],
      child: BlocListener<GroupOpsBloc, GroupOpsState>(
        listener: (context, state) {
          state.whenOrNull(
            loading: () => context.showLoading(),
            success: (txHash) {
              context.closeOverlay();
              context.showTxSuccessToast(txHash: txHash);
              context.maybePop();
            },
            error: (e) {
              context.closeOverlay();
              context.showToast(message: e.toString());
            },
          );
        },
        child: BlocBuilder<GroupFormBloc, GroupFormState>(
          builder: (context, state) {
            print(state.group);
            return GlobalScaffold(
              appBarTitle: Text(context.l10n.btnAddGroup),
              body: Padding(
                padding: EdgeInsets.all(context.spacingXlg),
                child: Column(
                  spacing: context.spacingMd,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const GroupUtilityTooltip(),
                    GlobalLabelWrapper(
                      label: context.l10n.iGroupNameLabel,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: context.l10n.iGroupNameHint,
                        ),
                        onChanged: (value) => _debounce.run(() {
                          _groupFormBloc.add(GroupFormEvent.updateName(value));
                        }),
                      ),
                    ),
                    ProfileSearchField(
                      onPicked: (profile) {
                        if (profile == null) return;
                        _groupFormBloc.add(GroupFormEvent.addMember(profile));
                      },
                    ),
                    GroupMembersView(members: state.memberProfiles),
                  ],
                ),
              ),
              bottomWidget: GlobalButton.filled(
                onTap: state.group.isComplete
                    ? () => _groupOpsBloc.add(GroupOpsEvent.add(state.group))
                    : null,
                size: GlobalButtonSize.large,
                child: Text(context.l10n.btnContinue),
              ),
            );
          },
        ),
      ),
    );
  }
}
