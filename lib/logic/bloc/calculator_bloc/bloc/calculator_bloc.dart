import 'dart:math' as math;

import 'package:bloc/bloc.dart';
import 'package:calculator/core/constants/strings.dart';
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

      // returns when expression is euler
      if (event.expression == 'e') {
        emit(CalculatorState(
            result: calculateExpression(event.expression).toString()));
        return;
      }

      // if expression ends with an operator emit 0
      if (regExpMatchEndWithOperator.hasMatch(data) ||
          !regExpMatchContainsOperator.hasMatch(data) ||
          regExpMatchEndsWithOpenBracket.hasMatch(data)) {
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

  Expression exp = parser
      .parse(expression.replaceAll('e', math.e.toString()).formatExpression());

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

extension FormatExpression on String {
  String formatExpression() {
    var bracket = replaceAll(RegExp(r'([\+\-\x/\÷\%/*./÷/0-9])'), '');
    var openBrackets = bracket.split('').where((element) => element == '(');
    var closedBrackets = bracket.split('').where((element) => element == ')');
    var expression = this;

    if (closedBrackets.length != openBrackets.length) {
      for (int i = 0; i < openBrackets.length - closedBrackets.length; i++) {
        expression = '$expression)';
      }
    }
    return expression;
  }
}
