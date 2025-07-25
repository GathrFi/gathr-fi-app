part of 'theme_bloc.dart';

@freezed
abstract class ThemeEvent with _$ThemeEvent {
  const factory ThemeEvent.initialize() = _Initialize;
  const factory ThemeEvent.toggleMode() = _ToggleMode;
}
