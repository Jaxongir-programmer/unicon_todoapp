import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/features/main/data/models/task_model.dart';

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
              ledColor: Colors.deepPurple)
        ],
        channelGroups: [NotificationChannelGroup(channelGroupKey: 'basic_channel_group', channelGroupName: 'Basic group')],
        debug: true);

    await AwesomeNotifications().isNotificationAllowed().then((isAllowed) async {
      print("JV = > $isAllowed");
      if (!isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );
  }

  static Future<void> onNotificationCreatedMethod(ReceivedNotification receivedNotification) async {
    debugPrint('onNotificationCreatedMethod');
  }

  static Future<void> onNotificationDisplayedMethod(ReceivedNotification receivedNotification) async {
    debugPrint('onNotificationDisplayedMethod');
  }

  static Future<void> onDismissActionReceivedMethod(ReceivedNotification receivedNotification) async {
    debugPrint('onDismissActionReceivedMethod');
  }

  static Future<void> onActionReceivedMethod(ReceivedNotification receivedNotification) async {
    debugPrint('onActionReceivedMethod');
    final payload = receivedNotification.payload ?? {};
    if (payload["navigate"] == "true") {
      // MyApp.navigatorKey.currentState?.push(MaterialPageRoute(builder: (_) => SplashScreen()));
    }
  }

  static Future<void> showNotification({required TaskModel message}) async {
    String title = message.title ?? "";
    String body = message.description ?? "";
    await AwesomeNotifications().createNotification(
      content: NotificationContent(id: Random().nextInt(100000), channelKey: 'high_importance_channel', title: title, body: body),
      actionButtons: [
        NotificationActionButton(
          key: 'MARK_DONE',       // 🔑 tugma identifikatori
          label: 'Bajarildi',     // tugma matni
          actionType: ActionType.Default, // app’ni ochmasdan ham ishlaydi
          autoDismissible: true,  // bosilganda kartochkani yopadi
          isDangerousOption: false, // ixtiyoriy
        ),

      ],
    );
  }
}
