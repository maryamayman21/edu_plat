import 'package:edu_platt/presentation/Routes/custom_AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
class DoctorExamScreen extends StatelessWidget {
  const DoctorExamScreen({super.key});

  bool isRouteAtTop(BuildContext context, String routeName, String? currentRoute) {
      print('Done route ');
      print(' ${ModalRoute.of(context)?.settings.name}');
    return  currentRoute == routeName;
  }

  Future<bool> isLoggedIn()async{
     final prefs = await SharedPreferences.getInstance();
     final bool isUserLoggedIn = prefs.getBool('isLogged')  ?? false;
          return isUserLoggedIn;
   }

  @override
   Widget build(BuildContext context){
    Future.microtask(() async{
      final bool isUserLoggedIn = await  isLoggedIn();
       print('Done');
       print(isUserLoggedIn);
      String? currentRoute = ModalRoute.of(context)?.settings.name;
      if( isUserLoggedIn && isRouteAtTop(context, AppRouters.loginStudentRoute , currentRoute)){
        SystemNavigator.pop();
        print('Done1');
      }
      else if( isUserLoggedIn && isRouteAtTop(context, AppRouters.doctorHomeRoute , currentRoute)){
        SystemNavigator.pop();
      }
    });

    return const Placeholder();
  }
}
