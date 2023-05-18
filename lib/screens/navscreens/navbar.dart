
import 'package:flutter/material.dart';
import 'package:sign_language_app/screens/navscreens/profile/profile.dart';

import 'homepage.dart';
class Botnavbar extends StatefulWidget {
static const String roudeName='Nav';
  @override
  State<Botnavbar> createState() => _BotnavbarState();
}

class _BotnavbarState extends State<Botnavbar> {
  int currentIndexy=0;
  List screens=[
   MyHome(),const profile()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon:Icon(Icons.home),
             label: 'home',
             ),
             
             
             BottomNavigationBarItem(
            icon:Icon(Icons.account_circle),
             label: 'profile',
             )  
        ],
        backgroundColor: Colors.indigo,
        elevation: 5.0,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 20.0,
        selectedIconTheme: IconThemeData(color: Colors.black,size: 30),
        selectedItemColor: Colors.black,
        selectedLabelStyle: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.normal,

        ),
        unselectedFontSize: 20.0,
        unselectedIconTheme: IconThemeData(color: Colors.grey,size: 20.0),
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: TextStyle(
          color: Colors.grey,
          fontSize: 20.0,
          fontWeight: FontWeight.normal,
      ),
      currentIndex:0,
      onTap: (index){
        setState(() {
          currentIndexy=index;
        });
        
      },
    ),
    body: screens[currentIndexy],
    );


  }
}