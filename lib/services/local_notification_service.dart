import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:edu_platt/presentation/Student/screen/notes/data/model/note.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  static StreamController<NotificationResponse> streamController =
  StreamController();
  static onTap(NotificationResponse notificationResponse){
    // log(notificationResponse.id!.toString());
    // log(notificationResponse.payload!.toString());
  //  final role = await SecureStorageService.read('role');
    streamController.add(notificationResponse);

    // navigatorKey.currentState?.pushAndRemoveUntil(
    //   role == 'Student'
    //       ?  MaterialPageRoute(
    //       builder: (context) => const HomeStudentScreen())
    //       : MaterialPageRoute(builder: (context) => HomeScreen(),),
    //       (route) => false,
    // );

// Push NotificationCenterScreen after a tiny delay to allow Navigator to unlock
//    print('Hello form local notification');
//     Future.delayed(const Duration(milliseconds: 10), () {
//       navigatorKey.currentState?.push(
//         CustomPageRoute(page: const NotificationCenterScreen()),
//       );
//     });

  }

  static Future init() async {
    InitializationSettings settings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,

    );

    const DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission:true,
        );

    if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidPlugin =
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
      await androidPlugin?.requestNotificationsPermission();
    } else if (Platform.isIOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    }



  }

   static Future<void> scheduleNotification(Note note, int id) async {
    if (note.date== null || note.date!.isBefore(DateTime.now())) {
      return;
    }

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'note_reminder_channel',
      'Note Reminders',
      channelDescription: 'Notifications for note reminders',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: DarwinNotificationDetails(),
    );
    tz.initializeTimeZones();
    // Use the emulator's local timezone
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        note.title,
       'Don\'t forget! You have a task waiting for you.',
        tz.TZDateTime.from(note.date!, tz.local),
        platformChannelSpecifics,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        payload: note.title,
    );
   // print('Scheduled notification for ${note.title} at ${note.date} in ${tz.local.name}');

   }



  //basic Notification
  static void showBasicNotification(RemoteMessage message) async {
    // final http.Response image = await http
    //     .get(Uri.parse(message.notification?.android?.imageUrl ?? ''));
    // BigPictureStyleInformation bigPictureStyleInformation =
    // BigPictureStyleInformation(
    //   ByteArrayAndroidBitmap.fromBase64String(
    //     base64Encode(image.bodyBytes),
    //   ),
    //   largeIcon: ByteArrayAndroidBitmap.fromBase64String(
    //     base64Encode(image.bodyBytes),
    //   ),
    // );
    AndroidNotificationDetails android = const AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      // styleInformation: bigPictureStyleInformation,
      // playSound: true,
      // sound: RawResourceAndroidNotificationSound(
      //     'long_notification_sound'.split('.').first),
    );
    NotificationDetails details = NotificationDetails(
      android: android,
    );
    await flutterLocalNotificationsPlugin.show(

      0,
      message.notification?.title,
      message.notification?.body,
      details,
    );
  }

  // static void showScheduledNotification({
  //   required DateTime scheduledDate,
  //   required Note taskModel,
  //   required int id,
  // }) async {
  //   const AndroidNotificationDetails android = AndroidNotificationDetails(
  //     'scheduled_notification_channel_id',
  //     'Scheduled Notifications',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //   );
  //
  //   const NotificationDetails details = NotificationDetails(android: android);
  //
  //   tz.initializeTimeZones(
  //   );
  //
  //   final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
  //   print('current time zone $currentTimeZone');
  //   tz.setLocalLocation(tz.getLocation(currentTimeZone, ) );
  //   var cairo = tz.getLocation('Africa/Cairo');
  //   var now = tz.TZDateTime.now(cairo);
  //   log('Time now in cairo :  $now');
  //   final tz.TZDateTime scheduledTZDateTime =
  //   tz.TZDateTime.from(DateTime(2025, 5 , 10 , 3, 15), tz.local);
  // log(' scheduled time : $scheduledTZDateTime');
  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //     id,
  //     taskModel.title,
  //     taskModel.description,
  //     scheduledTZDateTime,
  //     details,
  //     payload: 'Title: ${taskModel.title}, Note: ${taskModel.description}',
  //     androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //     uiLocalNotificationDateInterpretation:
  //     UILocalNotificationDateInterpretation.absoluteTime,
  //     matchDateTimeComponents: DateTimeComponents.time,
  //   );
  //   print('DONE');
  // }
  static void showScheduledNotification(
      {required DateTime scheduledDate,
        required Note taskModel,
        required int id
      }) async {
    const AndroidNotificationDetails android = AndroidNotificationDetails(
      'scheduled notification',
      'id 3',
      importance: Importance.max,
      priority: Priority.high,
    );
    NotificationDetails details = const NotificationDetails(
      android: android,
    );

    tz.initializeTimeZones();
    log(tz.local.name);
    log("Before ${tz.TZDateTime.now(tz.local).hour}");
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    log(currentTimeZone);
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    log(tz.local.name);
    log("After ${tz.TZDateTime.now(tz.local).hour}");
    final location = tz.getLocation('Africa/Cairo');
    final now = tz.TZDateTime.now(location);
    log('Time in Cairo: ${now.toString()}');
    log('UTC offset in Cairo: ${now.timeZoneOffset}');
    final scheduledDate =  tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10));
   log('scheduled time $scheduledDate');
    await flutterLocalNotificationsPlugin.zonedSchedule(
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      id,
      taskModel.title,
      taskModel.description,
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)),
      // tz.TZDateTime(
      //   tz.local, scheduled.year,
      //   scheduled.month,
      //   scheduled.day,
      //   scheduled.hour,
      //   scheduled.minute,
      // ).subtract(const Duration(minutes: 1)),
      details,
      payload: 'Title: ${taskModel.title}  , Note: "${taskModel.description}',
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );

  }
  static void cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}