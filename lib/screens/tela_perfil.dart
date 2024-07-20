import 'package:flutter/material.dart';
import 'package:flutter_avaliacao/Banco_de_dados/banco_de_dados.dart';
import 'package:flutter_avaliacao/screens/calculadora.dart';
import 'package:flutter_avaliacao/screens/IMC.dart';

class TelaPerfil extends StatefulWidget {
  final String email;

  const TelaPerfil({super.key, required this.email});

  @override
  TelaUsuario createState() => TelaUsuario();
}

class TelaUsuario extends State<TelaPerfil> {
  final databaseHelper = DatabaseHelper();
  String? nomeUsuario;
  int? idadeUsuario;
  String? sexoUsuario;
  Color? corFundo;
  String mensagem = '';
  bool _showCalculadora = false;
  bool _showIMC = false;

  @override
  void initState() {
    super.initState();
    VerUsuario();
  }

  void VerUsuario() async {
    final user = await databaseHelper.getUser(widget.email);
    setState(() {
      nomeUsuario = user?['nome'];
      idadeUsuario = user?['idade'];
      sexoUsuario = user?['sexo'];

      if (idadeUsuario != null) {
        if (idadeUsuario! <= 15) {
          mensagem =
              'Olá, $nomeUsuario, você tem $idadeUsuario anos, ainda é uma criança';
          if (sexoUsuario == 'Homem') {
            corFundo = Colors.blue.shade100;
          } else if (sexoUsuario == 'Mulher') {
            corFundo = Colors.pink.shade100;
          }
        } else if (idadeUsuario! > 15 && idadeUsuario! <= 24) {
          mensagem =
              'Olá, $nomeUsuario, você tem $idadeUsuario anos, é um jovem';
          if (sexoUsuario == 'Homem') {
            corFundo = Colors.blue.shade200;
          } else if (sexoUsuario == 'Mulher') {
            corFundo = Colors.pink.shade200;
          }
        } else if (idadeUsuario! > 24 && idadeUsuario! <= 64) {
          mensagem =
              'Olá, $nomeUsuario, você tem $idadeUsuario anos, é um adulto';
          if (sexoUsuario == 'Homem') {
            corFundo = Colors.blue.shade300;
          } else if (sexoUsuario == 'Mulher') {
            corFundo = Colors.pink.shade300;
          }
        } else if (idadeUsuario! >= 65) {
          mensagem =
              'Olá, $nomeUsuario, você tem $idadeUsuario anos, é um idoso';
          if (sexoUsuario == 'Homem') {
            corFundo = Colors.blue.shade400;
          } else if (sexoUsuario == 'Mulher') {
            corFundo = Colors.pink.shade400;
          }
        }
      }
    });
  }

  void logout(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void _toggleCalculadora() {
    setState(() {
      _showCalculadora = !_showCalculadora;
    });
  }

  void _toggleIMC() {
    setState(() {
      _showIMC = !_showIMC;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem-vindo, $nomeUsuario'),
        backgroundColor: const Color.fromRGBO(169, 209, 231, 8),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => logout(context),
          ),
        ],
      ),
      body: Container(
        color: corFundo,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              mensagem,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _toggleIMC,
                  child: Text(_showIMC ? 'Ocultar IMC' : 'Mostrar IMC'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _toggleCalculadora,
                  child: Text(_showCalculadora ? 'Ocultar Calculadora' : 'Mostrar Calculadora'),
                ),
              ],
            ),
            SizedBox(height: 20),
            if (_showIMC) ...[
              IMC(),
            ],
            if (_showCalculadora) ...[
              Calculadora(),
            ],
          ],
        ),
      ),
    );
  }
}