import 'package:flutter/material.dart';

class IMC extends StatefulWidget {
  @override
  IMCCalculadora createState() => IMCCalculadora();
}

class IMCCalculadora extends State<IMC> {
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController alturaController = TextEditingController();
  String resultado = '';
  String erro = '';

  void calcularIMC() {
    setState(() {
      erro = '';
      resultado = '';

      final String pesoTexto = pesoController.text;
      final String alturaTexto = alturaController.text;

      if (pesoTexto.isEmpty || alturaTexto.isEmpty) {
        erro = 'Campos não podem estar vazios.';
        return;
      }

      final double peso = double.tryParse(pesoTexto) ?? 0;
      final double altura = double.tryParse(alturaTexto) ?? 0;

      if (altura == 0) {
        erro = 'Altura não pode ser zero.';
        return;
      }

      final double imc = peso / (altura * altura);
      String faixaIMC;

      if (imc < 18.5) {
        faixaIMC = 'Abaixo do peso';
      } else if (imc >= 18.5 && imc < 24.9) {
        faixaIMC = 'Peso normal';
      } else if (imc >= 25 && imc < 29.9) {
        faixaIMC = 'Sobrepeso';
      } else {
        faixaIMC = 'Obesidade';
      }

      resultado = 'IMC: ${imc.toStringAsFixed(2)} - $faixaIMC';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: pesoController,
            decoration: InputDecoration(labelText: 'Peso (kg)'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: alturaController,
            decoration: InputDecoration(labelText: 'Altura (m)'),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: calcularIMC,
            child: Text('Calcular IMC'),
          ),
          SizedBox(height: 20),
          if (erro.isNotEmpty)
            Text(
              erro,
              style: TextStyle(color: Colors.red),
            ),
          if (resultado.isNotEmpty)
            Text(
              resultado,
              style: TextStyle(fontSize: 24),
            ),
        ],
      ),
    );
  }
}