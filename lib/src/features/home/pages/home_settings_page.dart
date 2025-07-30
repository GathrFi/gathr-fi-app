import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web3auth_flutter/input.dart';
import 'package:web3auth_flutter/web3auth_flutter.dart';

import '../../../data/services/web3/web3_service.dart';
import '../../../gathrfi_app_router.dart';
import '../../../shared/assets/assets.gen.dart';
import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/extensions/ext_misc.dart';
import '../../../shared/extensions/ext_overlays.dart';
import '../../../shared/widgets/global_divider.dart';
import '../../../shared/widgets/global_menu_tile.dart';
import '../../../shared/widgets/global_scaffold.dart';
import '../../onboarding/managers/auth_bloc.dart';

@RoutePage()
class HomeSettingsPage extends StatelessWidget {
  const HomeSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          loading: () => context.showLoading(),
          authenticated: () => context.closeOverlay(),
          error: (e) {
            context.closeOverlay();
            context.showToast(message: e.toString());
          },
        );
      },
      child: GlobalScaffold(
        appBarTitle: Text(context.l10n.settings),
        body: Padding(
          padding: EdgeInsets.all(context.spacingXlg),
          child: Column(
            // spacing: context.spacingMd,
            children: [
              GlobalMenuTile(
                onTap: () async {
                  await Web3AuthFlutter.launchWalletServices(
                    ChainConfig(
                      chainId: Web3Service.network.chainId.toString(),
                      rpcTarget: Web3Service.network.rpcEndpoint,
                      blockExplorerUrl: Web3Service.network.blockExplorer,
                      displayName: Web3Service.network.name,
                      tickerName: Web3Service.network.name,
                      ticker: Web3Service.network.currencySymbol,
                      logo: Web3Service.network.logo,
                    ),
                  );
                },
                isDense: true,
                iconPath: Assets.icons.icWalletAlt.path,
                title: context.l10n.settingWallet,
                subtitle: context.l10n.settingWalletDesc,
              ),
              const GlobalDivider(),
              GlobalMenuTile(
                onTap: () {
                  context.pushRoute(const SettingAppearanceRoute());
                },
                isDense: true,
                iconPath: Assets.icons.icPalette.path,
                title: context.l10n.settingAppearance,
                subtitle: context.l10n.settingAppearanceDesc,
              ),
              const GlobalDivider(),
              GlobalMenuTile(
                onTap: () {
                  context.read<AuthBloc>().add(const AuthEvent.logout());
                },
                iconPath: Assets.icons.icPower.path,
                iconColor: Colors.red,
                title: context.l10n.logout,
              ),
              const GlobalDivider(),
            ],
          ),
        ),
      ),
    );
  }
}
