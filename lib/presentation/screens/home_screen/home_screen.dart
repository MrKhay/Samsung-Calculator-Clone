import 'package:calculator/core/constants/strings.dart';
import 'package:calculator/core/extensions.dart';
import 'package:calculator/data/models/buttondata.dart';
import 'package:calculator/logic/bloc/calculator_bloc/bloc/calculator_bloc.dart';
import 'package:calculator/presentation/screens/home_screen/widgets/custom_textcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../common_widgets/custom_font.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final AnimationController _colorAnimationController;
  late final Animation<AlignmentGeometry> _animationPosition;
  late final Animation<double> _animationScale;
  late final Animation<Color> _animationColor;
  late TextEditingController mathExpressionController;
  final integerNumbers = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'];
  final alritimeticOperators = ['+', '-', '÷', 'x', '%'];

  bool isClicked = false;

  @override
  void initState() {
    super.initState();
    mathExpressionController = CustomTextEditingController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
    );
    _colorAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        microseconds: 500,
      ),
    );
    _animationPosition =
        Tween(begin: Alignment.bottomRight, end: Alignment.topRight).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linearToEaseOut,
      ),
    );
    _animationColor =
        Tween<Color>(begin: Colors.grey, end: Colors.green).animate(
      CurvedAnimation(
        parent: _colorAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationScale = Tween<double>(begin: 1, end: 1.7).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _colorAnimationController.dispose();
    mathExpressionController.dispose();

    super.dispose();
  }

  void resetAnimation() {
    isClicked = false;
    _animationController.reset();
    _colorAnimationController.reset();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final expressionResult = context.watch<CalculatorBloc>().state.result;

    mathExpressionController.addListener(() {
      calculate(text: mathExpressionController.text, context: context);
    });
    void editiText(String data) {
      final mathExpression = mathExpressionController.value;
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
      mathExpressionController.value = newExpressionValue;
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            SizedBox(
              height: height * 0.35,
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: !isClicked,
                    child: ScaleTransition(
                      scale: _animationScale,
                      child: Container(
                        height: height * 0.08,
                        // color: Colors.grey,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(top: 40, right: 40),
                        child: TextField(
                          textAlign: TextAlign.end,
                          autofocus: true,
                          controller: mathExpressionController,
                          keyboardType: TextInputType.none,
                          cursorColor: Colors.greenAccent,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp("[0-9]"),
                            ),
                          ],
                          style: customFont(
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 4,
                    child: Container(
                      padding: const EdgeInsets.all(40),
                      height: double.infinity,
                      width: width,
                      child: Column(
                        children: [
                          Expanded(
                            child: AlignTransition(
                              alignment: _animationPosition,
                              child: ScaleTransition(
                                scale: _animationScale,
                                alignment: Alignment.topRight,
                                child: AnimatedBuilder(
                                    animation: _animationColor,
                                    builder: (context, child) {
                                      return Text(
                                        expressionResult.formatNum(),
                                        style: customFont(
                                            color: _animationColor.value,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      );
                                    }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                      child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              FeatherIcons.clock,
                              color: Colors.grey,
                              size: 20,
                            )),
                        const SizedBox(width: 10),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.horizontal_rule_outlined,
                              color: Colors.grey,
                              size: 20,
                            )),
                        const SizedBox(width: 10),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.calculate_outlined,
                              color: Colors.grey,
                              size: 20,
                            )),
                        const Spacer(),
                        AbsorbPointer(
                          absorbing: mathExpressionController.text.isEmpty,
                          child: IconButton(
                              onPressed: () {
                                // triggers haptic feedback
                                HapticFeedback.mediumImpact();
                                if (isClicked) {
                                  resetAnimation();
                                  final expression =
                                      expressionResult.toString();
                                  mathExpressionController.clear();
                                  editiText(expression);
                                }
                                var oldValue = mathExpressionController.value;
                                int cursorPosition = oldValue.selection.start;
                                String newValueText = oldValue.text
                                        .substring(0, cursorPosition - 1) +
                                    oldValue.text.substring(
                                      cursorPosition,
                                    );
                                var newValue = TextEditingValue(
                                  text: newValueText,
                                  selection: TextSelection.collapsed(
                                      offset: cursorPosition - 1),
                                );

                                var textData =
                                    newValue.text.formatToHundreads();
                                var newValue1 = newValue.copyWith(
                                    text: textData,
                                    selection: TextSelection.collapsed(
                                      offset: textData.length,
                                    ));
                                mathExpressionController.value = newValue1;
                                setState(() {});
                              },
                              icon: Icon(
                                FeatherIcons.delete,
                                color: mathExpressionController.text.isEmpty
                                    ? Colors.green.withOpacity(0.5)
                                    : Colors.green,
                                size: 20,
                              )),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
            Container(
              width: width,
              height: 0.2,
              color: Colors.grey,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            ),
            Expanded(
              child: SizedBox(
                width: width,
                child: GridView.count(
                    childAspectRatio: 1.25,
                    crossAxisCount: 4,
                    mainAxisSpacing: 10,
                    padding: const EdgeInsets.all(5),
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(
                      buttonGridItems.length,
                      (index) {
                        final gridItemData = buttonGridItems[index];
                        return Semantics(
                          child: MaterialButton(
                            color: index == 19 ? Colors.green : Colors.white10,
                            onPressed: () {
                              final mathExpression =
                                  mathExpressionController.text;
                              // triggers haptic feedback
                              HapticFeedback.mediumImpact();

                              /*
                               Add '+' to the equation and if '+' is already their dont add
                               If eqation has been calculated and user wants to add + again 
                               set the result to the new eqation and add '+' 
                              */

                              if (alritimeticOperators
                                  .contains(gridItemData.buttonText)) {
                                // returns when expression contains same operator

                                if (regExpMatchEndWithOperator
                                    .hasMatch(mathExpression)) {
                                  showToast(invalidFormat);
                                  return;
                                }
                                // retuns when expression is empty
                                if (mathExpression.isEmpty) {
                                  showToast(invalidFormat);
                                  return;
                                }
                                /* 
                                  returns when equals is clicked.. rest animation and 
                                  add new operator to the expreesion 
                                */

                                if (isClicked) {
                                  resetAnimation();

                                  mathExpressionController.clear();
                                  if (regExpMatchBeginsWithOperator
                                      .hasMatch(expressionResult)) {
                                    // returns expression without operator
                                    var data = expressionResult
                                        .split('')
                                        .getRange(1, expressionResult.length)
                                        .join('');
                                    // returns only operator
                                    var dataOperator = expressionResult
                                        .split('')
                                        .getRange(0, 1)
                                        .join('');

                                    editiText(
                                        '($dataOperator$data${gridItemData.buttonText}');
                                    return;
                                  }

                                  editiText(
                                      '$expressionResult${gridItemData.buttonText}');
                                  return;
                                }

                                // retunr when expression end s with brackte and operator is + ÷ % x
                                if (regExpMatchEndsWithOpenBracket
                                    .hasMatch(mathExpression)) {
                                  if (gridItemData.buttonText == '+' ||
                                      gridItemData.buttonText == 'x' ||
                                      gridItemData.buttonText == '÷' ||
                                      gridItemData.buttonText == '%') {
                                    return;
                                  }
                                  editiText(gridItemData.buttonText);
                                  return;
                                }
                                editiText(gridItemData.buttonText);
                              }

                              if (gridItemData.buttonText == '+/-') {
                                if (isClicked) {
                                  resetAnimation();
                                  var data = expressionResult;
                                  mathExpressionController.clear();
                                  // check if data ends with operator

                                  if (regExpMatchBeginsWithOperator
                                      .hasMatch(data)) {
                                    // clears the operator and return value
                                    var newData = data.replaceAll('-', '');
                                    editiText(newData);
                                  } else {
                                    editiText('(-$data');
                                  }
                                }
                                // return mathexpression is empty
                                if (mathExpression.isEmpty) {
                                  editiText('(-');
                                  return;
                                }

                                // return ends with closed baracket
                                if (regExpMatchEndWithClosedBracket
                                    .hasMatch(mathExpression)) {
                                  editiText('x(-');
                                  return;
                                }
                              }

                              // returns when input is 0-9
                              if (integerNumbers
                                  .contains(gridItemData.buttonText)) {
                                // returns when animation has been ran
                                if (isClicked) {
                                  resetAnimation();
                                  mathExpressionController.clear();
                                  editiText(gridItemData.buttonText);
                                  return;
                                }
                                // returns when expression length is greater than 15
                                if (mathExpression.validateExpressionLength()) {
                                  showToast(digitGreaterThanNormal);

                                  return;
                                }

                                editiText(gridItemData.buttonText);
                              }

                              // returns when button text is = and expression is valid
                              if (gridItemData.buttonText == '=') {
                                if (mathExpression.isValidExpression()) {
                                  isClicked = true;
                                  _animationController.forward();
                                  _colorAnimationController.forward();
                                }
                                // returns if expression ends with operator
                                if (regExpMatchEndWithOperator
                                    .hasMatch(mathExpression)) {
                                  showToast(invalidFormat);
                                  return;
                                }
                              }

                              // returns when is button text is C
                              if (gridItemData.buttonText == 'C') {
                                resetAnimation();
                                mathExpressionController.clear();
                              }

                              // retuns when button is .
                              if (gridItemData.buttonText == '.') {
                                editiText(gridItemData.buttonText);
                                return;
                              }

                              // returns if button text is ( )
                              if (gridItemData.buttonText == '( )') {
                                // returns if expression is empty
                                if (mathExpression.isEmpty) {
                                  editiText('(');
                                  return;
                                }
                                // returns when equal button is been pressed
                                if (isClicked) {
                                  resetAnimation();
                                  var data = expressionResult;
                                  mathExpressionController.clear();
                                  editiText('${data}x(');
                                }
                                // returns when expression ends with operator
                                // then number
                                if (!mathExpression
                                    .validateLastTwoExpression()) {
                                  editiText(')');
                                }

                                if (regExpMatchEndsWithOperatorThenNumber
                                    .hasMatch(mathExpression.format())) {
                                  editiText(')');
                                  return;
                                }

                                // returns when expression ends with operator
                                if (regExpMatchEndWithOperator
                                    .hasMatch(mathExpression)) {
                                  editiText('(');
                                  return;
                                }

                                // returns when expression ends with closed bracket
                                if (regExpMatchEndWithClosedBracket
                                    .hasMatch(mathExpression)) {
                                  editiText('x(');

                                  return;
                                }

                                // returns when expression ends with closed bracket
                                if (regExpMatchEndWithNumber
                                    .hasMatch(mathExpression.format())) {
                                  editiText('x(');
                                  return;
                                }
                              }

                              setState(() {});
                            },
                            child: Text(
                              gridItemData.buttonText,
                              style: customFont(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: gridItemData.textColor),
                            ),
                          ),
                        );
                      },
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void calculate({required String text, required BuildContext context}) {
  context
      .read<CalculatorBloc>()
      .add(CalculatorEventSolveEquation(expression: text));
}

// replaces ending operator with new one
String replaceLastAlritimeticOperator(
    {required String expression, required String alritimeticOperator}) {
  var newExpression = expression.split('');
  var newExpression1 =
      newExpression.getRange(0, newExpression.length - 1).toList();

  var newData = [...newExpression1, alritimeticOperator];

  return newData.join('');
}

// TODO Fix for when result starts with - e.g -7
// TODO Fit TextField Issue with cusor
// TODO Fit Bracket issue
