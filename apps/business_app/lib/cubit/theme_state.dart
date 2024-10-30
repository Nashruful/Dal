part of 'theme_cubit.dart';

@immutable
sealed class ThemeState {
  final ThemeData? themeData;

  ThemeState({required this.themeData});
}
// theme state
final class ThemeInitial extends ThemeState {
  ThemeInitial({required super.themeData});
}
