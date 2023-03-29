import 'package:calculator/core/extensions.dart';
import 'package:calculator/data/models/buttondata.dart';
import 'package:calculator/logic/bloc/calculator_bloc/bloc/calculator_bloc.dart';
import 'package:calculator/presentation/screens/home_screen/widgets/custom_textcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';

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
  late TextEditingController firstNumController;
  final secondNumController = TextEditingController();
  final alritimaticOperatorController = TextEditingController();
  bool equationIsValid = false;
  var regExpMatchEndsWithOperator = RegExp(r'([\+\-\*/\(\)])$');
  final integerNumbers = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'];
  final alritimeticOperators = ['+', '-', '÷', 'x', '%'];

  bool isClicked = false;

  @override
  void initState() {
    super.initState();
    firstNumController = CustomTextEditingController();
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
    final result = context.watch<CalculatorBloc>().state.result;

    firstNumController.addListener(() {
      calculate(text: firstNumController.text, context: context);
    });
    void editiText(String data) {
      var value = firstNumController.value;
      var newValue = TextEditingValue(
          text: value.text.replaceRange(
            value.selection.baseOffset,
            value.selection.extentOffset,
            data,
          ),
          selection: TextSelection.collapsed(
            offset: value.selection.baseOffset + data.length,
          ));
      var textData = newValue.text.formatToHundreads();
      var newValue1 = newValue.copyWith(
          text: textData,
          selection: TextSelection.collapsed(
            offset: textData.length,
          ));
      firstNumController.value = newValue1;
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
                    child: Container(
                      padding: const EdgeInsets.all(40),
                      child: TextField(
                        textAlign: TextAlign.end,
                        autofocus: true,
                        controller: firstNumController,
                        keyboardType: TextInputType.none,
                        cursorColor: Colors.greenAccent,
                        strutStyle: null,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp("[0-9]"),
                          ),
                        ],
                        style: GoogleFonts.nunito(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
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
                                        result.formatNum(),
                                        style: GoogleFonts.nunito(
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
                        AbsorbPointer(
                          absorbing: firstNumController.text.isEmpty,
                          child: IconButton(
                              onPressed: () {
                                if (isClicked) {
                                  resetAnimation();
                                  final newData = result.toString();
                                  firstNumController.clear();
                                  editiText(newData);
                                }
                                var oldValue = firstNumController.value;
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
                                firstNumController.value = newValue1;
                                setState(() {});
                              },
                              icon: Icon(
                                FeatherIcons.delete,
                                color: firstNumController.text.isEmpty
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
                      gridData.length,
                      (index) {
                        final data = gridData[index];
                        return Semantics(
                          button: true,
                          tooltip: data.buttonText,
                          enabled: true,
                          readOnly: true,
                          child: MaterialButton(
                            color: index == 19 ? Colors.green : Colors.white10,
                            onPressed: () {
                              HapticFeedback.mediumImpact();

                              /*Add '+' to the eqation and if '+' is already their dont add
                              If eqation has been calculated and user wants to add + again 
                              set the result to the new eqation and add '+' */

                              if (alritimeticOperators
                                  .contains(data.buttonText)) {
                                if (regExpMatchEndsWithOperator
                                    .hasMatch(firstNumController.text)) {
                                  return;
                                }

                                if (isClicked) {
                                  resetAnimation();

                                  firstNumController.clear();
                                  editiText('$result${data.buttonText}');
                                  return;
                                }

                                if (data.buttonText == '+/-') {
                                  // editiText('(-');
                                }

                                // replace operator
                                // if (firstNumController.text
                                //     .endsWithAlritimeticOperator()) {
                                //   var expression = firstNumController.text;
                                //   firstNumController.clear();
                                //   editiText(replaceLastAlritimeticOperator(
                                //       expression: expression,
                                //       alritimeticOperator: data.buttonText));
                                // }

                                editiText(data.buttonText);
                              }

                              if (integerNumbers.contains(data.buttonText)) {
                                if (isClicked) {
                                  resetAnimation();
                                  firstNumController.clear();
                                  editiText(data.buttonText);
                                  return;
                                }
                                editiText(data.buttonText);
                              }

                              if (data.buttonText == '=' &&
                                  firstNumController.text.isValidExpression()) {
                                isClicked = true;
                                _animationController.forward();
                                _colorAnimationController.forward();
                                // firstNumController.clear();
                              }

                              if (data.buttonText == 'C') {
                                resetAnimation();
                                firstNumController.clear();
                              }

                              if (data.buttonText == '.') {
                                editiText(data.buttonText);
                              }
                              setState(() {});
                            },
                            child: Text(
                              data.buttonText,
                              style: GoogleFonts.nunito(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: data.textColor),
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

  void calculate({required String text, required BuildContext context}) {
/*

Checks if equation contains + then split the eqation 
into two parts, then check if they re empty of not
then send the eqation to bloc if eqation isnt valid resetBloc
*/
    context
        .read<CalculatorBloc>()
        .add(CalculatorEventSolveEquation(expression: text));

    // if (text.contains('+')) {

    // } else {
    //   context.read<CalculatorBloc>().add(const CalculatorEventReset());
    //   resetAnimation();
    //   equationIsValid = false;
    // }
  }
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