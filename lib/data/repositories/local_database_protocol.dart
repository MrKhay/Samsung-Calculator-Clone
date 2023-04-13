import 'package:calculator/data/models/calculation_history.dart';

import 'package:hive/hive.dart';

abstract class LocalDataBaseProtocol {
  // init database
  Future<Box<Object>> initDataBase();
  // creat a new recode
  Future<void> createData(CalculationHistory calculationHistory);
  // read all
  List<Object> readAllData();

  // update a recode
  Future<void> addData(CalculationHistory calculationHistory);

  // delete data
  Future<void> deleteData(CalculationHistory calculationHistory);
  // delete all data
  Future<void> deleteAllData();
}
