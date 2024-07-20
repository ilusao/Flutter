import 'package:flutter/material.dart';
import 'package:flutter_avaliacao/screens/tela_cadastro.dart';
import 'package:flutter_avaliacao/screens/tela_login.dart';

void main() {
  runApp(const MeuApp());
}

  class MeuApp extends StatelessWidget {
    const MeuApp({super.key});

      @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Avaliação',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MinhaPagina(),
      );


    }
  }

  class MinhaPagina extends StatelessWidget {
  const MinhaPagina({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('André bernardes dos santos'),
        backgroundColor: const Color.fromRGBO(169, 209, 231, 8),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             const Text(
              'Bem-vindo, aproveite o aplicativo',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
             const SizedBox(height:   50),
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TelaCadastro()),
                );
              },
              child: const Text('Cadastrar'),
            ),
             const SizedBox(width:  50),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TelaLogin()),
                );
              },
              child: const Text('Efetuar login'),
            ),
          ]
          ),
          ],
        ),
      ),
    );
  }
}


