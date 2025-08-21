import 'package:flutter/material.dart';
import 'package:todoapp/core/config/app_theme.dart';
import 'package:todoapp/features/main/domain/repositories/task_repository.dart';
import 'package:todoapp/features/main/presentation/bloc/task_bloc.dart';
import 'package:todoapp/features/main/presentation/page/main_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workmanager/workmanager.dart';

import 'core/service/worker_service.dart';
import 'core/service/awesome_notification_service.dart';
import 'core/service/permissions.dart';
import 'features/main/data/data_source/task_local_datasource.dart';
import 'features/main/data/repositories/task_repository_impl.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HandlerPermissions.permissionNotification();
  await AwesomeNotificationService.initializateNotification();

  await Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: false,
  );

  final dataSource = TaskLocalDataSource.instance;
  final repository = TaskRepositoryImpl(localDataSource: dataSource);

  // await Workmanager().registerOneOffTask(
  //   "testTaskUnique", // uniqueName
  //   "testTaskSimple", // simpleName
  //   initialDelay: const Duration(seconds: 5),
  // );

  await Workmanager().registerPeriodicTask(
    taskUniqueName,
    taskSimpleName,
    frequency: const Duration(minutes: 15),
    existingWorkPolicy: ExistingWorkPolicy.keep,
    inputData: {'older_minutes': 15},
    constraints: Constraints(
      networkType: NetworkType.not_required,
      requiresBatteryNotLow: false,
      requiresCharging: false,
    ),
    backoffPolicy: BackoffPolicy.linear,
  );
  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final TaskRepositoryImpl repository;

  MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TaskBloc(repository: repository)..add(LoadTasks()),
      child: MaterialApp(
        title: 'TODO APP',
        theme: AppTheme.theme,
        home: const MainScreen(),
      ),
    );
  }
}
