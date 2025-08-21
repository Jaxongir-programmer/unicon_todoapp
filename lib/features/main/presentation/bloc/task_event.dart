part of 'task_bloc.dart';

abstract class TaskEvent {}

class LoadTasks extends TaskEvent {
  final bool? isDone;

  LoadTasks({this.isDone});
}

class AddTask extends TaskEvent {
  final TaskModel task;

  AddTask(this.task);
}

class UpdateTask extends TaskEvent {
  final TaskModel task;

  UpdateTask(this.task);
}