import 'package:gerenciador_tarefas/models/tarefa.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'tarefas.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tarefas(id INTEGER PRIMARY KEY AUTOINCREMENT, titulo TEXT, descricao TEXT, cor TEXT, arquivada INTEGER)',
        );
      },
    );
  }

  Future<void> inserirTarefa(Tarefa tarefa) async {
    final db = await database;
    await db.insert('tarefas', tarefa.toMap());
  }

  Future<List<Tarefa>> obterTarefas() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tarefas', where: 'arquivada = ?', whereArgs: [0]);
    return List.generate(maps.length, (i) {
      return Tarefa.fromMap(maps[i]);
    });
  }

  Future<List<Tarefa>> obterTarefasArquivadas() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tarefas', where: 'arquivada = ?', whereArgs: [1]);
    return List.generate(maps.length, (i) {
      return Tarefa.fromMap(maps[i]);
    });
  }

  Future<void> arquivarTarefa(int id) async {
    final db = await database;
    await db.update(
      'tarefas',
      {'arquivada': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deletarTarefa(int id) async {
    final db = await database;
    await db.delete(
      'tarefas',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
