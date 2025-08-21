import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:todoapp/features/main/data/models/task_model.dart';

import '../../../../core/service/awesome_notification_service.dart';
import '../../../../core/widget_bridge.dart';
import '../../domain/repositories/task_repository.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository repository;

  TaskBloc({
    required this.repository,
  }) : super(TaskState()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
  }

  Future<void> _onLoadTasks(LoadTasks event, Emitter<TaskState> emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    final result = await repository.getTasks(isDone: event.isDone);

    emit(state.copyWith(status: FormzSubmissionStatus.success, tasks: result));
  }

  Future<void> _onAddTask(AddTask event, Emitter<TaskState> emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    await repository.addTask(event.task);

    emit(state.copyWith(addTaskStatus: FormzSubmissionStatus.success));
    add(LoadTasks());
    await WidgetBridge.refreshHomeWidgetCounts();
  }

  Future<void> _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) async {
    try {
      await repository.updateTask(event.task);
      if(event.task.isDone) {
        AwesomeNotificationService.showNotification(message: event.task);
        AwesomeNotificationService.showTaskReminder(task: event.task);
      }
      add(LoadTasks());
      await WidgetBridge.refreshHomeWidgetCounts();
    } catch (e) {
      //
    }
  }
}
