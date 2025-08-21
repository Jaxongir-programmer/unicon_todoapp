import 'package:todoapp/core/config/app_constants.dart';
import 'package:workmanager/workmanager.dart';
import '../../features/main/data/data_source/task_local_datasource.dart';
import '../../features/main/data/models/task_model.dart';
import 'awesome_notification_service.dart';


const taskUniqueName = 'check_not_done_task';
const taskSimpleName = 'checkNotDoneTask';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    await AwesomeNotificationService.initializateNotification();

    final dueList = await TaskLocalDataSource.instance.getDueUndoneAfter24h();

    for (final t in dueList) {
      await AwesomeNotificationService.showTaskReminder(task: t);
    }

    return true;
  });
}

Future<void> initAndRegisterWorker({Duration frequency = const Duration(minutes: 15)}) async {
  await Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: false,
  );

  await Workmanager().registerPeriodicTask(
    taskUniqueName,
    taskSimpleName,
    frequency: frequency,
    existingWorkPolicy: ExistingWorkPolicy.keep,
    constraints: Constraints(
      networkType: NetworkType.not_required,
      requiresBatteryNotLow: false,
      requiresCharging: false,
    ),
    backoffPolicy: BackoffPolicy.linear,
  );
}

