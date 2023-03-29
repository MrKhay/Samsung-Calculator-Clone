import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:math_expressions/math_expressions.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  CalculatorBloc() : super(const CalculatorState(result: '')) {
    on<CalculatorEventAddition>((event, emit) {
      final result = event.firstNumber + event.secondNumber;

      emit(CalculatorState(result: result.toString()));
    });
    on<CalculatorEventDivision>((event, emit) {
      final result = event.firstNumber / event.secondNumber;

      emit(CalculatorState(result: result.toString()));
    });

    on<CalculatorEventSolveEquation>((event, emit) {
      // check if expression contains operators
      var regExpression = RegExp(r'([\+\-\x/\(÷)\%/*/÷])');
      if (event.expression.isEmpty) {
        emit(const CalculatorState(result: ''));
        return;
      }
      // remove any comma in expression
      var data = event.expression
          .split('')
          .map((e) => e == ',' ? '' : e)
          .join('')
          .replaceAll('x', '*')
          .replaceAll('÷', '/');

      // check if expression ends with an operator
      var regExpressionCheck = RegExp(r'([\+\-\*/\(\)/%/])$');

      // if expression ends with an operator emit 0
      if (regExpressionCheck.hasMatch(data) || !regExpression.hasMatch(data)) {
        emit(const CalculatorState(result: ''));
        return;
      }

      emit(CalculatorState(result: calculateExpression(data).toString()));
    });
  }
}

String calculateExpression(String expression) {
  // convert expression into num and then calculate and emit result
  Parser parser = Parser();
  Expression exp = parser.parse(expression);
  num result = exp.evaluate(EvaluationType.REAL, ContextModel());
  if (result.remainder(1) == 0) {
    return result.toInt().toString();
  } else {
    // check if decimal place is more than 10 and reduce it
    if (result.toString().split('.')[1].length > 10) {
      return double.parse(result.toStringAsFixed(10)).toString();
    } else {
      return result.toString();
    }
  }
}
