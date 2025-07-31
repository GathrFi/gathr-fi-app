import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../gathrfi_app_di.dart';
import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/extensions/ext_misc.dart';
import '../../../shared/extensions/ext_overlays.dart';
import '../../../shared/widgets/global_scaffold.dart';
import '../../settings/managers/profile_bloc.dart';
import '../managers/transactions_bloc.dart';
import '../widgets/transaction_form_view.dart';

@RoutePage()
class TrxDepositFundsPage extends StatefulWidget {
  const TrxDepositFundsPage({super.key});

  @override
  State<TrxDepositFundsPage> createState() => _TrxDepositFundsPageState();
}

class _TrxDepositFundsPageState extends State<TrxDepositFundsPage> {
  late final TransactionsBloc _transactionsBloc;

  @override
  void initState() {
    _transactionsBloc = locator<TransactionsBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionsBloc>(
      create: (context) => _transactionsBloc,
      child: BlocListener<TransactionsBloc, TransactionsState>(
        listener: (context, state) {
          state.whenOrNull(
            loading: () => context.showLoading(),
            success: (txHash) => context.closeOverlay(),
            error: (e) {
              context.closeOverlay();
              context.showToast(message: e.toString());
            },
          );
        },
        child: GlobalScaffold(
          appBarTitle: Text(context.l10n.btnDeposit),
          body: Padding(
            padding: EdgeInsets.all(context.spacingXlg),
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                final userProfile = state.whenOrNull(
                  loaded: (userProfile) => userProfile,
                );

                return TransactionFormView.deposit(
                  balance: userProfile?.walletBalance,
                  onSubmitted: (amount) {
                    _transactionsBloc.add(TransactionsEvent.deposit(amount));
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
