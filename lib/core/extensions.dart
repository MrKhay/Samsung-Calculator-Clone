import 'constants/strings.dart';

extension ValidExpression on String {
  bool validateExpressionLength() {
    final expression = replaceAll(regExpMatchContainsBracketAndComma, '');
    final expressionPart = expression.split(regExpMatchContainsOperator);
    bool isGreaterthanNormal = false;

// returns when expressions does not contain operators
    if (!contains(regExpMatchContainsOperator)) {
      isGreaterthanNormal = expression.length > 14;
    }

    for (var part in expressionPart) {
      if (part.length > 14) {
        isGreaterthanNormal = true;
      } else {
        isGreaterthanNormal = false;
      }
    }

    if (regExpMatchEndWithOperator.hasMatch(expression)) {
      isGreaterthanNormal = false;
    }
    return isGreaterthanNormal;
  }

  bool isValidExpression() {
    return regExpMatchEndWithoutOperator.hasMatch(this) &&
        regExpMatchContainsOperator.hasMatch(this);
  }

  bool endsWithAlritimeticOperator() {
    return regExpMatchEndWithOperator.hasMatch(this);
  }

  bool validateBrackets() {
    final bracket = replaceAll(regExpMatchContainsNumbersAndOperators, '');
    final openBrackets = bracket.split('').where((element) => element == '(');
    final closedBrackets = bracket.split('').where((element) => element == ')');

    return openBrackets.length == closedBrackets.length;
  }

  bool validateNumberOfBrackets() {
    final bracket = replaceAll(regExpMatchContainsNumbersAndOperators, '');
    final openBrackets = bracket.split('').where((element) => element == '(');
    final closedBrackets = bracket.split('').where((element) => element == ')');

    return openBrackets.length == closedBrackets.length;
  }

  List<String> splitExpression() {
    List<String> expression = [];
    List<String> numList = [];

    for (var part in split('')) {
      if (part == '(') {
        expression.add(part);
      }

      if (regExpMatchConatinNumber.hasMatch(part)) {
        numList.add(part);
      }
    }
    expression.add(numList.join(''));
    return expression;
  }

  bool validateLastTwoExpression() {
    final data = split(regExpMatchContainsOperator);
    final bracket = replaceAll(RegExp(r'([\+\-\x/\÷\%/*./÷/0-9])'), '');
    final closedBrackets = bracket.split('').where((element) => element == ')');
    final openedBrackets = bracket.split('').where((element) => element == '(');
    int numOfClosingBrackets = 0;

    for (int i = 0; i < data.length; i++) {
      var part = data[i].splitExpression();
      var dataExp = data[i];

      if (part.length == 2 &&
          regExpMatchBeginOpenBracketEndNumber.hasMatch(dataExp)) {
        if (data.length > i + 1) {
          if (regExpMatchConatinNumber.hasMatch(data[i + 1])) {
            numOfClosingBrackets++;
          }
        }
      }
    }

    return numOfClosingBrackets == closedBrackets.length;
  }
}

extension FormatExpression on String {
  String format() {
    return replaceAll(',', '');
  }

  String parseExpression() {
    // contains formatted expression
    var formattedExpression = '';

    if (regExpMatchConatinNumber.hasMatch(this)) {
      formattedExpression = hundersFormatter.format(num.parse(this));
    } else {
      formattedExpression = this;
    }

    return formattedExpression;
  }

  String formatExpressionWithDecimal() {
    final expressionHolder = split('.');
    final formattedExpression = hundersFormatter.format(num.parse(
        expressionHolder[0].replaceAll(regExpMatchConatainBrackets, '')));

    return '$formattedExpression.${expressionHolder[1]}';
  }

  String formatStringToNum() {
    final data = int.parse(replaceAll(regExpMatchDoesntConatinNumber, ''));
    final formatted = hundersFormatter.format(data);
    return formatted.toString();
  }

