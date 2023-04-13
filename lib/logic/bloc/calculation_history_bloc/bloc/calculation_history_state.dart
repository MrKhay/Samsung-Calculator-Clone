// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'calculation_history_bloc.dart';

class CalculationHistoryState with EquatableMixin {
  final List<CalculationHistory> calculationHistoryData;
  final bool isLoading;
  const CalculationHistoryState({
    required this.calculationHistoryData,
    required this.isLoading,
  });

  @override
  List<Object> get props => calculationHistoryData;

  @override
  bool? get stringify => true;
}
