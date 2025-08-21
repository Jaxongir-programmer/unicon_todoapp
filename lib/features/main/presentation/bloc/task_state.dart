part of 'task_bloc.dart';

@immutable
class TaskState extends Equatable {
  final List<TaskModel> tasks;
  final FormzSubmissionStatus status;
  final FormzSubmissionStatus addTaskStatus;

  const TaskState({
    this.tasks = const [],
    this.status = FormzSubmissionStatus.initial,
    this.addTaskStatus = FormzSubmissionStatus.initial,
  });

  TaskState copyWith({
    List<TaskModel>? tasks,
    FormzSubmissionStatus? status,
    FormzSubmissionStatus? addTaskStatus,
  }) {
    return TaskState(
      tasks: tasks ?? this.tasks,
      status: status ?? this.status,
      addTaskStatus: addTaskStatus ?? this.addTaskStatus,
    );
  }

  @override
  List<Object?> get props => [tasks,status, addTaskStatus];
}
