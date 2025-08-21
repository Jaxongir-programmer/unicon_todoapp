import 'package:workmanager/workmanager.dart';
import '../../features/main/data/data_source/task_local_datasource.dart';
import '../../features/main/data/models/task_model.dart';
import 'awesome_notification_service.dart';

const taskUniqueName = 'check_not_done_task';
const taskSimpleName = 'checkNotDoneTask';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    print("✅ Workmanager ishga tushdi: $task");
    await AwesomeNotificationService.initializateNotification();

    final olderMinutes = (inputData?['older_minutes'] as int?) ?? 60; // default: 60 min
    final stale = await TaskLocalDataSource.instance
        .getStaleTodos(Duration(minutes: olderMinutes));

    if (stale.isNotEmpty) {
      await AwesomeNotificationService.showNotification(
        message: TaskModel(
          title: 'Eslatma',
          description: 'Sizda ${stale.length} ta bajarilmagan vazifa bor',
          isDone: false,
          createdAt: DateTime.now(),
        ),
      );
    }

    return Future.value(true);
  });
}
