import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class WidgetBridge {
  static const _channel = MethodChannel('task_widget_channel');

  // SQL: bajarilgan/bajarilmagan sonlari
  static Future<Map<String,int>> _getCountsFromDb() async {
    final dir = await getDatabasesPath();
    final db = await openDatabase(p.join(dir, 'tasks.db'));
    final res = await db.rawQuery('''
      SELECT 
        SUM(CASE WHEN is_done = 1 THEN 1 ELSE 0 END) AS done,
        SUM(CASE WHEN is_done = 0 THEN 1 ELSE 0 END) AS todo
      FROM tasks
    ''');
    final row = res.first;
    return {
      'done': (row['done'] as int?) ?? 0,
      'todo': (row['todo'] as int?) ?? 0,
    };
  }

  /// Widgetni yangilash: SQL -> native -> widget
  static Future<void> refreshHomeWidgetCounts() async {
    final counts = await _getCountsFromDb();
    await _channel.invokeMethod('updateCounts', {
      'done': counts['done'],
      'todo': counts['todo'],
    });
  }
}
