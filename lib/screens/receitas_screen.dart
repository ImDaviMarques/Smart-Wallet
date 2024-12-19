import 'package:flutter/material.dart';
import 'package:intl/intl.dart';  // Importar a biblioteca intl

class ReceitasScreen extends StatefulWidget {
  final String month;
  final String year;

  const ReceitasScreen({required this.month, required this.year});

  @override
  _ReceitasScreenState createState() => _ReceitasScreenState();
}

class _ReceitasScreenState extends State<ReceitasScreen> {
  List<Map<String, dynamic>> receitas = [];

  // Função para adicionar uma nova receita
  void _addReceita(String descricao, double valor, DateTime data) {
    setState(() {
      receitas.add({
        'descricao': descricao,
        'valor': valor,
        'data': data,
        'isChecked': false,
      });
    });
  }

  // Função para abrir o diálogo de adicionar receita
  void _openAddReceitaDialog() {
    String descricao = '';
    double valor = 0.0;
    DateTime data = DateTime.now();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Adicionar Receita'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Campo para descrição
              TextField(
                decoration: InputDecoration(labelText: 'Descrição'),
                onChanged: (value) {
                  descricao = value;
                },
              ),
              // Campo para valor
              TextField(
                decoration: InputDecoration(labelText: 'Valor'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  valor = double.tryParse(value) ?? 0.0;
                },
              ),
              // Campo de data com o DatePicker
              TextField(
                decoration: InputDecoration(labelText: 'Data'),
                controller: TextEditingController(text: DateFormat('d/M/y').format(data)), // Usando o formato 'd/M/y'
                onTap: () async {
                  final DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: data,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (selectedDate != null && selectedDate != data) {
                    setState(() {
                      data = selectedDate;
                    });
                  }
                },
                readOnly: true,  // Tornar o campo somente leitura, pois é controlado pelo DatePicker
              ),
            ],
          ),
          actions: [
            // Botão cancelar
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            // Botão salvar
            TextButton(
              onPressed: () {
                if (descricao.isNotEmpty && valor > 0.0) {
                  _addReceita(descricao, valor, data);
                  Navigator.of(context).pop();
                } else {
                  // Mostrar um erro se a descrição ou o valor forem inválidos
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Preencha todos os campos corretamente!')),
                  );
                }
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Receitas - ${widget.month} ${widget.year}')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Botão para adicionar nova receita
            ElevatedButton(
              onPressed: _openAddReceitaDialog,
              child: Text('Adicionar Receita'),
            ),
            Expanded(
              // Lista de receitas
              child: ListView.builder(
                itemCount: receitas.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      title: Text('${receitas[index]['descricao']}'),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Valor: R\$ ${receitas[index]['valor'].toStringAsFixed(2)}'),
                          // Exibindo a data formatada
                          Text('Data: ${DateFormat('d/M/y').format(receitas[index]['data'])}'),
                          Checkbox(
                            value: receitas[index]['isChecked'],
                            onChanged: (bool? value) {
                              setState(() {
                                receitas[index]['isChecked'] = value!;
                              });
                            },
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            receitas.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
