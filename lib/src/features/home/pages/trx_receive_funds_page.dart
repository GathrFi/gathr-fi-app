import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../../../shared/assets/assets.gen.dart';
import '../../../shared/assets/colors.gen.dart';
import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/extensions/ext_misc.dart';
import '../../../shared/extensions/ext_overlays.dart';
import '../../../shared/extensions/ext_theme.dart';
import '../../../shared/widgets/global_label_wrapper.dart';
import '../../../shared/widgets/global_scaffold.dart';
import '../../settings/managers/profile_bloc.dart';

@RoutePage()
class TrxReceiveFundsPage extends StatefulWidget {
  const TrxReceiveFundsPage({super.key});

  @override
  State<TrxReceiveFundsPage> createState() => _TrxReceiveFundsPageState();
}

class _TrxReceiveFundsPageState extends State<TrxReceiveFundsPage> {
  @override
  Widget build(BuildContext context) {
    return GlobalScaffold(
      appBarTitle: Text(context.l10n.btnReceive),
      body: Padding(
        padding: EdgeInsets.all(context.spacingXlg),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            final userAddress = state.mapOrNull(
              loaded: (value) => value.userAddress,
            );

            return Column(
              spacing: context.spacingMd,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: PrettyQrView.data(
                      data: userAddress.orEmpty,
                      decoration: PrettyQrDecoration(
                        image: PrettyQrDecorationImage(
                          image: Assets.images.imgBrandUsdcPng.image().image,
                          padding: EdgeInsets.all(context.spacingXlg),
                        ),
                        quietZone: PrettyQrQuietZone.standart,
                        shape: PrettyQrSmoothSymbol(
                          roundFactor: 0.0,
                          color: switch (context.brightness) {
                            Brightness.dark => ColorName.surface,
                            Brightness.light => ColorName.surfaceDark,
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.spacingMd,
                    vertical: context.spacingSm,
                  ),
                  decoration: BoxDecoration(
                    color: ColorName.yellow.withAlpha((0.2 * 255).round()),
                    border: Border.all(color: ColorName.yellow),
                    borderRadius: context.spacingSm.borderRadius,
                  ),
                  child: Row(
                    spacing: context.spacingXs,
                    children: [
                      Assets.icons.icInfo.icon(context),
                      Flexible(child: Text(context.l10n.onlyUSDCAllowed)),
                    ],
                  ),
                ),
                GlobalLabelWrapper(
                  label: context.l10n.walletAddress,
                  labelStyle: context.textTheme.titleMedium?.copyWith(
                    color: ColorName.textSecondary,
                  ),
                  spacing: context.spacingXxs,
                  child: Row(
                    spacing: context.spacingXlg * 2,
                    children: [
                      Flexible(
                        child: Text(
                          userAddress.orDefault,
                          style: context.textTheme.bodyLarge,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await Clipboard.setData(
                            ClipboardData(text: userAddress.orEmpty),
                          );

                          if (context.mounted) {
                            context.showToast(
                              message: context.l10n.addressCopied,
                            );
                          }
                        },
                        icon: Assets.icons.icCopy.icon(
                          context,
                          size: context.spacingMd * 2,
                          color: ColorName.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                GlobalLabelWrapper(
                  label: context.l10n.network,
                  labelStyle: context.textTheme.titleMedium?.copyWith(
                    color: ColorName.textSecondary,
                  ),
                  spacing: context.spacingXxs,
                  child: Text(
                    context.l10n.networkDefault,
                    style: context.textTheme.bodyLarge,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
