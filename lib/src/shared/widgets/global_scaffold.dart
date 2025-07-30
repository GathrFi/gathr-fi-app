import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../extensions/ext_dimens.dart';
import '../extensions/ext_theme.dart';
import 'global_blur_backdrop.dart';
import 'global_measured_size.dart';

class GlobalScaffold extends StatefulWidget {
  const GlobalScaffold({
    super.key,
    required this.appBarTitle,
    this.appBarActions,
    this.appBarBottom,
    this.appBarHeight = kToolbarHeight,
    this.centerTitle = true,
    required this.body,
    this.bottomWidget,
  });

  final Widget appBarTitle;
  final List<Widget>? appBarActions;
  final PreferredSizeWidget? appBarBottom;
  final double appBarHeight;
  final bool centerTitle;
  final Widget body;
  final Widget? bottomWidget;

  @override
  State<GlobalScaffold> createState() => _GlobalScaffoldState();
}

class _GlobalScaffoldState extends State<GlobalScaffold> {
  final _controller = ScrollController();
  bool _isScrolled = false;
  double _bottomNavHeight = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    final scrolled = _controller.hasClients && _controller.offset > 0;
    if (scrolled != _isScrolled) setState(() => _isScrolled = scrolled);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = context.brightness;
    final systemOverlayStyle = switch (brightness) {
      Brightness.light => SystemUiOverlayStyle.dark,
      Brightness.dark => SystemUiOverlayStyle.light,
    };
    final blurColor = switch (brightness) {
      Brightness.light => Colors.grey.shade200,
      Brightness.dark => Colors.grey.shade900,
    };
    final blurOpacity = switch (brightness) {
      Brightness.light => 0.5,
      Brightness.dark => 0.7,
    };
    final borderColor = switch (brightness) {
      Brightness.light => Colors.grey.shade300,
      Brightness.dark => Colors.grey.shade800,
    };

    final appBarHeight = widget.appBarHeight;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemOverlayStyle,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            appBarHeight + (widget.appBarBottom?.preferredSize.height ?? 0),
          ),
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(
              begin: 0.0,
              end: _isScrolled ? blurOpacity : 0.0,
            ),
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            builder: (context, animatedOpacity, _) {
              return GlobalBlurBackdrop(
                color: blurColor,
                opacity: animatedOpacity,
                child: AppBar(
                  toolbarHeight: appBarHeight,
                  systemOverlayStyle: systemOverlayStyle,
                  backgroundColor: Colors.transparent,
                  shape: Border(
                    bottom: BorderSide(
                      color: borderColor.withAlpha(
                        (animatedOpacity * 255).round(),
                      ),
                    ),
                  ),
                  title: widget.appBarTitle,
                  actions: widget.appBarActions,
                  bottom: widget.appBarBottom,
                  centerTitle: widget.centerTitle,
                ),
              );
            },
          ),
        ),
        body: NotificationListener<ScrollNotification>(
          onNotification: (_) {
            _onScroll();
            return false;
          },
          child: SingleChildScrollView(
            controller: _controller,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + appBarHeight,
              bottom: MediaQuery.of(context).padding.bottom + _bottomNavHeight,
            ),
            child: widget.body,
          ),
        ),
        extendBody: true,
        bottomNavigationBar: widget.bottomWidget != null
            ? GlobalMeasuredSize(
                onChange: (size) {
                  if (size.height != _bottomNavHeight) {
                    setState(() => _bottomNavHeight = size.height);
                  }
                },
                child: GlobalBlurBackdrop(
                  color: blurColor,
                  opacity: blurOpacity,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.spacingXlg,
                      vertical: context.spacingSm,
                    ),
                    decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: borderColor)),
                    ),
                    child: SafeArea(child: widget.bottomWidget!),
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
