import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/localDB/secureStorage/secure_stoarge.dart';
import '../../core/utils/Assets/appAssets.dart';
import '../Routes/custom_AppRoutes.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  void showNotificationWarning() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Notifications may not work at this time'),
        duration: Duration(seconds: 3),
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    //checkInitialMessage();
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   _handleNotificationTap(message);
    // });

   // _initializeNotificationPlugin();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward();

    _controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        final prefs = await SharedPreferences.getInstance();
        final bool isUserLoggedIn = prefs.getBool('isLogged') ?? false;
        final bool isNotificationServiceDisabled = prefs.getBool('isNotificationServiceDisabled') ?? false;

        // final launchDetails = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
        // final didLaunchFromNotification = launchDetails?.didNotificationLaunchApp ?? false;
        // final payload = launchDetails?.notificationResponse?.payload;

          if(isNotificationServiceDisabled){
            showNotificationWarning();
          }


        if (isUserLoggedIn) {
          final String? role = await SecureStorageService.read('role');

          // Navigate to Home first
          if (role == 'Student') {
            Navigator.pushReplacementNamed(context, AppRouters.HomeStudent);
          } else {
            Navigator.pushReplacementNamed(context, AppRouters.doctorHomeRoute);
          }

          // Delay and then push NotificationCenter if launched from notification
          // if (didLaunchFromNotification) {
          //   print('Launched from notifications');
          //   Future.delayed(const Duration(milliseconds: 200), () {
          //     Navigator.of(context).pushNamed(AppRouters.notificationCenterScreen);
          //   });
          // }
        } else {
          Navigator.pushReplacementNamed(context, AppRouters.onBoardRoute);
        }
      }
    });
  }



  // void checkInitialMessage() async {
  //   RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  //   if (initialMessage != null) {
  //     _handleNotificationTap(initialMessage);
  //   }
  // }

  // void _handleNotificationTap(RemoteMessage message) {
  //   // Example navigation
  //   navigatorKey.currentState?.push(
  //     MaterialPageRoute(builder: (_) => const NotificationCenterScreen()),
  //   );
  // }


  // Future<void> _initializeNotificationPlugin() async {
  //   const AndroidInitializationSettings androidSettings =
  //   AndroidInitializationSettings('@mipmap/ic_launcher');
  //   final InitializationSettings initSettings =
  //   InitializationSettings(android: androidSettings);
  //
  //   await flutterLocalNotificationsPlugin.initialize(initSettings);
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Image.asset(AppAssets.logo),
        ),
      ),
    );
  }
}
