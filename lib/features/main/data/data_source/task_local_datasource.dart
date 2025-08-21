import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/task_model.dart';

class TaskLocalDataSource {
  static final TaskLocalDataSource instance = TaskLocalDataSource._init();
  static Database? _database;

  TaskLocalDataSource._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('tasks.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        is_done INTEGER NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertTask(TaskModel task) async {
    final db = await instance.database;
    await db.insert('tasks', task.toMap());
  }

  Future<List<TaskModel>> getTasks({bool? isDone}) async {
    final db = await instance.database;

    final where = isDone != null ? 'WHERE is_done = ${isDone ? 1 : 0}' : '';
    final result = await db.rawQuery('SELECT * FROM tasks $where ORDER BY created_at DESC');

    return result.map((e) => TaskModel.fromMap(e)).toList();
  }

  Future<void> updateTask(TaskModel task) async {
    final db = await instance.database;
    await db.update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  Future<void> deleteTask(int id) async {
    final db = await instance.database;
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<TaskModel>> getStaleTodos(Duration olderThan) async {
    final db = await database;
    final res = await db.rawQuery('SELECT * FROM tasks WHERE is_done = 0');
    final all = res.map(TaskModel.fromMap).toList();
    final threshold = DateTime.now().subtract(olderThan);
    return all.where((t) => t.createdAt.isBefore(threshold)).toList();
  }
}