import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../assets/colors.gen.dart';
import '../extensions/ext_dimens.dart';
import '../extensions/ext_theme.dart';
import 'global_button.dart';

class GlobalSheetWrapper extends StatelessWidget {
  const GlobalSheetWrapper({
    super.key,
    required this.title,
    required this.child,
    this.isChildExpanded = false,
    this.bottom,
  });

  final String title;
  final Widget child;
  final bool isChildExpanded;
  final Widget? bottom;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        color: Platform.isIOS ? ColorName.surface : null,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(context.spacingMd),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: context.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: ColorName.primary,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  GlobalCircleButton.filled(
                    onTap: () => context.maybePop(),
                    child: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            const Divider(height: 0, color: ColorName.border),
            isChildExpanded ? Expanded(child: child) : child,
            if (bottom != null)
              Container(
                padding: EdgeInsets.all(context.spacingMd).copyWith(
                  bottom: Platform.isIOS
                      ? context.spacingXlg * 2
                      : context.spacingMd,
                ),
                decoration: const BoxDecoration(
                  color: ColorName.surface,
                  border: Border(top: BorderSide(color: ColorName.border)),
                ),
                child: SafeArea(child: bottom!),
              ),
          ],
        ),
      ),
    );
  }
}
