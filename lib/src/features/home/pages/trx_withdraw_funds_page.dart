import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/extensions/ext_misc.dart';
import '../../../shared/widgets/global_scaffold.dart';
import '../../settings/managers/profile_bloc.dart';
import '../widgets/transaction_form_view.dart';

@RoutePage()
class TrxWithdrawFundsPage extends StatefulWidget {
  const TrxWithdrawFundsPage({super.key});

  @override
  State<TrxWithdrawFundsPage> createState() => _TrxWithdrawFundsPageState();
}

class _TrxWithdrawFundsPageState extends State<TrxWithdrawFundsPage> {
  @override
  Widget build(BuildContext context) {
    return GlobalScaffold(
      appBarTitle: Text(context.l10n.btnWithdraw),
      body: Padding(
        padding: EdgeInsets.all(context.spacingXlg),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            final userProfile = state.whenOrNull(
              loaded: (userProfile) => userProfile,
            );

            return TransactionFormView.withdraw(
              balance: userProfile?.balance,
              onSubmitted: (amount) {},
            );
          },
        ),
      ),
    );
  }
}
