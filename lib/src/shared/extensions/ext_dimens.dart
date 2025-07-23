import 'package:flutter/material.dart';

extension DimensX on BuildContext {
  double get spacingXxs => 4;
  double get spacingXs => 8;
  double get spacingSm => 12;
  double get spacingMd => 16;
  double get spacingLg => 20;
  double get spacingXlg => 24;

  double get deviceWidth => MediaQuery.of(this).size.width;
  double get deviceHeight => MediaQuery.of(this).size.height;
  double get statusBarHeight => MediaQuery.of(this).padding.top;
  double get appBarHeight => statusBarHeight + kToolbarHeight;
}

extension LayoutX on double {
  BorderRadius get borderRadius => BorderRadius.circular(this);
  Radius get radius => Radius.circular(this);
  SizedBox get vSpace => SizedBox(height: this);
  SizedBox get hSpace => SizedBox(width: this);
}
