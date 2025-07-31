import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../data/models/user/user_profile.dart';
import '../../../shared/assets/assets.gen.dart';
import '../../../shared/assets/colors.gen.dart';
import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/extensions/ext_misc.dart';
import '../../../shared/extensions/ext_theme.dart';

class GroupMembersView extends StatelessWidget {
  const GroupMembersView({super.key, required this.members});
  final List<UserProfile> members;

  @override
  Widget build(BuildContext context) {
    if (members.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: context.spacingSm,
      runSpacing: context.spacingSm,
      children: members.map((member) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.spacingXxs,
            vertical: context.spacingXxs,
          ),
          decoration: ShapeDecoration(
            shape: StadiumBorder(
              side: BorderSide(
                color: switch (context.brightness) {
                  Brightness.light => Colors.grey.shade200,
                  Brightness.dark => Colors.grey.shade800,
                },
              ),
            ),
            color: switch (context.brightness) {
              Brightness.light => Colors.grey.shade100,
              Brightness.dark => Colors.grey.shade900,
            },
          ),
          child: Row(
            spacing: context.spacingXs,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipOval(
                child: CachedNetworkImage(
                  imageUrl: member.image.orEmpty,
                  height: context.spacingMd * 2,
                  width: context.spacingMd * 2,
                  errorListener: (value) => log(value.toString()),
                  errorWidget: (context, url, error) {
                    return Padding(
                      padding: EdgeInsets.all(context.spacingXxs / 2),
                      child: Assets.icons.icUser.icon(
                        context,
                        color: ColorName.textSecondary,
                      ),
                    );
                  },
                ),
              ),
              Text(
                member.username.orDefault,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  customBorder: const CircleBorder(),
                  child: Padding(
                    padding: EdgeInsets.all(context.spacingXxs),
                    child: Assets.icons.icCross.icon(context),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
