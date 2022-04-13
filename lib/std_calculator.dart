import 'package:basic_calc/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class StdCalculator extends StatefulWidget {
  const StdCalculator({Key? key}) : super(key: key);

  @override
  State<StdCalculator> createState() => _StdCalculatorState();
}

class _StdCalculatorState extends State<StdCalculator> {
  var strExpression = '';
  var strResult = '0';

  final List<String> buttons = [
    'C', 'DEL', '%', '÷', //first line
    '7', '8', '9', '×', //2nd line
    '4', '5', '6', '-', //3rd line
    '1', '2', '3', '+', //4th line
    '00', '0', '.', '=', //5th line
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      //drawer: const Drawer(),
      appBar: AppBar(
        title: const Text('Basic Calculator'),
        titleTextStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            letterSpacing: 1,
            fontSize: 18),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    strExpression,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(color: Colors.grey),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      strResult,
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          ?.copyWith(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
              ),
              padding: const EdgeInsets.all(20),
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index) {
                  //* delete Button
                  if (index == 1) {
                    return Buttons(
                      onTap: () {
                        setState(() {
                          strExpression = strExpression.substring(
                              0, strExpression.length - 1);
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.red.shade400,
                      textColor: Colors.grey.shade900,
                    );

                    //* clear button
                  } else if (index == 0) {
                    return Buttons(
                      onTap: () {
                        setState(() {
                          strExpression = '';
                          strResult = '0';
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.red.shade400,
                      textColor: Colors.grey.shade900,
                    );

                    //* equals button
                  } else if (index == buttons.length - 1) {
                    return Buttons(
                      onTap: () {
                        setState(() {
                          equalPressed();
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.green.shade400,
                      textColor: Colors.grey.shade900,
                    );

                    //* rest of buttons
                  } else {
                    return Buttons(
                      onTap: () {
                        setState(() {
                          strExpression += buttons[index];
                        });
                      },
                      buttonText: buttons[index],
                      color: isOperator(buttons[index])
                          ? Colors.grey.shade600
                          : Colors.grey.shade100,
                      textColor: isOperator(buttons[index])
                          ? Colors.white
                          : Colors.grey.shade900,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' ||
        x == '÷' ||
        x == '÷' ||
        x == '×' ||
        x == '+' ||
        x == '-' ||
        x == 'ANS') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQuestion = strExpression;
    finalQuestion = finalQuestion.replaceAll('×', '*');
    finalQuestion = finalQuestion.replaceAll('÷', '/');

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    strResult = eval.toString().trim();
  }
}
