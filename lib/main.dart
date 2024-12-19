import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Wallet App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white, // Cor de fundo das telas
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue, // Cor do AppBar
        ),
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    ReceitasScreen(),
    DespesasScreen(),
    InvestimentosScreen(),
    AnaliseScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Wallet App'),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Receitas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.remove_circle_outline),
            label: 'Despesas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Investimentos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Análise',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue, // Cor do ícone e texto selecionado
        unselectedItemColor: Colors.grey, // Cor do ícone e texto não selecionado
      ),
    );
  }
}

// Tela de Receitas
class ReceitasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Tela de Receitas',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

// Tela de Despesas
class DespesasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Tela de Despesas',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

// Tela de Investimentos
class InvestimentosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Tela de Investimentos',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

// Tela de Análise
class AnaliseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Tela de Análise',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
