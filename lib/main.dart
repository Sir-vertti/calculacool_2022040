import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart' as math;

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CalculatorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = '';
  double _result = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDisplay(),
            _buildCalculatorButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildDisplay() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        _input,
        style: const TextStyle(fontSize: 24.0),
      ),
    );
  }

  Widget _buildCalculatorButtons() {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      itemCount: 20,
      itemBuilder: (context, index) {
        return ElevatedButton(
          onPressed: () {
            _onButtonPressed(index);
          },
          child: Text(
            _buttonText(index),
            style: const TextStyle(fontSize: 20.0),
          ),
        );
      },
    );
  }

  String _buttonText(int index) {
    if (index < 10) {
      return '$index';
    } else if (index == 10) {
      return '+';
    } else if (index == 11) {
      return '-';
    } else if (index == 12) {
      return '*';
    } else if (index == 13) {
      return '/';
    } else if (index == 14) {
      return 'C';
    } else if (index == 15) {
      return '.';
    } else if (index == 16) {
      return '+/-';
    } else if (index == 17) {
      return '=';
    } else {
      return 'Error';
    }
  }

  void _onButtonPressed(int index) {
    setState(() {
      if (index < 10) {
        _input += '$index';
      } else if (index == 10) {
        _input += '+';
      } else if (index == 11) {
        _input += '-';
      } else if (index == 12) {
        _input += '*';
      } else if (index == 13) {
        _input += '/';
      } else if (index == 14) {
        _input = '';
      } else if (index == 15) {
        if (!_input.contains('.')) {
          _input += '.';
        }
      } else if (index == 16) {
        if (_input != '' && !_input.startsWith('-')) {
          _input = '-$_input';
        }
      } else if (index == 17) {
        _calculateResult();
      }
    });
  }

  void _calculateResult() {
    try {
      math.Parser p = math.Parser();
      math.Expression exp = p.parse(_input);
      math.ContextModel cm = math.ContextModel();
      _result = exp.evaluate(math.EvaluationType.REAL, cm);
      _input = _result.toString();
    } catch (e) {
      _input = 'Error';
    }
  }
}
