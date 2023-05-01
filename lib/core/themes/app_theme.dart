import 'package:flutter/material.dart';

import '../../presentation/common_widgets/custom_font.dart';

class AppTheme {
  const AppTheme._();
  static final lightTheme = ThemeData(
    useMaterial3: true,
    primarySwatch: Colors.blue,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: Colors.green,
      background: Colors.white,
      secondary: Colors.black,
      primary: Colors.black,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    buttonTheme: ButtonThemeData(
        shape: const CircleBorder(),
        buttonColor: Colors.black,
        splashColor: Colors.grey.withOpacity(0.3),
        colorScheme: ColorScheme.light(
          primary: Colors.grey.withOpacity(0.1),
        )),
    inputDecorationTheme: const InputDecorationTheme(
      border: InputBorder.none,
      contentPadding: EdgeInsets.symmetric(vertical: 10),
      constraints: BoxConstraints.expand(),
      isDense: true,
    ),
  );

  static final darkTheme = ThemeData(
      useMaterial3: true,
      primarySwatch: Colors.green,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.green,
        background: Colors.black,
        brightness: Brightness.dark,
        surface: Colors.black,
        primary: Colors.white,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      buttonTheme: ButtonThemeData(
        shape: const CircleBorder(),
        splashColor: Colors.grey.withOpacity(0.3),
        colorScheme: ColorScheme.dark(
          primary: Colors.grey.withOpacity(0.1),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 10),
        constraints: BoxConstraints.expand(),
        isDense: true,
      ),
      textTheme: TextTheme(
        titleSmall: customFont(),
      ));
}
