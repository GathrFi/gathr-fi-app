import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../gathrfi_app_di.dart';
import '../../../shared/assets/colors.gen.dart';
import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/extensions/ext_misc.dart';
import '../../../shared/extensions/ext_overlays.dart';
import '../../../shared/extensions/ext_theme.dart';
import '../../../shared/widgets/global_amount_field.dart';
import '../../../shared/widgets/global_button.dart';
import '../../../shared/widgets/global_error_message.dart';
import '../../../shared/widgets/global_label_wrapper.dart';
import '../../../shared/widgets/global_scaffold.dart';
import '../../home/widgets/balance_view.dart';
import '../../settings/managers/profile_bloc.dart';
import '../managers/tx_form_bloc.dart';
import '../managers/tx_ops_bloc.dart';

@RoutePage()
class TrxSendFundsPage extends StatefulWidget {
  const TrxSendFundsPage({super.key});

  @override
  State<TrxSendFundsPage> createState() => _TrxSendFundsPageState();
}

class _TrxSendFundsPageState extends State<TrxSendFundsPage> {
  final _recipientController = TextEditingController();
  final _amountController = TextEditingController();

  late final TxFormBloc _txFormBloc;
  late final TxOpsBloc _txOpsBloc;

  @override
  void initState() {
    _txFormBloc = locator<TxFormBloc>();
    _txOpsBloc = locator<TxOpsBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _recipientController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TxFormBloc>(create: (context) => _txFormBloc),
        BlocProvider<TxOpsBloc>(create: (context) => _txOpsBloc),
      ],
      child: BlocListener<TxOpsBloc, TxOpsState>(
        listener: (context, state) {
          state.whenOrNull(
            loading: () => context.showLoading(),
            success: (txHash) {
              context.closeOverlay();
              context.showTxSuccessToast(txHash: txHash);
              context.read<ProfileBloc>().add(const ProfileEvent.load());
              _recipientController.clear();
              _amountController.clear();
            },
            error: (e) {
              context.closeOverlay();
              context.showToast(message: e.toString());
            },
          );
        },
        child: GlobalScaffold(
          appBarTitle: Text(context.l10n.btnSend),
          body: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              final balance = state.maybeWhen(
                loaded: (userProfile) => userProfile.balance ?? 0.0,
                orElse: () => 0.0,
              );

              return BlocBuilder<TxFormBloc, TxFormState>(
                builder: (context, state) {
                  return Padding(
                    padding: EdgeInsets.all(context.spacingXlg),
                    child: Column(
                      spacing: context.spacingMd,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BalanceView(
                          customLabel: context.l10n.yourBalance,
                          amount: balance,
                          showShortcuts: false,
                        ),
                        GlobalAmountField(
                          label: context.l10n.iSendLabel,
                          controller: _amountController,
                          onChanged: (value) {
                            _txFormBloc.add(TxFormEvent.changeAmount(value));
                          },
                        ),
                        AnimatedSwitcher(
                          switchInCurve: Curves.easeIn,
                          switchOutCurve: Curves.easeOut,
                          duration: const Duration(milliseconds: 300),
                          child: state.amount <= balance
                              ? const SizedBox()
                              : GlobalErrorMessage(
                                  message: context.l10n.iAmountExceedError,
                                ),
                        ),
                        GlobalLabelWrapper(
                          label: context.l10n.iRecipientLabel,
                          labelStyle: context.textTheme.bodyLarge?.copyWith(
                            color: ColorName.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                          child: TextField(
                            controller: _recipientController,
                            decoration: InputDecoration(
                              hintText: context.l10n.iRecipientHint,
                              suffixIcon: GlobalButton.text(
                                onTap: () {},
                                foregroundColor: ColorName.textSecondary,
                                child: Text(context.l10n.btnPaste),
                              ),
                            ),
                            onChanged: (value) {
                              _txFormBloc.add(
                                TxFormEvent.changeRecipient(value),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: context.deviceWidth,
                          child: GlobalButton.filled(
                            onTap:
                                state.recipient.isNotEmpty &&
                                    state.amount > 0 &&
                                    state.amount <= balance
                                ? () => _txOpsBloc.add(
                                    TxOpsEvent.send(
                                      recipient: state.recipient,
                                      amount: state.amount,
                                    ),
                                  )
                                : null,
                            size: GlobalButtonSize.large,
                            child: Text(context.l10n.btnContinue),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
