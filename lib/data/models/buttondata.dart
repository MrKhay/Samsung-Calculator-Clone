// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ButtonData {
  final String buttonText;
  final Color textColor;
  const ButtonData({
    required this.buttonText,
    required this.textColor,
  });
}

const colorGreen = Colors.green;
const colorWhite = Colors.white;
const List<ButtonData> buttonGridItems = [
  ButtonData(buttonText: 'C', textColor: Colors.red),
  ButtonData(buttonText: '( )', textColor: colorGreen),
  ButtonData(buttonText: '%', textColor: colorGreen),
  ButtonData(buttonText: '÷', textColor: colorGreen),
  ButtonData(buttonText: '7', textColor: colorWhite),
  ButtonData(buttonText: '8', textColor: colorWhite),
  ButtonData(buttonText: '9', textColor: colorWhite),
  ButtonData(buttonText: 'x', textColor: colorGreen),
  ButtonData(buttonText: '4', textColor: colorWhite),
  ButtonData(buttonText: '5', textColor: colorWhite),
  ButtonData(buttonText: '6', textColor: colorWhite),
  ButtonData(buttonText: '-', textColor: colorGreen),
  ButtonData(buttonText: '1', textColor: colorWhite),
  ButtonData(buttonText: '2', textColor: colorWhite),
  ButtonData(buttonText: '3', textColor: colorWhite),
  ButtonData(buttonText: '+', textColor: colorGreen),
  ButtonData(buttonText: '+/-', textColor: colorWhite),
  ButtonData(buttonText: '0', textColor: colorWhite),
  ButtonData(buttonText: '.', textColor: colorWhite),
  ButtonData(buttonText: '=', textColor: colorWhite),
];
