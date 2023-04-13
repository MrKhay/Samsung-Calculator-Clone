// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'calculation_history.g.dart';

@immutable
@HiveType(typeId: 0)
class CalculationHistory with EquatableMixin, HiveObjectMixin {
  @HiveField(0)
  final String expression;
  @HiveField(1)
  final String expressionResult;

  CalculationHistory({
    required this.expression,
    required this.expressionResult,
  });

  CalculationHistory copyWith({
    String? expression,
    String? expressionResult,
  }) {
    return CalculationHistory(
      expression: expression ?? this.expression,
      expressionResult: expressionResult ?? this.expressionResult,
    );
  }

  @override
  List<Object> get props => [expression, expressionResult];

  @override
  bool get stringify => true;
}
