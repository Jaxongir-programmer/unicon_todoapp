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

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT,
        is_done INTEGER NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertTask(TaskModel task) async {
    final db = await instance.database;

    final map = <String, Object?>{
      'id': task.id,
      'title': task.title,
      'description': task.description,
      'is_done': task.isDone ? 1 : 0,
      'created_at': task.createdAt.toIso8601String(),
    };

    await db.insert('tasks', map, conflictAlgorithm: ConflictAlgorithm.abort);
  }

  Future<List<TaskModel>> getTasks({bool? isDone}) async {
    final db = await instance.database;

    List<Map<String, Object?>> rows;
    if (isDone == null) {
      rows = await db.query('tasks', orderBy: 'created_at DESC');
    } else {
      rows = await db.query(
        'tasks',
        where: 'is_done = ?',
        whereArgs: [isDone ? 1 : 0],
        orderBy: 'created_at DESC',
      );
    }

    return rows.map((e) => TaskModel.fromMap(e)).toList();
  }

  Future<List<TaskModel>> getUndoneTasks() async {
    final db = await instance.database;
    final rows = await db.query(
      'tasks',
      where: 'is_done = ?',
      whereArgs: [0],
      orderBy: 'created_at DESC',
    );
    return rows.map((e) => TaskModel.fromMap(e)).toList();
  }

  Future<List<TaskModel>> getDueUndoneAfter24h() async {
    final db = await instance.database;
    final thresholdIso = DateTime.now()
        // .subtract(const Duration(hours: 24))
        .subtract(const Duration(minutes: 2))
        .toIso8601String();

    final rows = await db.query(
      'tasks',
      where: 'is_done = 0 AND created_at <= ?',
      whereArgs: [thresholdIso],
      orderBy: 'created_at ASC',
    );

    return rows.map((e) => TaskModel.fromMap(e)).toList();
  }

  Future<void> updateTask(TaskModel task) async {
    final db = await instance.database;

    final map = <String, Object?>{
      'title': task.title,
      'description': task.description,
      'is_done': task.isDone ? 1 : 0,
      'created_at': task.createdAt.toIso8601String(),
    };

    await db.update(
      'tasks',
      map,
      where: 'id = ?',
      whereArgs: [task.id],
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  //vaqtim yetsa qo'shaman.
  Future<void> deleteTask(String id) async {
    final db = await instance.database;
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<TaskModel>> getStaleTodos(Duration olderThan) async {
    final db = await database;
    final res = await db.query('tasks', where: 'is_done = 0');
    final all = res.map(TaskModel.fromMap).toList();
    final threshold = DateTime.now().subtract(olderThan);
    return all.where((t) => t.createdAt.isBefore(threshold)).toList();
  }

  Future<void> markDone(String id) async {
    final db = await database;
    await db.update(
      'tasks',
      {'is_done': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
