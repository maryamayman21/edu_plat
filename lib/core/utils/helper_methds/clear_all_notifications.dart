import 'dart:io';

import 'package:edu_platt/presentation/splash/splash.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> clearAllNotifications() async {

  await flutterLocalNotificationsPlugin.cancelAll();



  // if (Platform.isIOS) {
  //   await flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //       IOSFlutterLocalNotificationsPlugin>()
  //       ?.removeAllDeliveredNotifications();
  // }
  //

  // if (Platform.isIOS) {
  //   await flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //       IOSFlutterLocalNotificationsPlugin>()
  //       ?.setApplicationIconBadgeNumber(0);
  // }
}