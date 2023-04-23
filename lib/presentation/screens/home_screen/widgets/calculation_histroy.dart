import 'package:calculator/core/extensions.dart';
import 'package:calculator/logic/bloc/calculation_history_bloc/bloc/calculation_history_bloc.dart';
import 'package:calculator/presentation/common_widgets/custom_button.dart';
import 'package:calculator/presentation/common_widgets/custom_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/strings.dart';
import '../../../../data/models/calculation_history.dart';

class CalculationHistroy extends StatefulWidget {
  final TextEditingController textEditingController;
  const CalculationHistroy({Key? key, required this.textEditingController})
      : super(key: key);

  @override
  State<CalculationHistroy> createState() => _CalculationHistroyState();
}

class _CalculationHistroyState extends State<CalculationHistroy> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final screenHeight = MediaQuery.of(context).size.height;
      final scrollableHeight = _scrollController.position.maxScrollExtent;
      final targetScrollPosition = (scrollableHeight / 2) - (screenHeight / 2);
      _scrollController.jumpTo(targetScrollPosition);
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 600), curve: Curves.easeIn);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Scrollbar(
                interactive: true,
                radius: const Radius.circular(12),
                child: BlocBuilder<CalculationHistoryBloc,
                    CalculationHistoryState>(
                  builder: (context, state) {
                    final calculationHistory = state.calculationHistoryData;

                    return calculationHistory.length < 4
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                controller: _scrollController,
                                itemCount: calculationHistory.length,
                                itemBuilder: (context, index) {
                                  return historyTile(
                                      calculationHistory[index], context);
                                },
                              ),
                            ],
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            controller: _scrollController,
                            itemCount: calculationHistory.length,
                            itemBuilder: (context, index) {
                              return historyTile(
                                  calculationHistory[index], context);
                            },
                          );
                  },
                )),
          ),
        ),
        MaterialButton(
          onPressed: () {
            context
                .read<CalculationHistoryBloc>()
                .add(const CalculationHistoryEventClearHistory());
          },
          color: Colors.grey,
          minWidth: 200,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Text(
            clearHistory,
            style: customFont(color: Colors.white),
          ),
        )
      ],
    );
  }

  Widget historyTile(
      CalculationHistory calculationHistory, BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                editiText(calculationHistory.expression,
                    widget.textEditingController);
              },
              child: Container(
                alignment: Alignment.topRight,
                width: width,
                child: Text(
                  calculationHistory.expression,
                  style: customFont(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 5),
            InkWell(
              onTap: () {
                editiText(calculationHistory.expressionResult,
                    widget.textEditingController);
              },
              child: Container(
                width: width,
                alignment: Alignment.bottomRight,
                child: Text(
                  '=${calculationHistory.expressionResult.formatNum()}',
                  style: customFont(color: primaryColor),
                ),
              ),
            ),
          ],
        ));
  }
}
