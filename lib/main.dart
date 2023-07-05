import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sign_language_app/resgister_page.dart';
import 'package:sign_language_app/screens/navscreens/homepage.dart';
import 'package:sign_language_app/screens/navscreens/navbar.dart';
import 'package:sign_language_app/user_provider.dart';
import 'package:sign_language_app/welecomePage.dart';
import 'package:sign_language_app/widgets/resetPassword.dart';

import 'Save.dart';
import 'login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  await Saver.init();
  runApp(  Provider<UserProvider>(
      create: (_) => UserProvider(),
      child: const MyApp( )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      initialRoute: Saver.getData('welecome')==null ? WelcomePage.roudeName  : (firbaseuser == null ? LoginPage.id  :MyHome.roudeName),
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

