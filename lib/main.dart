import 'package:flutter/material.dart';
import 'screens/receitas_screen.dart';
import 'screens/despesas_screen.dart';
import 'screens/investimentos_screen.dart';
import 'screens/analise_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedMonth = 'Janeiro';  // Variável para o mês selecionado
  String selectedYear = '2024';     // Variável para o ano selecionado
  int _selectedIndex = 0;           // Controla o índice da página selecionada

  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      ReceitasScreen(month: selectedMonth, year: selectedYear),
      DespesasScreen(month: selectedMonth, year: selectedYear),
      InvestimentosScreen(month: selectedMonth, year: selectedYear),
      AnaliseScreen(month: selectedMonth, year: selectedYear),
    ];
  }

  // Função chamada quando um item do BottomNavigationBar é selecionado
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Função para atualizar o mês e o ano
  void _updateMonthYear(String month, String year) {
    setState(() {
      selectedMonth = month;
      selectedYear = year;

      // Atualiza as telas com os novos valores de mês e ano
      _screens[0] = ReceitasScreen(month: selectedMonth, year: selectedYear);
      _screens[1] = DespesasScreen(month: selectedMonth, year: selectedYear);
      _screens[2] = InvestimentosScreen(month: selectedMonth, year: selectedYear);
      _screens[3] = AnaliseScreen(month: selectedMonth, year: selectedYear);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Controle Financeiro"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Dropdown para selecionar o mês
                DropdownButton<String>(
                  value: selectedMonth,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      _updateMonthYear(newValue, selectedYear);  // Chama a função para atualizar o mês e ano
                    }
                  },
                  items: <String>['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>( // Criando os itens do dropdown
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(width: 10),
                // Dropdown para selecionar o ano
                DropdownButton<String>(
                  value: selectedYear,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      _updateMonthYear(selectedMonth, newValue);  // Chama a função para atualizar o mês e ano
                    }
                  },
                  items: <String>['2024', '2025', '2026', '2027']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>( // Criando os itens do dropdown
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
      body: _screens[_selectedIndex],  // Exibe a tela com base no índice selecionado
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.black,   // Cor dos ícones e textos selecionados
        unselectedItemColor: Colors.black, // Cor dos ícones e textos não selecionados
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Receitas'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Despesas'),
          BottomNavigationBarItem(icon: Icon(Icons.trending_up), label: 'Investimentos'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Análise'),
        ],
      ),
    );
  }
}
