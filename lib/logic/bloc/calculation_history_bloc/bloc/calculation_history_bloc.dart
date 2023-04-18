import 'package:bloc/bloc.dart';
import 'package:calculator/data/models/calculation_history.dart';
import 'package:calculator/data/repositories/local_database_protocol.dart';
import 'package:equatable/equatable.dart';

part 'calculation_history_event.dart';
part 'calculation_history_state.dart';

class CalculationHistoryBloc
    extends Bloc<CalculationHistoryEvent, CalculationHistoryState> {
  final LocalDataBaseProtocol historyDataProvider;
  CalculationHistoryBloc({required this.historyDataProvider})
      : super(CalculationHistoryState(
            calculationHistoryData:
                historyDataProvider.readAllData() as List<CalculationHistory>,
            isLoading: false)) {
    on<CalculationHistoryEventLoadHistorys>((event, emit) async {
      emit(CalculationHistoryState(
        calculationHistoryData: state.calculationHistoryData,
        isLoading: true,
      ));
      final calculationHistoryData = historyDataProvider.readAllData();

      if (calculationHistoryData.length > 30) {
        final sizedHistoryData = calculationHistoryData
            .getRange(calculationHistoryData.length - 30,
                calculationHistoryData.length)
            .toList();

        for (var i = 0; i < calculationHistoryData.length; i++) {
          if (i < calculationHistoryData.length - 30) {
            historyDataProvider
                .deleteData(calculationHistoryData[i] as CalculationHistory);
          }
        }

        emit(CalculationHistoryState(
          calculationHistoryData: sizedHistoryData as List<CalculationHistory>,
          isLoading: false,
        ));
      }
      emit(CalculationHistoryState(
        calculationHistoryData:
            calculationHistoryData as List<CalculationHistory>,
        isLoading: false,
      ));
    });
    on<CalculationHistoryEventAddHistory>((event, emit) async {
      emit(CalculationHistoryState(
        calculationHistoryData: state.calculationHistoryData,
        isLoading: true,
      ));
      await historyDataProvider.addData(event.calculationHistory);

    if (state.calculationHistoryData.length > 30) {
        final sizedHistoryData = state.calculationHistoryData
            .getRange(state.calculationHistoryData.length - 30,
                state.calculationHistoryData.length)
            .toList();

        for (var i = 0; i < state.calculationHistoryData.length; i++) {
          if (i < state.calculationHistoryData.length - 30) {
            historyDataProvider
                .deleteData(state.calculationHistoryData[i]);
          }
        }

        emit(CalculationHistoryState(
          calculationHistoryData: sizedHistoryData,
          isLoading: false,
        ));
      }
      final calculationHistoryData =
          historyDataProvider.readAllData() as List<CalculationHistory>;
      emit(CalculationHistoryState(
        calculationHistoryData: calculationHistoryData,
        isLoading: false,
      ));
    });
    on<CalculationHistoryEventClearHistory>((event, emit) async {
      emit(CalculationHistoryState(
        calculationHistoryData: state.calculationHistoryData,
        isLoading: true,
      ));

      await historyDataProvider.deleteAllData();
      final calculationHistoryData =
          historyDataProvider.readAllData() as List<CalculationHistory>;
      emit(CalculationHistoryState(
        calculationHistoryData: calculationHistoryData,
        isLoading: false,
      ));
    });
  }
}
