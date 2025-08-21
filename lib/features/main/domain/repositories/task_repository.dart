import 'package:todoapp/features/main/data/models/task_model.dart';

abstract class TaskRepository {
  Future<void> addTask(TaskModel task);

  Future<List<TaskModel>> getTasks({bool? isDone});

  Future<void> updateTask(TaskModel task);
}
