import 'package:flutter/material.dart';

class InvestimentosScreen extends StatefulWidget {
  final String month;
  final String year;

  const InvestimentosScreen({super.key, required this.month, required this.year});  // Adicionando `const` e `key`

  @override
  _InvestimentosScreenState createState() => _InvestimentosScreenState();
}

class _InvestimentosScreenState extends State<InvestimentosScreen> {
  final List<Map<String, dynamic>> investimentos = [];
  double totalInvestido = 0.0;

  void _addInvestimento() {
    setState(() {
      investimentos.add({
        'descricao': 'Novo Investimento',
        'valor': 0.0,
        'data': DateTime.now(),
        'isChecked': false
      });
    });
  }

  void _removeInvestimento(int index) {
    setState(() {
      investimentos.removeAt(index);
    });
  }

  void _toggleCheckbox(int index, bool? value) {
    setState(() {
      investimentos[index]['isChecked'] = value!;
      totalInvestido = investimentos
          .where((investimento) => investimento['isChecked'])
          .fold(0.0, (sum, investimento) => sum + investimento['valor']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Investimentos - ${widget.month}/${widget.year}')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _addInvestimento,
            child: Text('Adicionar Investimento'),
          ),
          Text('Total Investido: R\$ $totalInvestido'),
          Expanded(
            child: ListView.builder(
              itemCount: investimentos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Investimento ${index + 1}'),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Descrição: ${investimentos[index]['descricao']}'),
                      Text('Valor: R\$ ${investimentos[index]['valor']}'),
                      Text('Data: ${investimentos[index]['data']}'),
                      Checkbox(
                        value: investimentos[index]['isChecked'],
                        onChanged: (value) =>
                            _toggleCheckbox(index, value),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _removeInvestimento(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
