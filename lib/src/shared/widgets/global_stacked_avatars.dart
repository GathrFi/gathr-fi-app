import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../assets/assets.gen.dart';
import '../assets/colors.gen.dart';
import '../extensions/ext_misc.dart';
import '../extensions/ext_theme.dart';

class GlobalStackedAvatars extends StatelessWidget {
  const GlobalStackedAvatars({
    super.key,
    required this.imageUrls,
    this.radius = 18.0,
    this.overlap = 32.0,
    this.maxVisible = 3,
  });

  final List<String> imageUrls;
  final double radius;
  final double overlap;
  final int maxVisible;

  @override
  Widget build(BuildContext context) {
    final visibleImages = imageUrls.take(maxVisible).toList();
    final remainingCount = imageUrls.length - maxVisible;

    return SizedBox(
      width: (visibleImages.length - 1) * overlap + radius * 2,
      height: radius * 2,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ...visibleImages
              .asMap()
              .entries
              .map((entry) {
                final index = entry.key;
                final imageUrl = entry.value;
                return Positioned(
                  left: index * overlap,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: switch (context.brightness) {
                          Brightness.light => ColorName.surface,
                          Brightness.dark => ColorName.surfaceDark,
                        },
                        width: 2.0,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: radius,
                      backgroundImage: CachedNetworkImageProvider(imageUrl),
                      backgroundColor: Colors.grey.shade200,
                      child: imageUrl.isEmpty
                          ? Assets.icons.icUser.icon(context)
                          : null,
                    ),
                  ),
                );
              })
              .toList()
              .reversed,
          if (remainingCount > 0)
            Positioned(
              left: (visibleImages.length) * overlap,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: switch (context.brightness) {
                      Brightness.light => ColorName.surface,
                      Brightness.dark => ColorName.surfaceDark,
                    },
                    width: 2.0,
                  ),
                ),
                child: CircleAvatar(
                  radius: radius,
                  backgroundColor: switch (context.brightness) {
                    Brightness.light => Colors.grey.shade200,
                    Brightness.dark => Colors.grey.shade800,
                  },
                  child: Text(
                    '+$remainingCount',
                    style: TextStyle(
                      color: switch (context.brightness) {
                        Brightness.light => ColorName.surfaceDark,
                        Brightness.dark => ColorName.surface,
                      },
                      fontWeight: FontWeight.bold,
                      fontSize: radius * 0.6,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
