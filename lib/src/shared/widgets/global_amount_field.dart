import 'package:flutter/material.dart';

import '../assets/colors.gen.dart';
import '../extensions/ext_misc.dart';
import '../extensions/ext_theme.dart';
import '../utils/formatter.dart';
import 'global_label_wrapper.dart';

class GlobalAmountField extends StatefulWidget {
  const GlobalAmountField({
    super.key,
    required this.label,
    this.controller,
    this.onChanged,
  });

  final String label;
  final TextEditingController? controller;
  final ValueChanged<double>? onChanged;

  @override
  State<GlobalAmountField> createState() => _GlobalAmountFieldState();
}

class _GlobalAmountFieldState extends State<GlobalAmountField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GlobalLabelWrapper(
      label: widget.label,
      labelStyle: context.textTheme.bodyLarge?.copyWith(
        color: ColorName.textSecondary,
        fontWeight: FontWeight.w500,
      ),
      child: Row(
        children: [
          Text(context.l10n.usdSymbol, style: context.textTheme.displayMedium),
          Expanded(
            child: TextField(
              controller: _controller,
              style: context.textTheme.displayMedium,
              inputFormatters: [CurrencyInputFormatter()],
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                hintText: context.l10n.iAmountHint,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                hintStyle: context.textTheme.displayMedium?.copyWith(
                  color: ColorName.textSecondary.withAlpha((0.4 * 255).round()),
                ),
              ),
              onChanged: (value) {
                if (value.toDouble() <= 0) {
                  _controller.clear();
                } else {
                  if (widget.onChanged != null) {
                    widget.onChanged!(value.toDouble());
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
