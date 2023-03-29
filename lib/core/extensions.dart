import 'package:intl/intl.dart';

extension ValidExpression on String {
  bool isValidExpression() {
    // check if expression ends with an operator
    var regExpression1 = RegExp(r'([^\+\-\x/\(÷)])$');
    // check if expression contains operators
    var regExpression2 = RegExp(r'([\+\-\x/\(÷)\%])');

    return regExpression1.hasMatch(this) && regExpression2.hasMatch(this);
  }

  bool endsWithAlritimeticOperator() {
    // check if expression ends with an operator
    var regExpression1 = RegExp(r'([\+\-\*/\(\)])$');

    return regExpression1.hasMatch(this);
  }
}

extension FormatExpression on String {
  String formatNumWithDecimal() {
    // format number with decimals
    final formatter = NumberFormat('#,##0', 'en_Us');
    var expressionHolder = split('.');
    var formattedExpression =
        formatter.format(num.parse(expressionHolder[0].replaceAll(',', '')));

    return '$formattedExpression.${expressionHolder[1]}';
  }

  String formatStringToNum() {
    final data = int.parse(replaceAll(RegExp(r'[^0-9]'), ''));
    final formatter = NumberFormat('#,##0', 'en_Us');
    final formatted = formatter.format(data);
    return formatted.toString().trim();
  }

  String formatToHundreads() {
    final formatter = NumberFormat('#,##0', 'en_Us');
    // split inbetween of operators
    final parts = split(RegExp(r'([\+\-\x/\÷\%])'));

    // returns only operators
    final operators = replaceAll(RegExp(r'[^\+\-\x\÷/%]'), '');

    // check if expression ends with an operator
    final regExpressionCheck = RegExp(r'([\+\-\x/\÷/%])$');
    List<String> newFormatterInt = [];
    List<String> formattedInt = [];
    var operatorsIndex = 0;

// check if string isempty
    if (isEmpty) {
      return '';
    }

// check if expression ends with an operator
    if (regExpressionCheck.hasMatch(this)) {
      var newParts = parts.getRange(0, parts.length - 1);

      for (var part in newParts) {
        if (part.contains('.')) {
          formattedInt.add(part.formatNumWithDecimal());
        } else {
          formattedInt
              .add(formatter.format(num.parse(part.replaceAll(',', ''))));
        }
      }

      for (int i = 0; i < formattedInt.length; i++) {
        newFormatterInt.add(formattedInt.elementAt(i));

        if (i != formattedInt.length - 1 && operatorsIndex < operators.length) {
          newFormatterInt.add(operators[operatorsIndex]);
          operatorsIndex++;
        }
      }

      while (operatorsIndex < operators.length) {
        newFormatterInt.add(operators[operatorsIndex]);
        operatorsIndex++;
      }

      return newFormatterInt.join('');
    }

// format expression
    for (var part in parts) {
      if (part.contains('.')) {
        formattedInt.add(part.formatNumWithDecimal());
      } else {
        part = formatter.format(num.parse(part.replaceAll(',', '')));
        formattedInt.add(part);
      }
    }
    for (int i = 0; i < formattedInt.length; i++) {
      newFormatterInt.add(formattedInt.elementAt(i));

      if (i != formattedInt.length - 1 && operatorsIndex < operators.length) {
        newFormatterInt.add(operators[operatorsIndex]);
        operatorsIndex++;
      }
    }

    while (operatorsIndex < operators.length) {
      newFormatterInt.add(operators[operatorsIndex]);
      operatorsIndex++;
    }
    return newFormatterInt.join('');
  }

  num covertStringToNum() {
    var data = num.parse(replaceAll(RegExp(r'[^0-9]'), ''));
    return data;
  }
}

extension FormatNumberTo on String {
  String formatNum() {
    final formatter = NumberFormat('#,##0', 'en_Us');

    if (isEmpty) {
      return '';
    } else {
      final formatted = formatter.format(num.parse(this));

      if (toString().contains('.')) {
        return formatNumWithDecimal();
      } else {
        return formatted.toString().trim();
      }
    }
  }
}
