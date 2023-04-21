import 'package:bloc/bloc.dart';
import 'package:calculator/core/themes/app_theme.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'calculatormode_event.dart';
part 'calculatormode_state.dart';

class CalculatorModeBloc
    extends Bloc<CalculatormodeEvent, CalculatorModeState> {
  CalculatorModeBloc() : super(CalculatorModeState.initState()) {
    on<CalculatormodeEventToggleLogInverse>((event, emit) {
      emit(
        CalculatorModeState(
          themeMode: state.themeMode,
          isLogInverseMode: !state.isLogInverseMode,
        ),
      );
    });

    on<CalculatormodeEventToggleThemeMode>((event, emit) {
      emit(
        CalculatorModeState(
          themeMode: event.themeMode,
          isLogInverseMode: !state.isLogInverseMode,
        ),
      );
    });
  }
}
