// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:calculator/core/extensions.dart';
import 'package:calculator/data/models/calculation_history.dart';
import 'package:calculator/logic/bloc/calculation_history_bloc/bloc/calculation_history_bloc.dart';
import 'package:flutter/material.dart';
import 'package:calculator/presentation/screens/home_screen/widgets/custom_textcontroller.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/strings.dart';
import '../../data/models/buttondata.dart';
import '../../logic/bloc/calculator_bloc/bloc/calculator_bloc.dart';
import 'custom_font.dart';

class CustomButton extends StatefulWidget {
  final CustomTextEditingController textEditingController;
  final ButtonData buttonData;
  final AnimationController positionAnimationController;
  final AnimationController colorAnimationController;
  final AnimationController visibilityAnimationController;

  const CustomButton({
    Key? key,
    required this.textEditingController,
    required this.buttonData,
    required this.positionAnimationController,
    required this.colorAnimationController,
    required this.visibilityAnimationController,
  }) : super(key: key);

  @override
  CustomButtonState createState() => CustomButtonState();
}

class CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  final _duration = const Duration(milliseconds: 200);
  final integerNumbers = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'];
  final alritimeticOperators = ['+', '-', '÷', 'x', '%'];
  bool isClicked = false;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _duration);

    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 1.3).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final buttonData = widget.buttonData;
    final mathExpressionController = widget.textEditingController;
    final expressionResult = context.watch<CalculatorBloc>().state.result;

    void toggleScale() async {
      _animationController.forward();
      await Future.delayed(_duration);
      _animationController.reset();
    }

    return MaterialButton(
      color: buttonData.buttonText == '=' ? Colors.green : Colors.white10,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Text(
              widget.buttonData.buttonText,
              style: customFont(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: buttonData.textColor),
            ),
          );
        },
      ),
      onPressed: () {
        final animationStatus = widget.positionAnimationController.status ==
            AnimationStatus.completed;

        final mathExpression = widget.textEditingController.text;

        // triggers haptic feedback
        toggleScale();
        HapticFeedback.mediumImpact();

        //Add '+' to the equation and if '+' is already their dont add
        //If eqation has been calculated and user wants to add + again
        //set the result to the new eqation and add '+'

        if (alritimeticOperators.contains(buttonData.buttonText)) {
          // returns when expression contains same operator

          if (regExpMatchEndWithOperator.hasMatch(mathExpression)) {
            showToast(invalidFormat);
            return;
          }
          // retuns when expression is empty
          if (mathExpression.isEmpty) {
            showToast(invalidFormat);
            return;
          }

          // returns when equals is clicked.. rest animation and
          // add new operator to the expreesion

          if (animationStatus) {
            resetAnimation();
            mathExpressionController.clear();
            if (regExpMatchBeginsWithOperator.hasMatch(expressionResult)) {
              // returns expression without operator
              var data = expressionResult
                  .split('')
                  .getRange(1, expressionResult.length)
                  .join('');
              // returns only operator
              var dataOperator =
                  expressionResult.split('').getRange(0, 1).join('');

              editiText('($dataOperator$data${buttonData.buttonText}',
                  mathExpressionController);
              return;
            }

            editiText('$expressionResult${buttonData.buttonText}',
                mathExpressionController);
            return;
          }

          // retunr when expression end s with brackte and operator is + ÷ % x
          if (regExpMatchEndsWithOpenBracket.hasMatch(mathExpression)) {
            if (buttonData.buttonText == '+' ||
                buttonData.buttonText == 'x' ||
                buttonData.buttonText == '÷' ||
                buttonData.buttonText == '%') {
              return;
            }
            editiText(buttonData.buttonText, mathExpressionController);
            return;
          }
          editiText(buttonData.buttonText, mathExpressionController);
        }

        // returns when button text is = and expression is valid
        if (buttonData.buttonText == '=') {
          if (mathExpression.isValidExpression()) {
            widget.positionAnimationController.forward();
            widget.colorAnimationController.forward();
            widget.visibilityAnimationController.forward();
            context
                .read<CalculationHistoryBloc>()
                .add(CalculationHistoryEventAddHistory(
                  calculationHistory: CalculationHistory(
                      expression: mathExpressionController.text,
                      expressionResult: expressionResult),
                ));
          }
          // returns if expression ends with operator
          if (regExpMatchEndWithOperator.hasMatch(mathExpression)) {
            showToast(invalidFormat);
            return;
          }
        }
        if (buttonData.buttonText == '+/-') {
          if (animationStatus) {
            resetAnimation();
            var data = expressionResult;
            mathExpressionController.clear();
            // check if data ends with operator

            if (regExpMatchBeginsWithOperator.hasMatch(data)) {
              // clears the operator and return value
              var newData = data.replaceAll('-', '');
              editiText(newData, mathExpressionController);
            } else {
              editiText('(-$data', mathExpressionController);
            }
          }
          // return mathexpression is empty
          if (mathExpression.isEmpty) {
            editiText('(-', mathExpressionController);
            return;
          }

          // return ends with closed baracket
          if (regExpMatchEndWithClosedBracket.hasMatch(mathExpression)) {
            editiText('x(-', mathExpressionController);
            return;
          }
        }

        // returns when input is 0-9
        if (integerNumbers.contains(buttonData.buttonText)) {
          // returns when animation has been ran
          if (animationStatus) {
            resetAnimation();
            mathExpressionController.clear();
            editiText(buttonData.buttonText, mathExpressionController);
            return;
          }
          // returns when expression length is greater than 15
          if (mathExpression.validateExpressionLength()) {
            showToast(digitGreaterThanNormal);

            return;
          }

          editiText(buttonData.buttonText, mathExpressionController);
        }

        // returns when is button text is C
        if (buttonData.buttonText == 'C') {
          resetAnimation();
          mathExpressionController.clear();
        }

        // retuns when button is .
        if (buttonData.buttonText == '.') {
          if (mathExpression.isEmpty) {
            editiText('0.', mathExpressionController);
          }
          editiText(buttonData.buttonText, mathExpressionController);
          return;
        }

        // returns if button text is ( )
        if (buttonData.buttonText == '( )') {
          // returns if expression is empty
          if (mathExpression.isEmpty) {
            editiText('(', mathExpressionController);
            return;
          }
          // returns when equal button is been pressed
          if (animationStatus) {
            resetAnimation();
            var data = expressionResult;
            mathExpressionController.clear();
            editiText('${data}x(', mathExpressionController);
            return;
          }
          // returns when expression ends with operator
          // then number
          if (!mathExpression.validateLastTwoExpression()) {
            editiText(')', mathExpressionController);
            return;
          }

          // returns when expression ends with operator
          if (regExpMatchEndWithOperator.hasMatch(mathExpression)) {
            editiText('(', mathExpressionController);
            return;
          }

          // returns when expression ends with closed bracket
          if (regExpMatchEndWithClosedBracket.hasMatch(mathExpression)) {
            editiText('x(', mathExpressionController);

            return;
          }

          // returns when expression ends with closed bracket
          if (regExpMatchEndWithNumber.hasMatch(mathExpression.format())) {
            editiText('x(', mathExpressionController);
            return;
          }
          if (regExpMatchEndsWithOperatorThenNumber
                  .hasMatch(mathExpression.format()) &&
              regExpMatchConatainOpenBracket.hasMatch(mathExpression)) {
            editiText(')', mathExpressionController);
            return;
          }
        }

        setState(() {});
      },
    );
  }

  void resetAnimation() {
    widget.positionAnimationController.reset();
    widget.colorAnimationController.reset();
    widget.visibilityAnimationController.reset();
  }
}

void editiText(String data, CustomTextEditingController controller) {
  final mathExpression = controller.value;
  final newMathExpression = TextEditingValue(
      text: mathExpression.text.replaceRange(
        mathExpression.selection.baseOffset,
        mathExpression.selection.extentOffset,
        data,
      ),
      selection: TextSelection.collapsed(
        offset: mathExpression.selection.baseOffset + data.length,
      ));
  var expressionValue = newMathExpression.text.formatToHundreads();
  final newExpressionValue = newMathExpression.copyWith(
      text: expressionValue,
      selection: TextSelection.collapsed(
        offset: expressionValue.length,
      ));
  controller.value = newExpressionValue;
}
