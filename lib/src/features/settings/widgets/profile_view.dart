import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../shared/assets/assets.gen.dart';
import '../../../shared/assets/colors.gen.dart';
import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/extensions/ext_misc.dart';
import '../../../shared/extensions/ext_theme.dart';
import '../../../shared/widgets/global_address_button.dart';
import '../managers/profile_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        final userInfo = state.mapOrNull(loaded: (value) => value.userInfo);
        final userAddress = state.mapOrNull(
          loaded: (value) => value.userAddress,
        );

        return Row(
          spacing: context.spacingMd,
          mainAxisSize: MainAxisSize.min,
          children: [
            Skeletonizer(
              enabled: userInfo == null,
              child: userInfo != null
                  ? ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: userInfo.profileImage.orEmpty,
                        height: context.spacingXlg * 2,
                        width: context.spacingXlg * 2,
                        errorWidget: (context, url, error) {
                          return Container(
                            padding: EdgeInsets.all(context.spacingXs),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: switch (context.brightness) {
                                  Brightness.dark => ColorName.borderDark,
                                  Brightness.light => ColorName.border,
                                }.withValues(alpha: 0.7),
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Assets.icons.icUser.icon(
                              context,
                              color: ColorName.textSecondary,
                            ),
                          );
                        },
                      ),
                    )
                  : Container(
                      height: context.spacingXlg * 2,
                      width: context.spacingXlg * 2,
                      decoration: const BoxDecoration(
                        color: ColorName.border,
                        shape: BoxShape.circle,
                      ),
                    ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Skeletonizer(
                    enabled: userInfo == null,
                    child: Text(
                      context.l10n.greeting((userInfo?.name).orDefault),
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: ColorName.textSecondary,
                      ),
                    ),
                  ),
                  GlobalAddressButton(address: userAddress),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
