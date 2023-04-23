// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'calculator_bloc.dart';

@immutable
abstract class CalculatorEvent {}

@immutable
class CalculatorEventAddition implements CalculatorEvent {
  final num firstNumber;
  final num secondNumber;
  const CalculatorEventAddition({
    required this.firstNumber,
    required this.secondNumber,
  });
}

@immutable
class CalculatorEvaluateSolveEquation implements CalculatorEvent {
  final String expression;
  const CalculatorEvaluateSolveEquation({required this.expression});
}

@immutable
class CalculatorEventSubstarction implements CalculatorEvent {
  final num firstNumber;
  final num secondNumber;
  const CalculatorEventSubstarction({
    required this.firstNumber,
    required this.secondNumber,
  });
}

@immutable
class CalculatorEventDivision implements CalculatorEvent {
  final num firstNumber;
  final num secondNumber;
  const CalculatorEventDivision({
    required this.firstNumber,
    required this.secondNumber,
  });
}

@immutable
class CalculatorEventMultiplication implements CalculatorEvent {
  final num firstNumber;
  final num secondNumber;
  const CalculatorEventMultiplication({
    required this.firstNumber,
    required this.secondNumber,
  });
}

@immutable
class CalculatorEventReset implements CalculatorEvent {
  const CalculatorEventReset();
}