  String formatToHundreads() {
    // split inbetween of operators
    final individualExpressions = split(regExpMatchContainsOperator);
    // returns only operators
    final operators = replaceAll(regExpMatchDoesNotContainsOperator, '');

    List<String> formattedExpressionParts = [];
    List<String> formattedExpressionPartWithOperators = [];
    int operatorsIndex = 0;

    // returns if expression is empty
    if (isEmpty) {
      return '';
    }

// if expression contains bracket
    if (regExpMatchConatainBrackets.hasMatch(this)) {
      for (var part in individualExpressions) {
        if (RegExp(r'[\(\)]').hasMatch(part)) {
          if (part.startsWith('(')) {
            final formattedExpression =
                part.replaceAll(regExpMatchConatainBrackets, '');

            if (formattedExpression.isNotEmpty) {
              final expressionPart = part.contains('.')
                  ? '(${part.formatExpressionWithDecimal()}'
                  : '(${formattedExpression.replaceAll(',', '').parseExpression()}';
              formattedExpressionParts.add(expressionPart);
            } else {
              formattedExpressionParts.add('(');
            }
          } else if (part.endsWith(')')) {
            final formattedExpression = part
                .replaceAll(regExpMatchConatainBrackets, '')
                .replaceAll(',', '');

            final expressionPart = part.contains('.')
                ? '${part.formatExpressionWithDecimal()})'
                : '${formattedExpression.replaceAll(',', '').parseExpression()})';
            formattedExpressionParts.add(expressionPart);
          }
        } else if (part == '') {
          break;
        } else {
          final expressionPart = part.contains('.')
              ? part.formatExpressionWithDecimal()
              : part
                  .replaceAll(RegExp(r'([\+\-\x/\,\÷\%])'), '')
                  .parseExpression();
          formattedExpressionParts.add(expressionPart);
        }
      }

      for (int i = 0; i < formattedExpressionParts.length; i++) {
        formattedExpressionPartWithOperators
            .add(formattedExpressionParts.elementAt(i));

        if (i != formattedExpressionParts.length - 1 &&
            operatorsIndex < operators.length) {
          formattedExpressionPartWithOperators.add(operators[operatorsIndex]);
          operatorsIndex++;
        }
      }

      while (operatorsIndex < operators.length) {
        formattedExpressionPartWithOperators.add(operators[operatorsIndex]);
        operatorsIndex++;
      }

      return formattedExpressionPartWithOperators.join('');
    }

    // retuns if expression ends with an operator
    // if (regExpMatchEndWithOperator.hasMatch(this)) {
    //   /*
    //    take all expression part else the ending operator
    //    e.g 3'4500+900+80- return 34500+900+80
    //   */
    //   final expressionParts =
    //       individualExpressions.getRange(0, individualExpressions.length - 1);

    //   // format each parts
    //   for (var part in expressionParts) {
    //     if (part.contains('.')) {
    //       // returns if part contains decimal
    //       formattedExpressionParts.add(part.formatExpressionWithDecimal());
    //     } else {
    //       formattedExpressionParts.add(
    //           // retuns and removes all ','
    //           hundersFormatter.format(num.parse(part.replaceAll(',', ''))));
    //     }
    //   }

    //   // add operators back to expressions
    //   for (int i = 0; i < formattedExpressionParts.length; i++) {
    //     formattedExpressionPartWithOperators
    //         .add(formattedExpressionParts.elementAt(i));

    //     if (i != formattedExpressionParts.length - 1 &&
    //         operatorsIndex < operators.length) {
    //       formattedExpressionPartWithOperators.add(operators[operatorsIndex]);
    //       operatorsIndex++;
    //     }
    //   }

    //   while (operatorsIndex < operators.length) {
    //     formattedExpressionPartWithOperators.add(operators[operatorsIndex]);
    //     operatorsIndex++;
    //   }

    //   return formattedExpressionPartWithOperators.join('');
    // }

    /*
     returns when expression does not end with an operator, 
     formats each expression part then add its operator
     */
    for (var part in individualExpressions) {
      if (part.contains('.')) {
        formattedExpressionParts.add(part.formatExpressionWithDecimal());
      } else if (part == '') {
        break;
      } else {
        part = part.replaceAll(',', '').parseExpression();
        formattedExpressionParts.add(part);
      }
    }
    for (int i = 0; i < formattedExpressionParts.length; i++) {
      formattedExpressionPartWithOperators
          .add(formattedExpressionParts.elementAt(i));

      if (i != formattedExpressionParts.length - 1 &&
          operatorsIndex < operators.length) {
        formattedExpressionPartWithOperators.add(operators[operatorsIndex]);
        operatorsIndex++;
      }
    }

    while (operatorsIndex < operators.length) {
      formattedExpressionPartWithOperators.add(operators[operatorsIndex]);
      operatorsIndex++;
    }
    return formattedExpressionPartWithOperators.join('');
  }

  num covertStringToNum() {
    var data = num.parse(replaceAll(regExpMatchDoesntConatinNumber, ''));
    return data;
  }
}

extension FormatNumberTo on String {
  String formatNum() {
    if (isEmpty) {
      return '';
    } else {
      final formatted = hundersFormatter.format(num.parse(this));

      if (toString().contains('.')) {
        return formatExpressionWithDecimal();
      } else {
        return formatted.toString().trim();
      }
    }
  }
}
