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

    on<CalculatorEventToggleLogInverse>((event, emit) {
      emit(CalculatorState(
        result: state.result,
        isLogInverseMode: !state.isLogInverseMode,
        isLogRad: state.isLogRad,
      ));
    });
    on<CalculatorEventToggleLogRad>((event, emit) {
      emit(CalculatorState(
        result: state.result,
        isLogInverseMode: state.isLogInverseMode,
        isLogRad: !state.isLogRad,
      ));
      // remove any comma in expression
      var mathExpression = event.mathExpression
          .split('')
          .map((e) => e == ',' ? '' : e)
          .join('')
          .replaceAll('x', '*')
          .replaceAll('÷', '/');
      final calculateInRad = state.isLogRad;

      final result = calculateExpression(mathExpression, calculateInRad);
      emit(CalculatorState(
        result: result,
        isLogRad: state.isLogRad,
        isLogInverseMode: state.isLogInverseMode,
      ));
    });
    on<CalculatorEventDivision>((event, emit) {
      final result = event.firstNumber / event.secondNumber;

      emit(CalculatorState(
        result: result.toString(),
        isLogRad: state.isLogRad,
        isLogInverseMode: state.isLogInverseMode,
      ));
    });

    on<CalculatorEvaluateSolveEquation>((event, emit) {
      final calculateInRad = state.isLogRad;
      if (event.expression.isEmpty) {
        emit(CalculatorState(
          result: '',
          isLogRad: state.isLogRad,
          isLogInverseMode: state.isLogInverseMode,
        ));
        return;
      }
      // remove any comma in expression
      var mathExpression = event.expression
          .split('')
          .map((e) => e == ',' ? '' : e)
          .join('')
          .replaceAll('x', '*')
          .replaceAll('÷', '/');

      // returns when expression is euler
      if (regExpMatchEndsWithEulerOrPie.hasMatch(event.expression)) {
        emit(CalculatorState(
            isLogInverseMode: state.isLogInverseMode,
            isLogRad: state.isLogRad,
            result: calculateExpression(event.expression, calculateInRad)
                .toString()));
        return;
      }

      // // returns when expression ends with number then trigometric function
      // if (regExpMatchEndsWithNumberThenTrigoFunctionThenOptionalClosingParenthesis
      //     .hasMatch(event.expression)) {
      //   emit(CalculatorState(
      //       result: calculateExpression(event.expression).toString()));
      //   return;
      // }

      // returns when expression ends with number then trigometric function
      if (regExpMatchEndWithNumber.hasMatch(event.expression)) {
        emit(CalculatorState(
            isLogInverseMode: state.isLogInverseMode,
            isLogRad: state.isLogRad,
            result: calculateExpression(event.expression, calculateInRad)
                .toString()));
        return;
      }

      if (regExpMatchEndWithClosedBracket.hasMatch(event.expression)) {
        emit(CalculatorState(
            isLogInverseMode: state.isLogInverseMode,
            isLogRad: state.isLogRad,
            result: calculateExpression(event.expression, calculateInRad)
                .toString()));
        return;
      }

      // if expression ends with an operator emit 0
      if (regExpMatchEndWithOperator.hasMatch(mathExpression) ||
          !regExpMatchContainsOperator.hasMatch(mathExpression) ||
          regExpMatchEndsWithOpenBracket.hasMatch(mathExpression)) {
        emit(CalculatorState(
          isLogRad: state.isLogRad,
          isLogInverseMode: state.isLogInverseMode,
          result: '',
        ));
        return;
      }

      emit(CalculatorState(
        isLogInverseMode: state.isLogInverseMode,
        isLogRad: state.isLogRad,
        result: calculateExpression(mathExpression, calculateInRad).toString(),
      ));
    });
  }
}

