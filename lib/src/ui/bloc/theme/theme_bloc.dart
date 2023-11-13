import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../data/datasources/local/services/shared_preferences_service.dart';

part 'theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeMode> {
  final SharedPreferencesService _sharedPreferencesService;

  ThemeBloc(this._sharedPreferencesService)
      : super(
          _sharedPreferencesService.tema == 'dark'
              ? ThemeMode.dark
              : ThemeMode.light,
        ) {
    on<ChangeThemeEvent>((event, emit) {
      final isDarkTheme = event.theme == ThemeMode.dark;
      _sharedPreferencesService.tema = isDarkTheme ? 'dark' : 'light';
      emit(event.theme);
    });
  }
}
