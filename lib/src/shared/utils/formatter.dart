import 'dart:math';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  CurrencyInputFormatter({this.decimalLength = 2, this.locale = 'en_US'});

  final int decimalLength;
  final String locale;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue;
    final newText = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    if (newText.isEmpty) return newValue.copyWith(text: '');

    final value = double.parse(newText) / pow(10, decimalLength);
    final formatter = NumberFormat.currency(
      locale: locale,
      decimalDigits: decimalLength,
      symbol: '',
    );

    final formattedText = formatter.format(value);
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
