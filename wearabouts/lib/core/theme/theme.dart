import 'package:flutter/material.dart';
import 'package:wearabouts/core/theme/app_pallete.dart';

class AppTheme {
  //Configuración para bordes parametrizada
  static OutlineInputBorder inputBorder(Color color) => OutlineInputBorder(
      borderSide: BorderSide(color: color),
      borderRadius: BorderRadius.circular(10));

  static TextStyle pageTittleStyle() => const TextStyle(fontSize: 20);

  static final lightThemeMode = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Pallete.whiteColor,

    //Text inputs style
    inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(10),
        //Style when selected
        enabledBorder: inputBorder(Pallete.borderColor),
        //Style when focused
        focusedBorder: inputBorder(Pallete.color2)),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor:
          Pallete.color2, // Asegúrate de que el color sea el correcto
    ),
  );
}
