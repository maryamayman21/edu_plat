import 'dart:developer';

import 'package:edu_platt/presentation/Auth/service/token_service.dart';
import 'package:edu_platt/services/local_notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


class PushNotificationsService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future init() async {
    await messaging.requestPermission();
    String? token = await messaging.getToken();
    log(token?? 'null');
    await messaging.getToken().then((value) {
      cacheDeviceToken(value!);
      log('cached device token');
    });
    messaging.onTokenRefresh.listen((value){
      cacheDeviceToken(value);
    });
    FirebaseMessaging.onBackgroundMessage(handlebackgroundMessage);
    // //foreground
     handleForegroundMessage();
    // messaging.subscribeToTopic('all').then((val){
    //   log('sub');
    // });

    // messaging.unsubscribeFromTopic('all');
  }


  static void subscribeUserToTopics(){
    messaging.subscribeToTopic('exam');
    messaging.subscribeToTopic('material');

  }


  static void unsubscribeUserToTopics(){
    messaging.unsubscribeFromTopic('exam');
    messaging.unsubscribeFromTopic('material');

  }


  static Future<void> handlebackgroundMessage(RemoteMessage message) async {
    await Firebase.initializeApp();
    log(message.notification?.title ?? 'null');
  }

  static void handleForegroundMessage() {
    FirebaseMessaging.onMessage.listen(
          (RemoteMessage message) {
        // show local notification
        LocalNotificationService.showBasicNotification(
          message,
        );
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