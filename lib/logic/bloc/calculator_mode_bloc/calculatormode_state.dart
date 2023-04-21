// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'calculatormode_bloc.dart';

class CalculatorModeState extends Equatable {
  final ThemeData themeMode;
  final bool isLogInverseMode;
  const CalculatorModeState({
    required this.themeMode,
    required this.isLogInverseMode,
  });

  CalculatorModeState.initState()
      : isLogInverseMode = false,
        themeMode = AppTheme.darkTheme;

  @override
  List<Object> get props => [themeMode, isLogInverseMode];
}
