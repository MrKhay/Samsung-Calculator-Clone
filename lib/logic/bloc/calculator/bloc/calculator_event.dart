// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'calculator_bloc.dart';

@immutable
abstract class CalculatorEvent {}

class CalculatorEventEvaluateEquation implements CalculatorEvent {
  final String expression;
  const CalculatorEventEvaluateEquation({required this.expression});
}

class CalculatorEventReset implements CalculatorEvent {
  const CalculatorEventReset();
}

class CalculatorEventToggleLogInverse implements CalculatorEvent {
  const CalculatorEventToggleLogInverse();
}

class CalculatorEventToggleLogRad implements CalculatorEvent {
  final String mathExpression;
  const CalculatorEventToggleLogRad({required this.mathExpression});
}
