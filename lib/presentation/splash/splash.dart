import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/localDB/secureStorage/secure_stoarge.dart';
import '../../core/utils/Assets/appAssets.dart';
import '../Routes/custom_AppRoutes.dart';
class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash>
with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();

    // Initialize the animation controller and the animation itself
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Animation duration
    );
    // Define a tween for scaling the logo
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    // Start the animation
    _controller.forward();

    // Navigate to the next screen after the animation completes
    _controller.addStatusListener((status) async{
      if (status == AnimationStatus.completed) {
        final prefs = await SharedPreferences.getInstance();
        final bool isUserLoggedIn = prefs.getBool('isLogged')  ?? false;

          if( isUserLoggedIn) {
            final String? role = await SecureStorageService.read('role');
                if(role == 'Student'){
                  Navigator.pushReplacementNamed(context, AppRouters.HomeStudent);
                }
                else{
                  Navigator.pushReplacementNamed(context, AppRouters.doctorHomeRoute);
                }
         }
          else{
            Navigator.pushReplacementNamed(context, AppRouters.onBoardRoute);
          }
      }
    });
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

   return  Scaffold(
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

