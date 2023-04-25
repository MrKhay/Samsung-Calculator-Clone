// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'calculator_bloc.dart';

@immutable
class CalculatorState extends Equatable {
  final String result;
  final bool isLogInverseMode;
  final bool isLogRad;
  const CalculatorState({
    required this.result,
    this.isLogInverseMode = false,
    this.isLogRad = false,
  });

  @override
  List<Object> get props => [result, isLogInverseMode,isLogRad];

  @override
  bool get stringify => true;
}
