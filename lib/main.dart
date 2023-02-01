import 'package:flutter/material.dart';
import 'package:flutter_calculator/screen/calculator.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      home: SimpleCalculator(),
    );
  }
}
