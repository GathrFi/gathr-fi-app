import 'package:flutter/material.dart';

import '../../../data/models/group/group.dart';
import '../../../shared/assets/assets.gen.dart';
import '../../../shared/assets/colors.gen.dart';
import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/extensions/ext_misc.dart';
import '../../../shared/extensions/ext_theme.dart';
import '../../../shared/widgets/global_stacked_avatars.dart';

class GroupCard extends StatelessWidget {
  const GroupCard({super.key, required this.groupWithProfiles});
  final GroupWithProfiles groupWithProfiles;

  @override
  Widget build(BuildContext context) {
    final group = groupWithProfiles.group;
    final memberProfiles = groupWithProfiles.memberProfiles;
    final memberProfileImages = memberProfiles.values
        .map((memberProfile) => memberProfile.image.orEmpty)
        .toList();

    return InkWell(
      onTap: () {},
      borderRadius: context.spacingXlg.borderRadius,
      child: Container(
        width: 200.0,
        padding: EdgeInsets.all(context.spacingSm),
        decoration: BoxDecoration(
          borderRadius: context.spacingXlg.borderRadius,
          border: Border.all(
            color: switch (context.brightness) {
              Brightness.light => ColorName.border,
              Brightness.dark => ColorName.borderDark,
            },
          ),
        ),
        child: Column(
          spacing: context.spacingXs,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(context.spacingXs),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: switch (context.brightness) {
                    Brightness.light => ColorName.border,
                    Brightness.dark => ColorName.borderDark,
                  },
                ),
              ),
              child: Assets.icons.icGroup.icon(
                context,
                color: ColorName.textSecondary,
                size: context.spacingXlg,
              ),
            ),
            Text(
              group.name.orDefault,
              style: context.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            GlobalStackedAvatars(imageUrls: memberProfileImages),
          ],
        ),
      ),
    );
  }
}
