// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'calculatormode_bloc.dart';

abstract class CalculatormodeEvent {
  const CalculatormodeEvent();
}

class CalculatormodeEventToggleLogInverse extends CalculatormodeEvent {}

class CalculatormodeEventToggleThemeMode extends CalculatormodeEvent {
  final ThemeData themeMode;
  CalculatormodeEventToggleThemeMode({
    required this.themeMode,
  });
}
