import 'package:bloc_test/bloc_test.dart';
import 'package:calculator/logic/bloc/calculator/bloc/calculator_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Simple Aritimatics Calculation Test', () {
    blocTest<CalculatorBloc, CalculatorState>(
      'Basic Calculation 1',
      build: () => CalculatorBloc(),
      act: (bloc) =>
          bloc.add(const CalculatorEventEvaluateEquation(expression: '2+2')),
      expect: () => const <CalculatorState>[
        CalculatorState(result: '4'),
      ],
    );
    blocTest<CalculatorBloc, CalculatorState>(
      'Basic Calculation 2',
      build: () => CalculatorBloc(),
      act: (bloc) =>
          bloc.add(const CalculatorEventEvaluateEquation(expression: '2-2')),
      expect: () => const <CalculatorState>[
        CalculatorState(result: '0'),
      ],
    );
    blocTest<CalculatorBloc, CalculatorState>(
      'Basic Calculation 3',
      build: () => CalculatorBloc(),
      act: (bloc) =>
          bloc.add(const CalculatorEventEvaluateEquation(expression: '2*2')),
      expect: () => const <CalculatorState>[
        CalculatorState(result: '4'),
      ],
    );
    blocTest<CalculatorBloc, CalculatorState>(
      'Basic Calculation 4',
      build: () => CalculatorBloc(),
      act: (bloc) =>
          bloc.add(const CalculatorEventEvaluateEquation(expression: '2/2')),
      expect: () => const <CalculatorState>[
        CalculatorState(result: '1'),
      ],
    );
  });
}
