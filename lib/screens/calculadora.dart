import 'package:flutter/material.dart';


class Calculadora extends StatefulWidget {
  @override
  Calcular createState() => Calcular();
}

class Calcular extends State<Calculadora> {
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  String result = '';
  String error = '';

  void calculate(String operation) {
    setState(() {
      error = '';
      result = '';

      final String input1 = controller1.text;
      final String input2 = controller2.text;

      if (input1.isEmpty || input2.isEmpty) {
        error = 'Campos não podem estar vazios.';
        return;
      }

      final double num1 = double.tryParse(input1) ?? 0;
      final double num2 = double.tryParse(input2) ?? 0;

      switch (operation) {
        case 'Soma':
          result = (num1 + num2).toString();
          break;
        case 'Subtração':
          result = (num1 - num2).toString();
          break;
        case 'Multiplicação':
          result = (num1 * num2).toString();
          break;
        case 'Divisão':
          if (num2 == 0) {
            error = 'Não é possível dividir por zero.';
          } else {
            result = (num1 / num2).toString();
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: controller1,
            decoration: InputDecoration(labelText: 'Número 1'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: controller2,
            decoration: InputDecoration(labelText: 'Número 2'),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => calculate('Soma'),
            child: Text('Soma'),
          ),
          ElevatedButton(
            onPressed: () => calculate('Subtração'),
            child: Text('Subtração'),
          ),
          ElevatedButton(
            onPressed: () => calculate('Multiplicação'),
            child: Text('Multiplicação'),
          ),
          ElevatedButton(
            onPressed: () => calculate('Divisão'),
            child: Text('Divisão'),
          ),
          SizedBox(height: 20),
          if (error.isNotEmpty)
            Text(
              error,
              style: TextStyle(color: Colors.red),
            ),
          if (result.isNotEmpty)
            Text(
              'Resultado: $result',
              style: TextStyle(fontSize: 24),
            ),
        ],
      ),
    );
  }
}