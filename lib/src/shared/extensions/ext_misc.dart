import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../assets/assets.gen.dart';
import '../assets/colors.gen.dart';
import '../l10n/app_localizations.dart';
import '../l10n/app_localizations_en.dart';

extension MiscX on BuildContext {
  AppLocalizations get l10n {
    return AppLocalizations.of(this) ?? AppLocalizationsEn();
  }
}

extension SvgX on SvgGenImage {
  SvgPicture icon(BuildContext context, {double? size, Color? color}) {
    return this.svg(
      colorFilter: ColorFilter.mode(
        color ??
            switch (Theme.brightnessOf(context)) {
              Brightness.dark => ColorName.surface,
              Brightness.light => ColorName.surfaceDark,
            },
        BlendMode.srcIn,
      ),
      height: size,
      width: size,
    );
  }
}

extension NullableStringX on String? {
  String get orEmpty => this ?? '';
  String get orDefault => this ?? '-';
  String toShortAddress({int prefixLength = 7, int suffixLength = 5}) {
    if (this == null) return '0x0';
    if (this!.length <= prefixLength + suffixLength) return this!;

    final prefix = this!.substring(0, prefixLength);
    final suffix = this!.substring(this!.length - suffixLength);
    return '$prefix...$suffix';
  }
}
