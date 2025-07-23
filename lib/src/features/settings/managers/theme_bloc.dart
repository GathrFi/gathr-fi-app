import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';
part 'theme_bloc.freezed.dart';

@injectable
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final SharedPreferences sharedPreferences;
  ThemeBloc(this.sharedPreferences) : super(const _ThemeState()) {
    const modePrefsKey = 'gathrfi-theme-mode';

    on<_Init>((event, emit) {
      final currModeName = sharedPreferences.getString(modePrefsKey);
      final currMode = currModeName != null
          ? ThemeMode.values.byName(currModeName)
          : ThemeMode.system;

      emit(state.copyWith(mode: currMode));
    });

    on<_ToggleMode>((event, emit) async {
      final currModeName = sharedPreferences.getString(modePrefsKey);
      final currMode = currModeName != null
          ? ThemeMode.values.byName(currModeName)
          : ThemeMode.system;

      final nextMode = switch (currMode) {
        ThemeMode.light => ThemeMode.dark,
        ThemeMode.dark => ThemeMode.system,
        ThemeMode.system => ThemeMode.light,
      };

      await sharedPreferences.setString(modePrefsKey, nextMode.name);

      emit(state.copyWith(mode: nextMode));
    });
  }
}
