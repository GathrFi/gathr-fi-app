import 'package:flutter/material.dart';

import '../assets/colors.gen.dart';
import 'ext_dimens.dart';

extension ThemeX on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  Brightness get brightness => Theme.brightnessOf(this);

  ThemeData get themeData {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: 'Inter',
    ).copyWith(
      primaryColor: ColorName.primary,
      scaffoldBackgroundColor: ColorName.surface,
      appBarTheme: AppBarTheme(
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w500,
          color: ColorName.textPrimary,
        ),
        backgroundColor: ColorName.surface,
        scrolledUnderElevation: 0,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: false,
        contentPadding: EdgeInsets.symmetric(
          horizontal: spacingMd,
          vertical: spacingSm,
        ),
        border: OutlineInputBorder(
          borderRadius: spacingSm.borderRadius,
          borderSide: const BorderSide(color: ColorName.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: spacingSm.borderRadius,
          borderSide: const BorderSide(color: ColorName.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: spacingSm.borderRadius,
          borderSide: const BorderSide(color: ColorName.textPrimary),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: spacingSm.borderRadius,
          borderSide: const BorderSide(color: Colors.red),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: spacingSm.borderRadius,
          borderSide: const BorderSide(color: Colors.red),
        ),
        errorStyle: textTheme.bodyMedium?.copyWith(color: Colors.red),
        hintStyle: textTheme.bodyLarge?.copyWith(
          color: ColorName.textSecondary,
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: ColorName.primary,
        selectionColor: ColorName.primary.withValues(alpha: 0.2),
        selectionHandleColor: ColorName.primary,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle: textTheme.bodySmall,
        selectedLabelStyle: textTheme.bodySmall,
        backgroundColor: ColorName.surface,
        unselectedItemColor: Colors.grey.shade300,
        selectedItemColor: ColorName.primary,
      ),
      dividerColor: ColorName.border,
      popupMenuTheme: PopupMenuThemeData(
        color: ColorName.surface,
        shape: RoundedRectangleBorder(
          borderRadius: spacingXs.borderRadius,
          side: const BorderSide(color: ColorName.border),
        ),
      ),
    );
  }

  ThemeData get darkThemeData {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: 'Inter',
    ).copyWith(
      primaryColor: ColorName.primary,
      scaffoldBackgroundColor: ColorName.surfaceDark,
      appBarTheme: AppBarTheme(
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w500,
          color: ColorName.textPrimaryDark,
        ),
        backgroundColor: ColorName.surfaceDark,
        scrolledUnderElevation: 0,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: false,
        contentPadding: EdgeInsets.symmetric(
          horizontal: spacingMd,
          vertical: spacingSm,
        ),
        border: OutlineInputBorder(
          borderRadius: spacingSm.borderRadius,
          borderSide: const BorderSide(color: ColorName.borderDark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: spacingSm.borderRadius,
          borderSide: const BorderSide(color: ColorName.borderDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: spacingSm.borderRadius,
          borderSide: const BorderSide(color: ColorName.primary),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: spacingSm.borderRadius,
          borderSide: const BorderSide(color: Colors.red),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: spacingSm.borderRadius,
          borderSide: const BorderSide(color: Colors.red),
        ),
        errorStyle: textTheme.bodyMedium?.copyWith(color: Colors.red),
        hintStyle: textTheme.bodyLarge?.copyWith(
          color: ColorName.textSecondary,
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: ColorName.primary,
        selectionColor: ColorName.primary.withValues(alpha: 0.2),
        selectionHandleColor: ColorName.primary,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle: textTheme.bodySmall,
        selectedLabelStyle: textTheme.bodySmall,
        backgroundColor: ColorName.surfaceDark,
        unselectedItemColor: Colors.grey.shade300,
        selectedItemColor: ColorName.primary,
      ),
      dividerColor: ColorName.borderDark,
      popupMenuTheme: PopupMenuThemeData(
        color: ColorName.surfaceDark,
        shape: RoundedRectangleBorder(
          borderRadius: spacingXs.borderRadius,
          side: const BorderSide(color: ColorName.borderDark),
        ),
      ),
    );
  }

  SliverGridDelegate get gridDelegate {
    return SliverGridDelegateWithFixedCrossAxisCount(
      childAspectRatio: 1.2,
      mainAxisSpacing: spacingMd,
      crossAxisSpacing: spacingMd,
      crossAxisCount: 2,
    );
  }

  SliverGridDelegate customGridDelegate({
    double? childAspectRatio,
    int? crossAxisCount,
  }) {
    return SliverGridDelegateWithFixedCrossAxisCount(
      childAspectRatio: childAspectRatio ?? 1.2,
      crossAxisCount: crossAxisCount ?? 2,
      crossAxisSpacing: spacingSm,
      mainAxisSpacing: spacingSm,
    );
  }
}
