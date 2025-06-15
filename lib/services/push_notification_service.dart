import 'dart:developer';

import 'package:edu_platt/presentation/Auth/service/token_service.dart';
import 'package:edu_platt/services/local_notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PushNotificationsService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;


 static Future<void> initializePushNotifications() async {
    const maxRetries = 3;
    int attempt = 0;

    while (attempt < maxRetries) {
      try {
        await PushNotificationsService.init();
        return;
      } catch (e) {
        attempt++;
        log('Push notification initialization attempt $attempt failed: $e');
        if (attempt == maxRetries) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('isNotificationServiceDisabled', true);
          return;
        }
        // Exponential backoff
        await Future.delayed(Duration(seconds: 2 * attempt));
      }
    }
  }

  static Future init() async {
    try {
      await messaging.requestPermission();
      String? token = await _getTokenWithRetry();
      if (token != null) {
        cacheDeviceToken(token);
        log('cached device token $token');
      }

      messaging.onTokenRefresh.listen((value) {
        cacheDeviceToken(value);
      });

      FirebaseMessaging.onBackgroundMessage(handlebackgroundMessage);
      handleForegroundMessage();
    } catch (e) {
      log('Push notification initialization failed: $e');
      // Consider setting a flag to retry later
      rethrow; // Only if you want the caller to handle it
    }
  }

  static Future<String?> _getTokenWithRetry() async {
    const maxRetries = 2;
    int attempt = 0;

    while (attempt < maxRetries) {
      try {
        return await messaging.getToken();
      } catch (e) {
        attempt++;
        if (attempt == maxRetries) {
          log('Failed to get FCM token after $maxRetries attempts');
          return null;
        }
        await Future.delayed(Duration(seconds: 1));
      }
    }
    return null;
  }

  // static Future init() async {
  //   await messaging.requestPermission();
  //   String? token = await messaging.getToken();
  //   log(token?? 'null');
  //   await messaging.getToken().then((value) {
  //     cacheDeviceToken(value!);
  //     log('cached device token');
  //   });
  //   messaging.onTokenRefresh.listen((value){
  //     cacheDeviceToken(value);
  //   });
  //   FirebaseMessaging.onBackgroundMessage(handlebackgroundMessage);
  //   // //foreground
  //    handleForegroundMessage();
  //   // messaging.subscribeToTopic('all').then((val){
  //   //   log('sub');
  //   // });
  //
  //   // messaging.unsubscribeFromTopic('all');
  // }

  static void subscribeUserToTopics() {
    messaging.subscribeToTopic('exam');
    messaging.subscribeToTopic('material');
  }

  static void unsubscribeUserToTopics() {
    messaging.unsubscribeFromTopic('exam');
    messaging.unsubscribeFromTopic('material');
  }

  static Function()? onNewNotification;

  static Future<void> handlebackgroundMessage(RemoteMessage message) async {
    await Firebase.initializeApp();
    log(message.notification?.title ?? 'null');
    onNewNotification?.call();
  }

  static void handleForegroundMessage() {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        // show local notification
        LocalNotificationService.showBasicNotification(
          message,
        );
        onNewNotification?.call(); // Notify UI
      },
    );
  }

  static void cacheDeviceToken(String token) async {
    await TokenService().saveDeviceToken(token);
  }

  static Future<String?> getDeviceToken() async {
    return await TokenService().getDeviceToken();
  }
}
/*
  1.Permissions [done]
  2.fcm token [done]
  3.test using token with Firebase [done]
  4.fire notification [background] [done]
  5.fire notification [killed] [done]
  6.fire notification [foreground] [done]
  7.test using token with Postman [done]
  8.send Image with notification [done]
  9.send notfification with custom sound [done]
  10.send token to server [done]
  11.topic [done]
 */
