import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (buttonText == "⌫") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: const BorderSide(
                width: 1, color: Colors.white, style: BorderStyle.solid),
          ),
        ),
        onPressed: () => buttonPressed(buttonText),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            buttonText,
            style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: TextStyle(
                  fontSize: resultFontSize,
                  color: Color.fromARGB(255, 255, 94, 0)),
            ),
          ),
          const Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Container(
                  child: Table(
                    children: [
                      TableRow(children: [
                        buildButton("C", 1, Colors.redAccent),
                        buildButton("⌫", 1, Colors.orange),
                        buildButton("÷", 1, Colors.orange),
                      ]),
                      TableRow(children: [
                        buildButton("7", 1, Colors.black45),
                        buildButton("8", 1, Colors.black45),
                        buildButton("9", 1, Colors.black45),
                      ]),
                      TableRow(children: [
                        buildButton("4", 1, Colors.black45),
                        buildButton("5", 1, Colors.black45),
                        buildButton("6", 1, Colors.black45),
                      ]),
                      TableRow(children: [
                        buildButton("1", 1, Colors.black45),
                        buildButton("2", 1, Colors.black45),
                        buildButton("3", 1, Colors.black45),
                      ]),
                      TableRow(children: [
                        buildButton(".", 1, Colors.black45),
                        buildButton("0", 1, Colors.black45),
                        buildButton("00", 1, Colors.black45),
                      ]),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("×", 1, Colors.orange),
                    ]),
                    TableRow(children: [
                      buildButton("-", 1, Colors.orange),
                    ]),
                    TableRow(children: [
                      buildButton("+", 1, Colors.orange),
                    ]),
                    TableRow(children: [
                      buildButton("=", 2, Colors.redAccent),
                    ]),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
