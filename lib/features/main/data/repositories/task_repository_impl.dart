import '../../domain/repositories/task_repository.dart';
import '../data_source/task_local_datasource.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource localDataSource;

  TaskRepositoryImpl({required this.localDataSource});

  @override
  Future<void> addTask(TaskModel task) async {
    await localDataSource.insertTask(task);
  }


  @override
  Future<List<TaskModel>> getTasks({bool? isDone}) async {
    return await localDataSource.getTasks(isDone: isDone);
  }

  @override
  Future<void> updateTask(TaskModel task) async {

    await localDataSource.updateTask(task);
  }

}