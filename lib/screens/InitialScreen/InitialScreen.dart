import 'package:dormcare/screens/HomeScreen/HomeScreen.dart';
import 'package:dormcare/screens/SplashScreen/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool isUserLogged = false;

  Future<void> getStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? res = await prefs.getBool('isUserLoggedIn');
    setState(() {
      isUserLogged = res == null ? false : res;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isUserLogged) {
      return HomeScreen();
    } else {
      return SplashScreen();
    }
  }
}
