import 'package:flutter/material.dart';

import '../../presentation/common_widgets/custom_font.dart';

class AppTheme {
  const AppTheme._();
  static final lightTheme = ThemeData(
    useMaterial3: true,
    primarySwatch: Colors.blue,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final darkTheme = ThemeData(
      useMaterial3: true,
      primarySwatch: Colors.green,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.green,
        background: Colors.black,
        brightness: Brightness.dark,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      buttonTheme: const ButtonThemeData(
        shape: CircleBorder(),
        buttonColor: Colors.white,
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
