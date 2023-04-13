import 'package:calculator/core/extensions.dart';
import 'package:calculator/data/models/buttondata.dart';
import 'package:calculator/logic/bloc/calculator_bloc/bloc/calculator_bloc.dart';
import 'package:calculator/presentation/screens/home_screen/widgets/calculation_histroy.dart';
import 'package:calculator/presentation/screens/home_screen/widgets/custom_textcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/constants/strings.dart';
import '../../common_widgets/custom_button.dart';
import '../../common_widgets/custom_font.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController _positionAnimationController;
  late final AnimationController _colorAnimationController;
  late final AnimationController _visibilityAnimationController;
  late final Animation<AlignmentGeometry> _animationPosition;
  late final Animation<Color> _animationColor;
  late final Animation<double> _animationScale;
  late final Animation<double> _animationVisibility;
  late CustomTextEditingController mathExpressionController;
  final TextEditingController _mathResultController = TextEditingController();
  FocusNode mathResultFocusNode = FocusNode();
  final integerNumbers = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'];
  final alritimeticOperators = ['+', '-', '÷', 'x', '%'];
  bool isClicked = false;
  bool isHistroySelected = false;

  @override
  void initState() {
    super.initState();
    mathExpressionController = CustomTextEditingController();

    _positionAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    );

    _visibilityAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 100,
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
        parent: _positionAnimationController,
        curve: Curves.linear,
      ),
    );
    _animationColor =
        Tween<Color>(begin: Colors.grey, end: primaryColor).animate(
      CurvedAnimation(
        parent: _colorAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationVisibility = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _visibilityAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationScale = Tween<double>(begin: 1, end: 1.5).animate(
      CurvedAnimation(
        parent: _positionAnimationController,
        curve: Curves.linearToEaseOut,
      ),
    );
  }

  @override
  void dispose() {
    _positionAnimationController.dispose();
    _colorAnimationController.dispose();
    _visibilityAnimationController.dispose();
    mathExpressionController.dispose();
    super.dispose();
  }

  void resetAnimation() {
    isClicked = false;
    _positionAnimationController.reset();
    _colorAnimationController.reset();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final expressionResult = context.watch<CalculatorBloc>().state.result;
    final animationStatus =
        _positionAnimationController.status == AnimationStatus.completed;

    mathExpressionController.addListener(() {
      calculate(text: mathExpressionController.text, context: context);

      if (mathExpressionController.text.isEmpty) {
        setState(() {});
      }
    });
    _positionAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        mathResultFocusNode.requestFocus();
      }
      if (status == AnimationStatus.forward) {
        setState(() {});
      }
    });

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
                  Flexible(
                    flex: 5,
                    child: Container(
                      // color: Colors.grey.withOpacity(0.2),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AnimatedBuilder(
                            animation: _animationVisibility,
                            builder: (context, child) => Visibility(
                              visible: _visibilityAnimationController.value == 1
                                  ? false
                                  : true,
                              child: Expanded(
                                flex: 4,
                                child: Container(
                                  // color: Colors.amber,
                                  alignment: Alignment.topRight,
                                  padding:
                                      const EdgeInsets.only(right: 40, top: 40),
                                  child: TextField(
                                    textAlign: TextAlign.end,
                                    autofocus: true,
                                    scrollPhysics:
                                        const AlwaysScrollableScrollPhysics(),
                                    controller: mathExpressionController,
                                    keyboardType: TextInputType.none,
                                    cursorColor: Colors.greenAccent,
                                    maxLines: null,
                                    minLines: null,
                                    expands: true,
                                    magnifierConfiguration:
                                        TextMagnifierConfiguration.disabled,
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
                          ),
                          Flexible(
                            child: Container(
                              padding:
                                  const EdgeInsets.only(right: 40, top: 40),
                              width: width,
                              child: AlignTransition(
                                alignment: _animationPosition,
                                child: ScaleTransition(
                                  scale: _animationScale,
                                  alignment: Alignment.topRight,
                                  child: AnimatedBuilder(
                                      animation: _animationColor,
                                      builder: (context, child) {
                                        return BlocBuilder<CalculatorBloc,
                                            CalculatorState>(
                                          builder: (context, state) {
                                            _mathResultController.text =
                                                state.result.formatNum();
                                            return TextField(
                                              controller: _mathResultController,
                                              textAlign: TextAlign.end,
                                              enabled: isClicked,
                                              // focusNode: mathResultFocusNode,
                                              autofocus: true,
                                              keyboardType: TextInputType.none,
                                              cursorColor: Colors.greenAccent,
                                              cursorWidth: 0.8,

                                              magnifierConfiguration:
                                                  TextMagnifierConfiguration
                                                      .disabled,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .allow(
                                                  RegExp("[0-9]"),
                                                ),
                                              ],
                                              style: customFont(
                                                  color: _animationColor.value,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            );
                                          },
                                        );
                                      }),
                                ),
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
                            onPressed: () {
                              isHistroySelected = !isHistroySelected;
                              setState(() {});
                            },
                            icon: Icon(
                              isHistroySelected
                                  ? FontAwesomeIcons.calculator
                                  : FontAwesomeIcons.clock,
                              color: Colors.grey,
                              size: 20,
                            )),
                        const SizedBox(width: 10),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              FontAwesomeIcons.rulerHorizontal,
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
                                  editiText(
                                      expression, mathExpressionController);
                                }
                                deleteText(mathExpressionController);
                              },
                              icon: Icon(
                                FeatherIcons.delete,
                                color: mathExpressionController.text.isEmpty
                                    ? primaryColor.withOpacity(0.5)
                                    : primaryColor,
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
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            ),
            Expanded(
              child: SizedBox(
                  width: width,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 3,
                        child: Container(
                          child: isHistroySelected
                              ? Container(
                                  alignment: Alignment.topRight,
                                  decoration: const BoxDecoration(
                                    border: Border(
                                        right: BorderSide(
                                            color: Colors.grey, width: 0.2)),
                                  ),
                                  child: CalculationHistroy(
                                    textEditingController:
                                        mathExpressionController,
                                  ))
                              : GridView.count(
                                  childAspectRatio: 1.25,
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 10,
                                  padding: const EdgeInsets.only(
                                    top: 5,
                                    left: 5,
                                    bottom: 5,
                                  ),
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: List.generate(
                                    buttonNumbersGrid.length,
                                    (index) {
                                      final gridItemData =
                                          buttonNumbersGrid[index];
                                      return CustomButton(
                                        textEditingController:
                                            mathExpressionController,
                                        buttonData: gridItemData,
                                        visibilityAnimationController:
                                            _visibilityAnimationController,
                                        positionAnimationController:
                                            _positionAnimationController,
                                        colorAnimationController:
                                            _colorAnimationController,
                                      );
                                    },
                                  )),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          child: GridView.count(
                              childAspectRatio: 1.16,
                              crossAxisCount: 1,
                              mainAxisSpacing: 10,
                              padding: const EdgeInsets.all(5),
                              physics: const NeverScrollableScrollPhysics(),
                              children: List.generate(
                                buttonOperatorsGrid.length,
                                (index) {
                                  final gridItemData =
                                      buttonOperatorsGrid[index];
                                  return CustomButton(
                                    textEditingController:
                                        mathExpressionController,
                                    buttonData: gridItemData,
                                    positionAnimationController:
                                        _positionAnimationController,
                                    visibilityAnimationController:
                                        _visibilityAnimationController,
                                    colorAnimationController:
                                        _colorAnimationController,
                                  );
                                },
                              )),
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

void deleteText(CustomTextEditingController controller) {
  var oldValue = controller.value;
  int cursorPosition = oldValue.selection.start;
  String newValueText = oldValue.text.substring(0, cursorPosition - 1) +
      oldValue.text.substring(
        cursorPosition,
      );
  var newValue = TextEditingValue(
    text: newValueText,
    selection: TextSelection.collapsed(offset: cursorPosition - 1),
  );

  var textData = newValue.text.formatToHundreads();
  var newValue1 = newValue.copyWith(
      text: textData,
      selection: TextSelection.collapsed(
        offset: textData.length,
      ));
  controller.value = newValue1;
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
