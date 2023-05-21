import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sign_language_app/resgister_page.dart';
import 'package:sign_language_app/screens/navscreens/homepage.dart';
import 'package:sign_language_app/screens/navscreens/navbar.dart';
import 'package:sign_language_app/welecomePage.dart';
import 'package:sign_language_app/widgets/resetPassword.dart';

import 'login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
  await Firebase.initializeApp(
  );
  runApp( MyApp( isFirstTime: isFirstTime,));
}

class MyApp extends StatelessWidget {
  final bool isFirstTime;
  // const MyApp({super.key});
  MyApp({required this.isFirstTime});

// This widget is the root of your application.  
  @override
  Widget build(BuildContext context) {
    User? firbaseuser;
    firbaseuser =FirebaseAuth.instance.currentUser;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      // home: botnavbar(),
      initialRoute:isFirstTime ? WelcomePage.roudeName  : (firbaseuser == null ? LoginPage.id  :MyHome.roudeName),
      routes: {
        ResetPassword.id:(context)=>ResetPassword(),
        WelcomePage.roudeName:(context)=>WelcomePage(),
        LoginPage.id:(context)=>LoginPage(),
        RegisterPage.id:(context)=>RegisterPage(),
        MyHome.roudeName:(context)=>MyHome()

      },
    );
  }
}

