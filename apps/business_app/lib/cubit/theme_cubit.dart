import 'package:bloc/bloc.dart';
import 'package:components/component/theme/theme.dart';
import 'package:flutter/material.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  // ignore: non_constant_identifier_names
  bool DarkModeOn = true;

  ThemeCubit() : super(ThemeInitial(themeData: AppThemes.lightTheme));

  // toggle theme
  void toggleTheme() {
    DarkModeOn = !DarkModeOn;
    if (state.themeData == AppThemes.darkTheme) {
      emit(ThemeInitial(themeData: AppThemes.lightTheme));
    } else {
      emit(ThemeInitial(themeData: AppThemes.darkTheme));
    }
  }
}