String calculateExpression(String expression, bool calculateInRad) {
  try {
    // convert expression into num and then calculate and emit result
    Parser parser = Parser();

    var formattedExpression = expression;

    if (regExpMatchContainsLogFunction.hasMatch(expression)) {
      formattedExpression = '${expression.formatExpression()}*(180/${math.pi})';
    }

    final mathExpression = formattedExpression
        .formatHyperbolicTangent()
        .formatAdvancedOperators()
        .formatExpression();

    Expression exp = parser.parse(mathExpression);

    num result = exp.evaluate(EvaluationType.REAL, ContextModel());
    if (regExpMatchContainsLogFunction.hasMatch(expression)) {
      if (calculateInRad) {
        var data = result * (math.pi / 180);
        result = data;
      } else {
        Expression exp = parser.parse(mathExpression);
        result = exp.evaluate(EvaluationType.REAL, ContextModel());
      }
    }
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
  } catch (e) {
    print('Error: $e');
    return '';
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

  String formatHyperbolicTangent() {
    final hyperbolicTangents =
        split(regExpMatchHyperbolicTanThenOpenParentesisThenNumber);
    final expressionWithputhyperbolicTangents =
        regExpMatchHyperbolicTanThenOpenParentesisThenNumber
            .allMatches(this)
            .map((e) => e.group(0))
            .toList();

    var formattedExpressionWithputhyperbolicTangents = [];

    for (final part in expressionWithputhyperbolicTangents) {
      // split between evry non numerical value and deciaml then join back to get only the numbers
      final numericalValue =
          part!.split(regExpMatchNonNumericalValueAndDecimalPoint).join('');
      final hyperbolicTangent = regExpMatchNumericalAndDecimalPoint
          .allMatches(part)
          .map((e) => e.group(0))
          .join('');

      if (hyperbolicTangent == 'cosh') {
        final formattedData = '((e^$numericalValue+e^(-$numericalValue))/2)';
        formattedExpressionWithputhyperbolicTangents.add(formattedData);
      } else if (hyperbolicTangent == 'sinh') {
        final formattedData = '((e^$numericalValue-e^(-$numericalValue))/2)';
        formattedExpressionWithputhyperbolicTangents.add(formattedData);
      } else if (hyperbolicTangent == 'tanh') {
        final formattedData =
            '(e^$numericalValue - e^(-$numericalValue))/(e^$numericalValue+e^(-$numericalValue))';
        formattedExpressionWithputhyperbolicTangents.add(formattedData);
      } else if (hyperbolicTangent == 'atanh') {
        final formattedData =
            '(1/2*loge((1+$numericalValue)/(1-$numericalValue)))';
        formattedExpressionWithputhyperbolicTangents.add(formattedData);
      } else if (hyperbolicTangent == 'acosh') {
        final formattedData =
            '(loge($numericalValue+sqrt($numericalValue^2-1)))';
        formattedExpressionWithputhyperbolicTangents.add(formattedData);
      } else if (hyperbolicTangent == 'asinh') {
        final formattedData =
            '(loge($numericalValue+sqrt($numericalValue^2+1)))';

        formattedExpressionWithputhyperbolicTangents.add(formattedData);
      } else if (hyperbolicTangent == 'cbrt') {
        var x = num.parse(numericalValue);
        final formattedData = math.pow(x, 1 / 3);
        formattedExpressionWithputhyperbolicTangents.add(formattedData);
      }
    }
    var formattedExpressionPartWithOperators = [];
    int operatorsIndex = 0;

    for (int i = 0; i < hyperbolicTangents.length; i++) {
      formattedExpressionPartWithOperators.add(hyperbolicTangents.elementAt(i));

      if (i != hyperbolicTangents.length - 1 &&
          operatorsIndex <
              formattedExpressionWithputhyperbolicTangents.length) {
        formattedExpressionPartWithOperators
            .add(formattedExpressionWithputhyperbolicTangents[operatorsIndex]);
        operatorsIndex++;
      }
    }

    while (
        operatorsIndex < formattedExpressionWithputhyperbolicTangents.length) {
      formattedExpressionPartWithOperators
          .add(formattedExpressionWithputhyperbolicTangents[operatorsIndex]);
      operatorsIndex++;
    }

    return formattedExpressionPartWithOperators.join('');
  }

  String formatAdvancedOperators() {
    var expression = replaceAll('asin', 'arcsin')
        .replaceAll('atan', 'arctan')
        .replaceAll('acos', 'arccos')
        .replaceAll('√', 'sqrt')
        .replaceAll('log', 'log10')
        .replaceAll('x', '*')
        .replaceAll('ln', 'loge')
        .replaceAll('𝝅', math.pi.toString())
        .replaceAll(',', '')
        .replaceAll('÷', '/')
        .replaceAll('e', math.e.toString());

    return expression;
  }

  String formatForTrigonometriRadius(bool calculateInRadius) {
    var expression = '';

    if (calculateInRadius) {
      expression = '$this*(180/${math.pi})';
    } else {
      expression = '$this*(${math.pi}/180)';
    }

    return expression;
  }
}
