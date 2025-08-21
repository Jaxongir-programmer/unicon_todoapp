import 'dart:io';

import 'package:permission_handler/permission_handler.dart';


class HandlerPermissions {
  static Future<void> permissionNotification() async {
    final PermissionStatus status = await Permission.notification.request();
    if (status.isGranted) {
      // Notification permissions granted
    } else if (status.isDenied) {
      // Notification permissions denied
    } else if (status.isPermanentlyDenied) {
      // Notification permissions permanently denied, open app settings
      // print("JV = > openAppSettings");
      // await openAppSettings();
    }
  }
}
