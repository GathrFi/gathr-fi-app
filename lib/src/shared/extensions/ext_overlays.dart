import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:toastification/toastification.dart';

import '../assets/assets.gen.dart';
import '../assets/colors.gen.dart';
import '../widgets/global_button.dart';
import 'ext_dimens.dart';
import 'ext_misc.dart';
import 'ext_theme.dart';

extension OverlaysX on BuildContext {
  Future<T?> showSheet<T>({
    required Widget Function(BuildContext) builder,
    Color? backgroundColor,
    bool useRootNavigator = false,
    bool isScrollControlled = false,
    bool isDismissible = true,
  }) {
    if (Platform.isIOS) {
      return showCupertinoSheet<T>(
        context: this,
        pageBuilder: builder,
        enableDrag: isDismissible,
      );
    }

    return showModalBottomSheet<T>(
      context: this,
      useSafeArea: true,
      useRootNavigator: useRootNavigator,
      backgroundColor: backgroundColor ?? Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.vertical(top: spacingMd.radius),
      ),
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      builder: builder,
    );
  }

  Future<T?> showLoading<T>() {
    return showDialog(
      context: this,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (context) {
        return SpinKitFadingCircle(
          color: ColorName.surface,
          size: spacingXlg * 2,
        );
      },
    );
  }

  void showToast({
    required String message,
    String? desc,
    TextStyle? textStyle,
    TextStyle? descTextStyle,
    Duration duration = const Duration(seconds: 5),
    bool alwaysShow = false,
    EdgeInsetsGeometry? padding,
    Color? bgColor,
    Color? fgColor,
    Widget? actionWidget,
  }) {
    final backgroundColor = switch (brightness) {
      Brightness.dark => bgColor ?? ColorName.surface,
      Brightness.light => bgColor ?? ColorName.surfaceDark,
    };

    final foregroundColor = switch (brightness) {
      Brightness.dark => fgColor ?? ColorName.surfaceDark,
      Brightness.light => fgColor ?? ColorName.surface,
    };

    toastification.showCustom(
      alignment: Alignment.bottomCenter,
      autoCloseDuration: alwaysShow ? null : duration,
      animationDuration: const Duration(milliseconds: 300),
      builder: (context, holder) => Center(
        child: Container(
          margin: EdgeInsets.only(bottom: context.spacingMd),
          padding:
              padding ??
              EdgeInsets.symmetric(
                horizontal: context.spacingLg,
                vertical: context.spacingSm,
              ),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: context.spacingSm.borderRadius,
            boxShadow: [
              BoxShadow(
                color: backgroundColor.withValues(alpha: 0.07),
                offset: Offset(0, spacingXxs),
                spreadRadius: 5,
                blurRadius: 10,
              ),
            ],
          ),
          child: Row(
            spacing: context.spacingXs,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Assets.icons.icInfo.icon(context, color: foregroundColor),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message,
                      style:
                          textStyle ??
                          context.textTheme.bodyLarge?.copyWith(
                            color: foregroundColor,
                          ),
                    ),
                    if (desc != null)
                      Text(
                        desc,
                        style:
                            descTextStyle ??
                            context.textTheme.bodyLarge?.copyWith(
                              color: foregroundColor.withAlpha(
                                (0.7 * 255).round(),
                              ),
                            ),
                      ),
                  ],
                ),
              ),
              actionWidget ?? const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  void showTxSuccessToast({required String txHash}) {
    showToast(
      message: l10n.transactionSuccess,
      desc: txHash.toShortAddress(),
      padding: EdgeInsets.symmetric(
        horizontal: spacingXs,
        vertical: spacingXxs,
      ),
      actionWidget: Padding(
        padding: EdgeInsets.only(left: spacingMd),
        child: GlobalButton.filled(
          onTap: () {},
          backgroundColor: ColorName.green,
          foregroundColor: ColorName.surfaceDark,
          child: Text(l10n.btnView),
        ),
      ),
    );
  }

  void dismissToast() => toastification.dismissAll();

  void closeOverlay<T>({T? result, bool useRootNavigator = false}) {
    return Navigator.of(this, rootNavigator: useRootNavigator).pop(result);
  }
}
