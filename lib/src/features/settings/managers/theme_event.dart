part of 'theme_bloc.dart';

@freezed
abstract class ThemeEvent with _$ThemeEvent {
  const factory ThemeEvent.init() = _Init;
  const factory ThemeEvent.toggleMode() = _ToggleMode;
}
