import 'package:calculator/data/models/calculation_history.dart';
import 'package:hive/hive.dart';

import '../../repositories/local_database_protocol.dart';

class CalculationHistoryDataProvider implements LocalDataBaseProtocol {
  @override
  Future<Box<Object>> initDataBase() async {
    // open data box
    Hive.registerAdapter(CalculationHistoryAdapter());

    return await Hive.openBox<CalculationHistory>('calculationHistory');
  }

  @override
  Future<void> createData(CalculationHistory calculationHistory) async {
    final box = Hive.box<CalculationHistory>('calculationHistory');
    await box.add(calculationHistory);
  }

  @override
  Future<void> deleteAllData() async {
    final box = Hive.box<CalculationHistory>('calculationHistory');
    await box.clear();
  }

  @override
  Future<void> deleteData(CalculationHistory calculationHistory) async {
    final box = Hive.box<CalculationHistory>('calculationHistory');
    await box.delete(calculationHistory.key);
  }

  @override
  List<CalculationHistory> readAllData() {
    final box = Hive.box<CalculationHistory>('calculationHistory');
    return box.values.toList();
  }

  @override
  Future<void> addData(CalculationHistory calculationHistory) async {
    final box = Hive.box<CalculationHistory>('calculationHistory');
    await box.add(calculationHistory);
  }
}
