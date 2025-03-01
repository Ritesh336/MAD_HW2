import 'package:flutter/material.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        appBarTheme: AppBarTheme(
          color: Colors.blueGrey[900], // Ensures AppBar background is a dark color
          titleTextStyle: TextStyle(
            color: Colors.white, // Ensures text is white
            fontSize: 20, // Adjust font size as needed
            fontWeight: FontWeight.bold, // Optional: add weight for better visibility
          ),
        ),
      ),
      home: Calculator(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String displayText = '0';
  String number = '';
  double firstNum = 0;
  double secondNum = 0;
  String? operation;  // Marked as nullable

  void btnOnClick(String btnVal) {
    if (btnVal == 'C') {
      displayText = '0';
      number = '';
      firstNum = 0;
      secondNum = 0;
      operation = null;
    } else if (btnVal == '+' || btnVal == '-' || btnVal == '*' || btnVal == '/') {
      firstNum = double.parse(number);
      operation = btnVal;
      number = '';
    } else if (btnVal == '=') {
      secondNum = double.parse(number);
      if (operation != null) {
        switch(operation) {
          case '+':
            displayText = (firstNum + secondNum).toString();
            break;
          case '-':
            displayText = (firstNum - secondNum).toString();
            break;
          case '*':
            displayText = (firstNum * secondNum).toString();
            break;
          case '/':
            displayText = secondNum != 0 ? (firstNum / secondNum).toString() : 'Divide by Zero';
            break;
          default:
            displayText = 'Invalid Operation';
        }
      }
      number = displayText;
    } else {
      number += btnVal;
      displayText = number;
    }

    setState(() {});
  }

  Widget calculatorButton(String btnVal, Color btnColor, Color textColor) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 4,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
          gradient: LinearGradient(
            colors: [btnColor.withOpacity(0.8), btnColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: TextButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            padding: EdgeInsets.all(24.0),
          ),
          onPressed: () => btnOnClick(btnVal),
          child: Text(
            btnVal,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
            child: Text(
              displayText,
              style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold, color: Colors.blueGrey[800]),
            ),
          ),
          Row(
            children: <Widget>[
              calculatorButton('7', Colors.grey[700]!, Colors.white),
              calculatorButton('8', Colors.grey[700]!, Colors.white),
              calculatorButton('9', Colors.grey[700]!, Colors.white),
              calculatorButton('/', Colors.blueGrey[600]!, Colors.white),
            ],
          ),
          Row(
            children: <Widget>[
              calculatorButton('4', Colors.grey[700]!, Colors.white),
              calculatorButton('5', Colors.grey[700]!, Colors.white),
              calculatorButton('6', Colors.grey[700]!, Colors.white),
              calculatorButton('*', Colors.blueGrey[600]!, Colors.white),
            ],
          ),
          Row(
            children: <Widget>[
              calculatorButton('1', Colors.grey[700]!, Colors.white),
              calculatorButton('2', Colors.grey[700]!, Colors.white),
              calculatorButton('3', Colors.grey[700]!, Colors.white),
              calculatorButton('-', Colors.blueGrey[600]!, Colors.white),
            ],
          ),
          Row(
            children: <Widget>[
              calculatorButton('0', Colors.grey[700]!, Colors.white),
              calculatorButton('C', Colors.red[700]!, Colors.white),
              calculatorButton('=', Colors.green[700]!, Colors.white),
              calculatorButton('+', Colors.blueGrey[600]!, Colors.white),
            ],
          )
        ],
      ),
    );
  }
}
