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
  String formatToHundreads() {
    final nonNumericExpressionParts = regExpMatchOnlyNonNumbers
        .allMatches(this)
        .map((e) => e.group(0))
        .toList();
    final numericExpressionParts =
        replaceAll(',', '').split(regExpMatchOnlyNumbersEulerAndDecimal);
    final formattedExpressionPartWithOperators = [];
    int operatorsIndex = 0;

    var expressionParts = trim().split(regExpMatchOnlyNonNumbers);
    var formattedNumericExpressionParts = [];

    for (var part in expressionParts) {
      // returns if part contains deciaml point
      if (part.contains('.')) {
        var formattedPart = part.formatExpressionWithDecimal();
        formattedNumericExpressionParts.add(formattedPart);
        // returns if parts contains only number
      } else if (regExpMatchConatinNumber.hasMatch(part)) {
        var formattedPart =
            hundersFormatter.format(num.parse(part.replaceAll(',', '')));
        formattedNumericExpressionParts.add(formattedPart);
        // return if part doesnt contain number
      } else {
        formattedNumericExpressionParts.add(part);
      }
    }

    for (int i = 0; i < formattedNumericExpressionParts.length; i++) {
      formattedExpressionPartWithOperators
          .add(formattedNumericExpressionParts.elementAt(i));

      if (i != formattedNumericExpressionParts.length - 1 &&
          operatorsIndex < nonNumericExpressionParts.length) {
        formattedExpressionPartWithOperators
            .add(nonNumericExpressionParts[operatorsIndex]);
        operatorsIndex++;
      }
    }

    while (operatorsIndex < nonNumericExpressionParts.length) {
      formattedExpressionPartWithOperators
          .add(nonNumericExpressionParts[operatorsIndex]);
      operatorsIndex++;
    }

    return formattedExpressionPartWithOperators.join('');
  }

  String format() {
    return replaceAll(',', '');
  }

  String parseExpression() {
    // contains formatted expression
    var formattedExpression = '';

    if (regExpMatchEndWithNumber.hasMatch(this)) {
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

  String getNum() {
    final regExpMatchNumbersAndPoint = RegExp(r'\d+(\.\d+)?');
    Iterable<Match> matches = regExpMatchNumbersAndPoint.allMatches(this);
    var numbers =
        matches.map((match) => num.parse(match.group(0) ?? '')).toList();

    return numbers.join('');
  }

  List<String> getLogFunctions() {
    final regExpMatchNumbersAndPoint = RegExp('[^0-9.]+');
    Iterable<Match> matches = regExpMatchNumbersAndPoint.allMatches(this);
    var numbers = matches.map((match) => match.group(0) ?? '').toList();

    return numbers;
  }

//   String formatToHundreads() {
//     // split inbetween of operators
//     final individualExpressions = split(regExpMatchContainsOperator);
//     // returns only operators
//     final operators = replaceAll(regExpMatchDoesNotContainsOperator, '');

//     List<String> formattedExpressionParts = [];
//     List<String> formattedExpressionPartWithOperators = [];
//     int operatorsIndex = 0;

//     // returns if expression is empty
//     if (isEmpty) {
//       return '';
//     }

// // if expression contains bracket
//     if (regExpMatchConatainBrackets.hasMatch(this)) {
//       for (var part in individualExpressions) {
//         if (regExpMatchContainsLogFunction.hasMatch(part)) {
//           print(part);
//           if (regExpMatchConatinNumber.hasMatch(part)) {
//             // check if contains decimal
//             if (part.contains('.')) {
//               final functions = part.split(regExpMatchConatinNumber);
//               final numbers = part.getNum().formatExpressionWithDecimal();

//               final firstPart = part.replaceAll(',', '').getLogFunctions();
//               final formattedExpression = functions.last == ')'
//                   ? '${firstPart.getRange(0, firstPart.length - 1).join('')}$numbers)'
//                   : '${firstPart.join('')}$numbers';
//               formattedExpressionParts.add(formattedExpression);
//             } else {
//               final functions = part.split(regExpMatchConatinNumber);
//               final numbers = part.getNum().parseExpression();
//               final firstPart = part.replaceAll(',', '').getLogFunctions();

//               final formattedExpression = functions.last == ')'
//                   ? '${firstPart.getRange(0, firstPart.length - 1).join('')}$numbers)'
//                   : '${firstPart.join('')}$numbers';
//               formattedExpressionParts.add(formattedExpression);
//             }
//           } else {
//             formattedExpressionParts.add(part);
//           }
//         }

//         if (RegExp(r'[\(\)]').hasMatch(part)) {
//           if (part.startsWith('(')) {
//             final formattedExpression =
//                 part.replaceAll(regExpMatchConatainBrackets, '');

//             if (formattedExpression.isNotEmpty) {
//               final expressionPart = part.contains('.')
//                   ? '(${part.formatExpressionWithDecimal()}'
//                   : '(${formattedExpression.replaceAll(',', '').parseExpression()}';
//               formattedExpressionParts.add(expressionPart);
//             } else {
//               formattedExpressionParts.add('(');
//             }
//           } else if (part.endsWith(')')) {
//             // returns if parts contains log functions
//             if (regExpMatchContainsLogFunction.hasMatch(part)) {
//               break;
//             }

//             final formattedExpression = part
//                 .replaceAll(regExpMatchConatainBrackets, '')
//                 .replaceAll(',', '');

//             final expressionPart = part.contains('.')
//                 ? '${part.formatExpressionWithDecimal()})'
//                 : '${formattedExpression.replaceAll(',', '').parseExpression()})';
//             formattedExpressionParts.add(expressionPart);
//           }
//         } else if (part == '') {
//           break;
//         } else {
//           final expressionPart = part.contains('.')
//               ? part.formatExpressionWithDecimal()
//               : part
//                   .replaceAll(RegExp(r'([\+\-\x/\,\÷\%])'), '')
//                   .parseExpression();
//           formattedExpressionParts.add(expressionPart);
//         }
//       }

//       for (int i = 0; i < formattedExpressionParts.length; i++) {
//         formattedExpressionPartWithOperators
//             .add(formattedExpressionParts.elementAt(i));

//         if (i != formattedExpressionParts.length - 1 &&
//             operatorsIndex < operators.length) {
//           formattedExpressionPartWithOperators.add(operators[operatorsIndex]);
//           operatorsIndex++;
//         }
//       }

//       while (operatorsIndex < operators.length) {
//         formattedExpressionPartWithOperators.add(operators[operatorsIndex]);
//         operatorsIndex++;
//       }

//       return formattedExpressionPartWithOperators.join('');
//     }

//     /*
//      returns when expression does not end with an operator,
//      formats each expression part then add its operator
//      */
//     for (var part in individualExpressions) {
//       if (part.contains('.')) {
//         formattedExpressionParts.add(part.formatExpressionWithDecimal());
//       } else if (part == '') {
//         break;
//       } else {
//         part = part.replaceAll(',', '').parseExpression();
//         formattedExpressionParts.add(part);
//       }
//     }
//     for (int i = 0; i < formattedExpressionParts.length; i++) {
//       formattedExpressionPartWithOperators
//           .add(formattedExpressionParts.elementAt(i));

//       if (i != formattedExpressionParts.length - 1 &&
//           operatorsIndex < operators.length) {
//         formattedExpressionPartWithOperators.add(operators[operatorsIndex]);
//         operatorsIndex++;
//       }
//     }

//     while (operatorsIndex < operators.length) {
//       formattedExpressionPartWithOperators.add(operators[operatorsIndex]);
//       operatorsIndex++;
//     }
//     return formattedExpressionPartWithOperators.join('');
//   }

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
