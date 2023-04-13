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
