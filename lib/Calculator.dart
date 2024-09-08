// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String userInput = '0';

  String result = '0';

  List buttonText = [
    '(',
    ')',
    'C',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    'AC',
    '0',
    '.',
    '='
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calculator",style: TextStyle(fontSize: 32,color: Colors.white),),backgroundColor: Colors.blue,elevation: 10,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          calculatorScreen(),
         
          // const SizedBox(
          //   height: 50,
          // ),
          buttonsContainer(),
        ],
      ),
    );
  }

  Widget calculatorScreen() {
    return Container(
      width: Get.width,
      height: Get.height/5,
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
          border: Border.all(width: 5, color: Colors.black54),
          borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, right: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    userInput,
                    style: const TextStyle(fontSize: 32,),
                  ),
                ),
              ),
            ),
            const Divider(
              height: 2,
              thickness: 2,
              color: Colors.black12,
            ),
            Padding(
              padding: const EdgeInsets.only( right: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    result,
                    style: const TextStyle(fontSize: 32),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonsContainer() {
    return SizedBox(
      width: Get.width,
      height: Get.height * 0.63,
      child: GridView.builder(
          itemCount: buttonText.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.2),
          itemBuilder: (context, index) {
            return SafeArea(
              child: GestureDetector(
                onTap: () => setState(() {
                  handlerButton(buttonText[index]);
                }),
                child: Container(
                  margin: const EdgeInsets.all(1.5),
                  alignment: const Alignment(0, 0),
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      color: colorText(buttonText[index]),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    buttonText[index],
                    style: const TextStyle(fontSize: 28, color: Colors.black),
                  ),
                ),
              ),
            );
          }),
    );
  }

  colorText(String text) {
    if (text == '(' ||
        text == ')' ||
        text == '/' ||
        text == '*' ||
        text == '+' ||
        text == '-' ||
        text == '=' ||
        text == '.') {
      return Colors.grey;
    } else if (text == 'C' || text == 'AC') {
      return Colors.lightBlue;
    } else {
      return Colors.black12;
    }
  }

  handlerButton(String text) {
    if (text == 'C') {
      userInput = userInput.substring(0, userInput.length - 1);
      return;
    }
    if (text == 'AC') {
      userInput = '';
      result = '0';
      return;
    }
    if (text == '=') {
      result = calculate();
      if (result.endsWith('.0')) {
        result = result.replaceAll('.0', "");
      }
      return;
    }
    userInput = userInput + text;
  }

  String calculate() {
    try {
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      return 'Error';
    }
  }
}
