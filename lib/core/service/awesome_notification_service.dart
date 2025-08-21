import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/features/main/data/models/task_model.dart';

import '../../features/main/data/data_source/task_local_datasource.dart';

class AwesomeNotificationService {
  static Future<void> initializateNotification() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'high_importance_channel',
          channelName: 'Alerts',
          channelDescription: 'Notification tests as alerts',
          playSound: true,
          onlyAlertOnce: true,
          groupAlertBehavior: GroupAlertBehavior.Children,
          importance: NotificationImportance.High,
          defaultPrivacy: NotificationPrivacy.Private,
          defaultColor: Colors.deepPurple,
          ledColor: Colors.deepPurple,
        ),
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'basic_channel_group',
          channelGroupName: 'Basic group',
        )
      ],
      debug: true,
    );

    final isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }

    AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );
  }

  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification,
      ) async {
    debugPrint('onNotificationCreatedMethod');
  }

  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification,
      ) async {
    debugPrint('onNotificationDisplayedMethod');
  }

  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction,
      ) async {
    debugPrint('onDismissActionReceivedMethod');
  }

  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction,
      ) async {
    debugPrint('onActionReceivedMethod');
    final payload = receivedAction.payload ?? {};
    final taskId = payload['taskId'];
    if (taskId == null || taskId.isEmpty) return;

    // Faqat DONE tugmasi: is_done = 1
    if (receivedAction.buttonKeyPressed == 'DONE') {
      await TaskLocalDataSource.instance.markDone(taskId);
    }
  }


  static Future<void> showNotification({required TaskModel message}) async {
    final title = message.title ?? '';
    final body = "Bajarildi" ?? '';
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: Random().nextInt(100000),
        channelKey: 'high_importance_channel',
        title: title,
        body: body,
      ),
    );
  }

  static Future<void> showTaskReminder({required TaskModel task}) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch % 100000000,
        channelKey: 'high_importance_channel',
        title: 'Bajardingizmi?',
        body: task.title ?? 'Vazifa',
        payload: {'taskId': task.id},
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'DONE',
          label: 'Ha, bajardim',
        ),
      ],
    );
  }
}
