import 'package:flutter/material.dart';

class DespesasScreen extends StatefulWidget {
  final String month;
  final String year;

  const DespesasScreen({super.key, required this.month, required this.year});  // Adicionando `const` e `key`

  @override
  _DespesasScreenState createState() => _DespesasScreenState();
}

class _DespesasScreenState extends State<DespesasScreen> {
  final List<Map<String, dynamic>> despesas = [];
  double totalPago = 0.0;
  double totalDespesas = 0.0;

  void _addDespesa() {
    setState(() {
      despesas.add({
        'descricao': 'Nova Despesa',
        'valor': 0.0,
        'data': DateTime.now(),
        'isChecked': false
      });
    });
  }

  void _removeDespesa(int index) {
    setState(() {
      despesas.removeAt(index);
    });
  }

  void _toggleCheckbox(int index, bool? value) {
    setState(() {
      despesas[index]['isChecked'] = value!;
      totalPago = despesas
          .where((despesa) => despesa['isChecked'])
          .fold(0.0, (sum, despesa) => sum + despesa['valor']);
      totalDespesas = despesas.fold(0.0, (sum, despesa) => sum + despesa['valor']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Despesas - ${widget.month}/${widget.year}')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _addDespesa,
            child: Text('Adicionar Despesa'),
          ),
          Text('Total Pago: R\$ $totalPago'),
          Text('Total Despesas: R\$ $totalDespesas'),
          Expanded(
            child: ListView.builder(
              itemCount: despesas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Despesa ${index + 1}'),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Descrição: ${despesas[index]['descricao']}'),
                      Text('Valor: R\$ ${despesas[index]['valor']}'),
                      Text('Data: ${despesas[index]['data']}'),
                      Checkbox(
                        value: despesas[index]['isChecked'],
                        onChanged: (value) =>
                            _toggleCheckbox(index, value),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _removeDespesa(index),
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
