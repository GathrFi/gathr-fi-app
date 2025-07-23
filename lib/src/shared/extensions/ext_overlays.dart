import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:toastification/toastification.dart';

import '../assets/colors.gen.dart';
import 'ext_dimens.dart';

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
    TextStyle? textStyle,
    Duration duration = const Duration(seconds: 5),
    bool alwaysShow = false,
  }) {
    toastification.showCustom(
      alignment: Alignment.bottomCenter,
      autoCloseDuration: alwaysShow ? null : duration,
      builder: (context, holder) => Center(
        child: Container(
          margin: EdgeInsets.only(bottom: context.spacingMd),
          padding: EdgeInsets.symmetric(
            horizontal: context.spacingLg,
            vertical: context.spacingMd,
          ),
          decoration: BoxDecoration(
            color: ColorName.surface,
            borderRadius: context.spacingMd.borderRadius,
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.1),
                offset: Offset(0, spacingXxs),
                spreadRadius: 5,
                blurRadius: 10,
              ),
            ],
          ),
          child: Center(child: Text(message, style: textStyle)),
        ),
      ),
    );
  }

  void dismissToast() => toastification.dismissAll();

  void closeOverlay<T>({T? result, bool useRootNavigator = false}) {
    return Navigator.of(this, rootNavigator: useRootNavigator).pop(result);
  }
}
