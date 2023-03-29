// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'calculator_bloc.dart';

@immutable
class CalculatorState extends Equatable {
  final String result;
  const CalculatorState({
    required this.result,
  });

  @override
  List<Object> get props => [result];

  @override
  bool get stringify => true;
}
