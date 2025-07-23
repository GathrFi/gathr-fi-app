import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/settings/managers/theme_bloc.dart';
import 'gathrfi_app_di.dart';
import 'gathrfi_app_router.dart';
import 'shared/extensions/ext_theme.dart';
import 'shared/l10n/app_localizations.dart';

class GathrfiApp extends StatefulWidget {
  const GathrfiApp({super.key});

  @override
  State<GathrfiApp> createState() => _GathrfiAppState();
}

class _GathrfiAppState extends State<GathrfiApp> {
  late final GathrfiAppRouter _appRouter;
  late final ThemeBloc _themeBloc;

  @override
  void initState() {
    _appRouter = GathrfiAppRouter();
    _themeBloc = locator<ThemeBloc>();
    _themeBloc.add(const ThemeEvent.init());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _themeBloc,
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            themeMode: state.mode,
            theme: context.themeData,
            darkTheme: context.darkThemeData,
            routerConfig: _appRouter.config(),
            builder: (context, child) => GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              behavior: HitTestBehavior.opaque,
              child: child,
            ),
          );
        },
      ),
    );
  }
}
