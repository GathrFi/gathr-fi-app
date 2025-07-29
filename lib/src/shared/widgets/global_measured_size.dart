import 'package:flutter/material.dart';

class GlobalMeasuredSize extends StatefulWidget {
  const GlobalMeasuredSize({
    super.key,
    required this.onChange,
    required this.child,
  });

  final Widget child;
  final ValueChanged<Size> onChange;

  @override
  State<GlobalMeasuredSize> createState() => _GlobalMeasuredSizeState();
}

class _GlobalMeasuredSizeState extends State<GlobalMeasuredSize> {
  final _key = GlobalKey();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _notifySize());
    super.initState();
  }

  void _notifySize() {
    final context = _key.currentContext;
    if (context == null) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box != null && box.hasSize) {
      widget.onChange(box.size);
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<SizeChangedLayoutNotification>(
      onNotification: (_) {
        WidgetsBinding.instance.addPostFrameCallback((_) => _notifySize());
        return true;
      },
      child: SizeChangedLayoutNotifier(
        child: Container(key: _key, child: widget.child),
      ),
    );
  }
}
