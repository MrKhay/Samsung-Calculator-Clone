// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../core/constants/strings.dart';

class ButtonData {
  final String buttonText;
  final Color? textColor;
  const ButtonData({
    required this.buttonText,
    this.textColor,
  });
}

const List<ButtonData> buttonNumbersGrid = [
  ButtonData(buttonText: 'C', textColor: Colors.red),
  ButtonData(buttonText: '( )', textColor: greenColor),
  ButtonData(buttonText: '%', textColor: greenColor),
  ButtonData(buttonText: '7'),
  ButtonData(buttonText: '9'),
  ButtonData(buttonText: '8'),
  ButtonData(buttonText: '4'),
  ButtonData(buttonText: '5'),
  ButtonData(buttonText: '6'),
  ButtonData(buttonText: '1'),
  ButtonData(buttonText: '2'),
  ButtonData(buttonText: '3'),
  ButtonData(buttonText: '+/-'),
  ButtonData(buttonText: '0'),
  ButtonData(buttonText: '.'),
];

const List<String> operatorsWithSpecialColors = [
  'C',
  '( )',
  '%',
  '+',
  '-',
  'x',
  '÷',
];

const List<ButtonData> buttonOperatorsGrid = [
  ButtonData(buttonText: '÷', textColor: greenColor),
  ButtonData(buttonText: 'x', textColor: greenColor),
  ButtonData(buttonText: '-', textColor: greenColor),
  ButtonData(buttonText: '+', textColor: greenColor),
  ButtonData(buttonText: '='),
];

const List<ButtonData> buttonNumbersAndOperatosGrid = [
  ButtonData(buttonText: 'C', textColor: Colors.red),
  ButtonData(buttonText: '( )', textColor: greenColor),
  ButtonData(buttonText: '%', textColor: greenColor),
  ButtonData(buttonText: '÷', textColor: greenColor),
  ButtonData(buttonText: '7'),
  ButtonData(buttonText: '8'),
  ButtonData(buttonText: '9'),
  ButtonData(buttonText: 'x', textColor: greenColor),
  ButtonData(buttonText: '4'),
  ButtonData(buttonText: '5'),
  ButtonData(buttonText: '6'),
  ButtonData(buttonText: '-', textColor: greenColor),
  ButtonData(buttonText: '1'),
  ButtonData(buttonText: '2'),
  ButtonData(buttonText: '3'),
  ButtonData(buttonText: '+', textColor: greenColor),
  ButtonData(buttonText: '+/-'),
  ButtonData(buttonText: '0'),
  ButtonData(buttonText: '.'),
  ButtonData(buttonText: '='),
];

const List<ButtonData> buttonAdvancedOperatorsGrid = [
  ButtonData(buttonText: '⇄'),
  ButtonData(buttonText: 'Rad'),
  ButtonData(buttonText: '√'),
  ButtonData(buttonText: 'sin'),
  ButtonData(buttonText: 'cos'),
  ButtonData(buttonText: 'tan'),
  ButtonData(buttonText: 'ln'),
  ButtonData(buttonText: 'log'),
  ButtonData(buttonText: '1/x'),
  ButtonData(buttonText: 'eˣ'),
  ButtonData(buttonText: 'x²'),
  ButtonData(buttonText: 'xʸ'),
  ButtonData(buttonText: '|x|'),
  ButtonData(buttonText: '𝝅'),
  ButtonData(buttonText: 'e'),
];

const List<ButtonData> buttonAdvancedOperatorsDegGrid = [
  ButtonData(buttonText: '⇄'),
  ButtonData(buttonText: 'Deg'),
  ButtonData(buttonText: '√'),
  ButtonData(buttonText: 'sin'),
  ButtonData(buttonText: 'cos'),
  ButtonData(buttonText: 'tan'),
  ButtonData(buttonText: 'ln'),
  ButtonData(buttonText: 'log'),
  ButtonData(buttonText: '1/x'),
  ButtonData(buttonText: 'eˣ'),
  ButtonData(buttonText: 'x²'),
  ButtonData(buttonText: 'xʸ'),
  ButtonData(buttonText: '|x|'),
  ButtonData(buttonText: '𝝅'),
  ButtonData(buttonText: 'e'),
];

const List<ButtonData> buttonNegativeAdvancedOperatorsGrid = [
  ButtonData(buttonText: '⇄'),
  ButtonData(buttonText: 'Rad'),
  ButtonData(buttonText: '³√'),
  ButtonData(buttonText: 'sin⁻¹'),
  ButtonData(buttonText: 'cos⁻¹'),
  ButtonData(buttonText: 'tan⁻¹'),
  ButtonData(buttonText: 'sinh'),
  ButtonData(buttonText: 'cosh'),
  ButtonData(buttonText: 'tanh'),
  ButtonData(buttonText: 'sinh⁻¹'),
  ButtonData(buttonText: 'cosh⁻¹'),
  ButtonData(buttonText: 'tanh⁻¹'),
  ButtonData(buttonText: '2ˣ'),
  ButtonData(buttonText: 'x³'),
  ButtonData(buttonText: 'x!'),
];

const List<ButtonData> buttonNegativeAdvancedOperatorsDegGrid = [
  ButtonData(buttonText: '⇄'),
  ButtonData(buttonText: 'Deg'),
  ButtonData(buttonText: '³√'),
  ButtonData(buttonText: 'sin⁻¹'),
  ButtonData(buttonText: 'cos⁻¹'),
  ButtonData(buttonText: 'tan⁻¹'),
  ButtonData(buttonText: 'sinh'),
  ButtonData(buttonText: 'cosh'),
  ButtonData(buttonText: 'tanh'),
  ButtonData(buttonText: 'sinh⁻¹'),
  ButtonData(buttonText: 'cosh⁻¹'),
  ButtonData(buttonText: 'tanh⁻¹'),
  ButtonData(buttonText: '2ˣ'),
  ButtonData(buttonText: 'x³'),
  ButtonData(buttonText: 'x!'),
];
