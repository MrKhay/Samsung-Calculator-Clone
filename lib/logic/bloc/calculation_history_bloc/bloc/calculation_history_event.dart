// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'calculation_history_bloc.dart';

abstract class CalculationHistoryEvent {
  const CalculationHistoryEvent();
}

class CalculationHistoryEventAddHistory extends CalculationHistoryEvent {
  final CalculationHistory calculationHistory;

  const CalculationHistoryEventAddHistory({
    required this.calculationHistory,
  });
}

class CalculationHistoryEventLoadHistorys extends CalculationHistoryEvent {
  const CalculationHistoryEventLoadHistorys();
}

class CalculationHistoryEventClearHistory extends CalculationHistoryEvent {
  const CalculationHistoryEventClearHistory();
}
