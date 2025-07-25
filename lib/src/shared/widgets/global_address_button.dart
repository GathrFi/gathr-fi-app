import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../assets/assets.gen.dart';
import '../assets/colors.gen.dart';
import '../extensions/ext_dimens.dart';
import '../extensions/ext_misc.dart';
import '../extensions/ext_overlays.dart';
import '../extensions/ext_theme.dart';

class GlobalAddressButton extends StatelessWidget {
  const GlobalAddressButton({super.key, required this.address});
  final String? address;

  @override
  Widget build(BuildContext context) {
    print(address);
    return Skeletonizer(
      enabled: address == null,
      child: Text.rich(
        TextSpan(
          text: address.toShortAddress(),
          style: context.textTheme.titleLarge,
          children: [
            if (address != null)
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Padding(
                  padding: EdgeInsets.only(left: context.spacingXs),
                  child: SizedBox(
                    width: context.spacingMd * 2,
                    height: context.spacingMd * 2,
                    child: IconButton(
                      onPressed: () async {
                        await Clipboard.setData(ClipboardData(text: address!));
                        if (context.mounted) {
                          context.showToast(
                            message: context.l10n.addressCopied,
                          );
                        }
                      },
                      padding: EdgeInsets.zero,
                      icon: Assets.icons.icCopy.icon(
                        context,
                        color: ColorName.textSecondary,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
