// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../core/constants/strings.dart';

class ButtonData {
  final String buttonText;
  final Color textColor;
  const ButtonData({
    required this.buttonText,
    required this.textColor,
  });
}

const colorWhite = Colors.white;

const List<ButtonData> buttonNumbersGrid = [
  ButtonData(buttonText: 'C', textColor: Colors.red),
  ButtonData(buttonText: '( )', textColor: primaryColor),
  ButtonData(buttonText: '%', textColor: primaryColor),
  ButtonData(buttonText: '7', textColor: colorWhite),
  ButtonData(buttonText: '8', textColor: colorWhite),
  ButtonData(buttonText: '9', textColor: colorWhite),
  ButtonData(buttonText: '4', textColor: colorWhite),
  ButtonData(buttonText: '5', textColor: colorWhite),
  ButtonData(buttonText: '6', textColor: colorWhite),
  ButtonData(buttonText: '1', textColor: colorWhite),
  ButtonData(buttonText: '2', textColor: colorWhite),
  ButtonData(buttonText: '3', textColor: colorWhite),
  ButtonData(buttonText: '+/-', textColor: colorWhite),
  ButtonData(buttonText: '0', textColor: colorWhite),
  ButtonData(buttonText: '.', textColor: colorWhite),
];

const List<ButtonData> buttonOperatorsGrid = [
  ButtonData(buttonText: '÷', textColor: primaryColor),
  ButtonData(buttonText: 'x', textColor: primaryColor),
  ButtonData(buttonText: '-', textColor: primaryColor),
  ButtonData(buttonText: '+', textColor: primaryColor),
  ButtonData(buttonText: '=', textColor: colorWhite),
];

const List<ButtonData> buttonAdvancedOperatorsGrid = [
  ButtonData(buttonText: '⇄', textColor: colorWhite),
  ButtonData(buttonText: 'Rad', textColor: colorWhite),
  ButtonData(buttonText: '√', textColor: colorWhite),
  ButtonData(buttonText: 'sin', textColor: colorWhite),
  ButtonData(buttonText: 'cos', textColor: colorWhite),
  ButtonData(buttonText: 'tan', textColor: colorWhite),
  ButtonData(buttonText: 'ln', textColor: colorWhite),
  ButtonData(buttonText: 'log', textColor: colorWhite),
  ButtonData(buttonText: '1/x', textColor: colorWhite),
  ButtonData(buttonText: 'eˣ', textColor: colorWhite),
  ButtonData(buttonText: 'x²', textColor: colorWhite),
  ButtonData(buttonText: 'xʸ', textColor: colorWhite),
  ButtonData(buttonText: '|x|', textColor: colorWhite),
  ButtonData(buttonText: '𝝅', textColor: colorWhite),
  ButtonData(buttonText: 'e', textColor: colorWhite),
];

const List<ButtonData> buttonNegativeAdvancedOperatorsGrid = [
  ButtonData(buttonText: '⇄', textColor: colorWhite),
  ButtonData(buttonText: 'Rad', textColor: colorWhite),
  ButtonData(buttonText: '³√', textColor: colorWhite),
  ButtonData(buttonText: 'sin⁻¹', textColor: colorWhite),
  ButtonData(buttonText: 'cos⁻¹', textColor: colorWhite),
  ButtonData(buttonText: 'tan⁻¹', textColor: colorWhite),
  ButtonData(buttonText: 'sinh', textColor: colorWhite),
  ButtonData(buttonText: 'cosh', textColor: colorWhite),
  ButtonData(buttonText: 'tanh', textColor: colorWhite),
  ButtonData(buttonText: 'sinh⁻¹', textColor: colorWhite),
  ButtonData(buttonText: 'cosh⁻¹', textColor: colorWhite),
  ButtonData(buttonText: 'tanh⁻¹', textColor: colorWhite),
  ButtonData(buttonText: '2ˣ', textColor: colorWhite),
  ButtonData(buttonText: 'x³', textColor: colorWhite),
  ButtonData(buttonText: 'x!', textColor: colorWhite),
];

const List<ButtonData> buttonNumbersAndOperatosGrid = [
  ButtonData(buttonText: 'C', textColor: Colors.red),
  ButtonData(buttonText: '( )', textColor: primaryColor),
  ButtonData(buttonText: '%', textColor: primaryColor),
  ButtonData(buttonText: '÷', textColor: primaryColor),
  ButtonData(buttonText: '7', textColor: colorWhite),
  ButtonData(buttonText: '8', textColor: colorWhite),
  ButtonData(buttonText: '9', textColor: colorWhite),
  ButtonData(buttonText: 'x', textColor: primaryColor),
  ButtonData(buttonText: '4', textColor: colorWhite),
  ButtonData(buttonText: '5', textColor: colorWhite),
  ButtonData(buttonText: '6', textColor: colorWhite),
  ButtonData(buttonText: '-', textColor: primaryColor),
  ButtonData(buttonText: '1', textColor: colorWhite),
  ButtonData(buttonText: '2', textColor: colorWhite),
  ButtonData(buttonText: '3', textColor: colorWhite),
  ButtonData(buttonText: '+', textColor: primaryColor),
  ButtonData(buttonText: '+/-', textColor: colorWhite),
  ButtonData(buttonText: '0', textColor: colorWhite),
  ButtonData(buttonText: '.', textColor: colorWhite),
  ButtonData(buttonText: '=', textColor: colorWhite),
];
