import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';
import 'features/onboarding/managers/auth_bloc.dart';
import 'features/settings/managers/profile_bloc.dart';
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
  late final AuthBloc _authBloc;
  late final ProfileBloc _profileBloc;

  @override
  void initState() {
    _appRouter = GathrfiAppRouter();
    _themeBloc = locator<ThemeBloc>();
    _themeBloc.add(const ThemeEvent.initialize());
    _authBloc = locator<AuthBloc>();
    _profileBloc = locator<ProfileBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _themeBloc),
        BlocProvider(create: (context) => _authBloc),
        BlocProvider(create: (context) => _profileBloc),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              state.whenOrNull(
                unauthenticated: () {
                  _appRouter.replaceAll([const OnboardingRoute()]);
                },
                authenticated: () {
                  context.read<ProfileBloc>().add(const ProfileEvent.load());
                },
              );
            },
          ),
          BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              state.mapOrNull(
                loaded: (value) {
                  final userProfile = value.userProfile;
                  if (userProfile == null) {
                    _appRouter.replaceAll([const OnboardingProfileRoute()]);
                  } else {
                    _appRouter.replaceAll([const HomeRoute()]);
                  }
                },
              );
            },
          ),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return ToastificationWrapper(
              child: MaterialApp.router(
                debugShowCheckedModeBanner: false,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                // themeMode: state.mode,
                themeMode: ThemeMode.light,
                theme: context.themeData,
                darkTheme: context.darkThemeData,
                routerConfig: _appRouter.config(),
                builder: (context, child) => GestureDetector(
                  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                  behavior: HitTestBehavior.opaque,
                  child: child,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
