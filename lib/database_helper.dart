import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _databaseName = "smart_wallet.db";
  static final _databaseVersion = 1;
  static final table = 'receitas';

  static final columnId = 'id';
  static final columnDescricao = 'descricao';
  static final columnMonth = 'month';
  static final columnYear = 'year';
  
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, _databaseName);
    
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(''' 
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnDescricao TEXT NOT NULL,
        $columnMonth TEXT NOT NULL,
        $columnYear TEXT NOT NULL
      )
    ''');
  }

  // Inserir uma receita no banco de dados
  Future<int> insertReceita(Map<String, dynamic> receita) async {
    Database db = await instance.database;
    return await db.insert(table, receita);
  }

  // Consultar as receitas para um determinado mês e ano
  Future<List<Map<String, dynamic>>> queryReceitasByMonthYear(String month, String year) async {
    Database db = await instance.database;
    return await db.query(
      table,
      where: '$columnMonth = ? AND $columnYear = ?',
      whereArgs: [month, year],
    );
  }
  
  // Excluir receitas de um determinado mês e ano
  Future<int> deleteReceitasByMonthYear(String month, String year) async {
    Database db = await instance.database;
    return await db.delete(
      table,
      where: '$columnMonth = ? AND $columnYear = ?',
      whereArgs: [month, year],
    );
  }
}
