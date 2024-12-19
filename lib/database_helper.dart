import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  // Inicializando o banco de dados
  static Future<Database> getDatabase() async {
    if (_database != null) {
      return _database!;
    }

    // Inicializa o banco de dados
    _database = await openDatabase(
      join(await getDatabasesPath(), 'smart_wallet.db'),
      onCreate: (db, version) {
        // Criação das tabelas
        return db.execute(
          'CREATE TABLE receitas(id INTEGER PRIMARY KEY, descricao TEXT, valor REAL, data TEXT)',
        );
      },
      version: 1,
    );

    return _database!;
  }

  // Função para inserir dados na tabela 'receitas'
  static Future<void> insertReceita(Map<String, dynamic> receita) async {
    final db = await getDatabase();

    await db.insert(
      'receitas',
      receita,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Função para recuperar todas as receitas
  static Future<List<Map<String, dynamic>>> getReceitas() async {
    final db = await getDatabase();

    return db.query('receitas');
  }

  // Função para fechar o banco de dados
  static Future<void> closeDatabase() async {
    final db = await getDatabase();
    await db.close();
  }
}
