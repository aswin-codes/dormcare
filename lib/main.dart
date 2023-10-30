import 'package:dormcare/screens/Complaint/ComplaintScreen.dart';
import 'package:dormcare/screens/HomeScreen/HomeScreen.dart';
import 'package:dormcare/screens/Login/Login.dart';
import 'package:dormcare/screens/Profile/ProfileScreen.dart';
import 'package:dormcare/screens/SignUp/SignUp.dart';
import 'package:dormcare/screens/SplashScreen/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_ , child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'DormCare',
          // You can use the library anywhere in the app even in theme
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          routes: {
            '/' :(context) => HomeScreen(),
            '/splash' : (context) => SplashScreen(),
            '/signup' :  (context) => SignUp(),
            '/login' :(context) => Login(),
            '/profile' : (context) => ProfileScreen(),
            '/complaint' : (context) => ComplaintScreen()
          },
          initialRoute: '/complaint',
        );
      },
    );
  }
}