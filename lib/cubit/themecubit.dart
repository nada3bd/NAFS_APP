import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(_lightTheme);

  static final _lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.teal,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.white, elevation: 0),
  );

  static final  ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.teal,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.black, elevation: 0),
  );

  void toggleTheme() => emit(state.brightness == Brightness.dark ? _lightTheme : _darkTheme);
}



