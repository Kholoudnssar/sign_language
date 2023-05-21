




import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_language_app/screens/navscreens/profile/profile.dart';

import '../../login_page.dart';
import 'homepage.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final Padding = EdgeInsets.symmetric(horizontal: 20);


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.blue [300],
        child: ListView(
          padding: Padding,
          children: [
            ListTile(
              title: Text('Deaf Speak',
                style: TextStyle(color: Colors.black,
                    fontFamily: 'pacifico',
                    fontSize: 30),
              ),



            ),
            Divider(color: Colors.white),

            SizedBox(height: 48),
            buildMenuItem( text:'profile',
              icon:Icons.account_circle,

              onClicked:() => selectedItem(context,0) ,
            ),
            SizedBox(height: 16),
            buildMenuItem( text:'Home',
                icon:Icons.home,
                onClicked:() => selectedItem(context,1)
            ),
            Divider(color: Colors.white),
            SizedBox(height: 150),
            buildMenuItem( text:'log out',
                icon:Icons.logout_outlined,
                onClicked: ()async{
                  await Logout();
                  Navigator.pushNamed(context, LoginPage.id);
                }
              // onClicked:() => selectedItem(context,2)
            ),
          ],
        ),
      ),
    );

  }





  buildMenuItem({
    required String text ,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color=Colors.black;
    final hoverColor=Colors.white70;
    return ListTile(
      leading:Icon(icon,color:color),
      title:Text(text,style: TextStyle(color: color,fontSize:20),),
      hoverColor: hoverColor,

      onTap: onClicked,


    );

  }
  void selectedItem (BuildContext context,int index){
    switch(index){
      case 0:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => profile(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHome(),
        ));
        break;
    // case 2:
    //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => logout(),
    //   ));
    //   break;
    }
  }

  Future<void>Logout()async {
    try {
      await FirebaseAuth.instance.signOut();
    }
    catch(e){
      print(e);
    }

  }


}