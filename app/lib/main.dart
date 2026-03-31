import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String display = "0";
  String expression = "";
  double num1 = 0;
  double num2 = 0;
  String operation = "";

  String formatNumber(double value) {
    if (value.isNaN) return "Error";
    if (value == value.roundToDouble()) {
      return value.toInt().toString();
    }
    return value.toString();
  }

  String formatStringNumber(String text) {
   
    if (text.endsWith('.0')) {
      return text.substring(0, text.length - 2);
    }
    return text;
  }

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "c") {
        display = "0";
        expression = "";
        num1 = 0;
        num2 = 0;
        operation = "";
      } else if (buttonText == "<-") {
        if (display != "0") {
          display = display.length > 1 ? display.substring(0, display.length - 1) : "0";
          if (operation.isNotEmpty) {
            expression = num1.toString() + operation + (display == "0" ? "" : display);
          } else {
            expression = display;
          }
        }
      } else if (buttonText == "+" || buttonText == "-" || buttonText == "x" || buttonText == "/") {
        num1 = double.parse(display);
        operation = buttonText;
        expression = formatStringNumber(display) + buttonText;
        display = "0";
      } else if (buttonText == "=") {
        num2 = double.parse(display);
        double result;
        switch (operation) {
          case "+":
            result = num1 + num2;
            break;
          case "-":
            result = num1 - num2;
            break;
          case "x":
            result = num1 * num2;
            break;
          case "/":
            result = num2 != 0 ? num1 / num2 : double.nan;
            break;
          default:
            result = double.parse(display);
        }
        expression = expression + display + "=";
        display = result.isNaN ? "Error" : formatNumber(result);
        operation = "";
      } else {
        // number or .
        if (buttonText == ".") {
          if (!display.contains(".")) display += ".";
        } else {
          if (display == "0") display = buttonText;
          else display += buttonText;
        }
        if (operation.isNotEmpty) {
          expression = formatStringNumber(num1.toString()) + operation + formatStringNumber(display);
        } else {
          expression = formatStringNumber(display);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 11, 44, 154),
          title: Center(
            child: Text("Calculator", style: TextStyle(color: Colors.white)),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(expression, style: TextStyle(fontSize: 24, color: Colors.grey)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(display, style: TextStyle(fontSize: 72)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    backgroundColor: Colors.white,
                    foregroundColor: const Color.fromARGB(255, 220, 32, 32),
                    elevation: 2,
                  ),
                  onPressed: () => buttonPressed("c"),
                  child: Text("c", style: TextStyle(fontSize: 32)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    backgroundColor: Colors.white,
                    foregroundColor: const Color.fromARGB(255, 220, 32, 32),
                    elevation: 2,
                  ),
                  onPressed: () => buttonPressed("<-"),
                  child: Text("<-", style: TextStyle(fontSize: 32)),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    backgroundColor: Colors.grey.shade200,
                    foregroundColor: Colors.blue,
                    elevation: 2,
                  ),
                  onPressed: () => buttonPressed("7"),
                  child: Text("7", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    backgroundColor: Colors.grey.shade200,
                    foregroundColor: Colors.blue,
                    elevation: 2,
                  ),
                  onPressed: () => buttonPressed("8"),
                  child: Text("8", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    backgroundColor: Colors.grey.shade200,
                    foregroundColor: Colors.blue,
                    elevation: 2,
                  ),
                  onPressed: () => buttonPressed("9"),
                  child: Text("9", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    backgroundColor: Colors.orange.shade100,
                    foregroundColor: const Color.fromARGB(255, 220, 32, 32),
                    elevation: 2,
                  ),
                  onPressed: () => buttonPressed("/"),
                  child: Text("/", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    backgroundColor: Colors.grey.shade200,
                    foregroundColor: Colors.blue,
                    elevation: 2,
                  ),
                  onPressed: () => buttonPressed("4"),
                  child: Text("4", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    backgroundColor: Colors.grey.shade200,
                    foregroundColor: Colors.blue,
                    elevation: 2,
                  ),
                  onPressed: () => buttonPressed("5"),
                  child: Text("5", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    backgroundColor: Colors.grey.shade200,
                    foregroundColor: Colors.blue,
                    elevation: 2,
                  ),
                  onPressed: () => buttonPressed("6"),
                  child: Text("6", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    backgroundColor: Colors.orange.shade100,
                    foregroundColor: const Color.fromARGB(255, 220, 32, 32),
                    elevation: 2,
                  ),
                  onPressed: () => buttonPressed("x"),
                  child: Text("x", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    backgroundColor: Colors.grey.shade200,
                    foregroundColor: Colors.blue,
                    elevation: 2,
                  ),
                  onPressed: () => buttonPressed("1"),
                  child: Text("1", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    backgroundColor: Colors.grey.shade200,
                    foregroundColor: Colors.blue,
                    elevation: 2,
                  ),
                  onPressed: () => buttonPressed("2"),
                  child: Text("2", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    backgroundColor: Colors.grey.shade200,
                    foregroundColor: Colors.blue,
                    elevation: 2,
                  ),
                  onPressed: () => buttonPressed("3"),
                  child: Text("3", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    backgroundColor: Colors.orange.shade100,
                    foregroundColor: const Color.fromARGB(255, 220, 32, 32),
                    elevation: 2,
                  ),
                  onPressed: () => buttonPressed("-"),
                  child: Text("-", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    backgroundColor: Colors.grey.shade200,
                    foregroundColor: Colors.blue,
                    elevation: 2,
                  ),
                  onPressed: () => buttonPressed("0"),
                  child: Text("0", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    backgroundColor: Colors.grey.shade200,
                    foregroundColor: Colors.blue,
                    elevation: 2,
                  ),
                  onPressed: () => buttonPressed("."),
                  child: Text(".", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    elevation: 2,
                  ),
                  onPressed: () => buttonPressed("="),
                  child: Text("=", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    backgroundColor: Colors.orange.shade100,
                    foregroundColor: const Color.fromARGB(255, 220, 32, 32),
                    elevation: 2,
                  ),
                  onPressed: () => buttonPressed("+"),
                  child: Text("+", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
