import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sign_language_app/resgister_page.dart';
import 'package:sign_language_app/screens/navscreens/navbar.dart';
import 'package:sign_language_app/widgets/resetPassword.dart';

import 'login_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp(const MyApp());
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
      initialRoute: firbaseuser == null ? LoginPage.id  :Botnavbar.roudeName,
      routes: {
         ResetPassword.id:(context)=>ResetPassword(),
        LoginPage.id:(context)=>LoginPage(),
        RegisterPage.id:(context)=>RegisterPage(),
        Botnavbar.roudeName:(context)=>Botnavbar()

      },
    );
  }
}

