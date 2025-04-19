import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
class Fcm{
   static FirebaseMessaging messaging = FirebaseMessaging.instance;


    static Future<void>init()async
    {
     await requestIosPermutition();
      getMyToken();
     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
       print('Got a message whilst in the foreground!');
       print('Message data: ${message.data}');
       if (message.notification != null) {
         print('title notification: ${message.notification?.title}');
         print('body notification: ${message.notification?.body}');

       }
     });
     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
     await forgroundHandling();

    }

   static Future<String?>getMyToken()async{
    String?token=await messaging.getToken();
    print("token:$token");
    return token;
  }
  static Future<void>requestIosPermutition()async{

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
  static Future<void> forgroundHandling()async{
     AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
     description:  'This channel is used for important notifications.', // description
      importance: Importance.max,
    );
     final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
     FlutterLocalNotificationsPlugin();

     await flutterLocalNotificationsPlugin
         .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
         ?.createNotificationChannel(channel);

     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
       RemoteNotification? notification = message.notification;
       AndroidNotification? android = message.notification?.android;

       // If `onMessage` is triggered with a notification, construct our own
       // local notification to show to users using the created channel.
       if (notification != null && android != null) {
         flutterLocalNotificationsPlugin.show(
             notification.hashCode,
             notification.title,
             notification.body,
             NotificationDetails(
               android: AndroidNotificationDetails(
                 channel.id,
                 channel.name,
                 channelDescription: channel.description,
                 icon: "@mipmap/ic_launcher",
                 // other properties...
               ),
             ));
       }
     });
  }
}
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
  print('Message data: ${message.data}');
  if (message.notification != null) {
    print('title notification: ${message.notification?.title}');
    print('body notification: ${message.notification?.body}');
  }
}