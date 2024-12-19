import 'package:flutter/material.dart';

class AnaliseScreen extends StatelessWidget {
  final String month;
  final String year;

  const AnaliseScreen({super.key, required this.month, required this.year});  // Adicionando `const` e `key`

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Análise - $month/$year')),
      body: Center(
        child: Text(
          'Análise das movimentações do mês $month/$year',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
