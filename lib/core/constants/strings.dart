import 'package:intl/intl.dart';

class Strings {}

// check if expression ends with an operator
final regExpMatchEndWithoutOperator = RegExp(r'([^\+\-\x/\÷])$');

// check if ends with operaotr
final regExpMatchEndWithOperator = RegExp(r'([\+\-\x/\÷\%/*/÷])$');

// check if contains numbersand operators
final regExpMatchContainsNumbersAndOperators =
    RegExp(r'([\+\-\x/\÷\%/*\./÷/0-9])');

// check if ends with number
final regExpMatchEndWithNumber = RegExp(r'[0-9]$');

// check if ends with closed bracket
final regExpMatchEndWithClosedBracket = RegExp(r'\)$');

// check if expression start with an bracket
final regExpMatchBeginsWithOpenBracket = RegExp(r'^\(');

// check if expression start with an operator
final regExpMatchBeginsWithOperator = RegExp(r'(^[\+\-\x/\÷\%/*/÷])');

// check if expression ends with operator then number
// final regExpMatchEndsWithOperatorThenNumber = RegExp(r'(^[\+\-\x/\÷\%/*/÷])');

// check if expression ends with operator then number
final regExpMatchEndsWithOperatorThenNumber = RegExp(r'[\+\-\x/\÷\%\*/]\d+$');

// check if expression ends with operator then number
final regExpMatchEndsWithOpenBracket = RegExp(r'.*\($');

// check if expression contains operators
final regExpMatchContainsOperator = RegExp(r'([\+\-\x/\÷\%/*/÷])');

// check if expression contains operators
final regExpMatchDoesNotContainsOperator = RegExp(r'[^\+\-\x\÷/%]');

// check if expression contains open bracket
final regExpMatchConatainOpenBracket = RegExp(r'\(');

// check if doesnt contain number
final regExpMatchDoesntConatinNumber = RegExp(r'[^0-9]');

// check if expression start with an bracket
final regExpMatchContainsBracketAndComma = RegExp(r'[(),]');
// check if end with number then closed bracket
final regExpMatchEndWithNumberThenClosBracket = RegExp(r'[*+/-]\d+\)$');

// starts with open bracket then number
final regExpMatchBeginOpenBracketEndNumber = RegExp(r'^\(\d+.*');

// check if  contain number
final regExpMatchConatinNumber = RegExp(r'[0-9]');

final regExpMatchConatainBrackets = RegExp(r'[\(\)]');
// format hunders 1,000,0000
final hundersFormatter = NumberFormat('#,##0', 'en_Us');

const invalidFormat = 'Invalid Format Used';

const digitGreaterThanNormal = 'Can\'t enter more than 15 digits.';
