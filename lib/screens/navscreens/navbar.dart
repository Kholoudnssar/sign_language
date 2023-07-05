import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider/flutter_provider.dart';
import 'package:sign_language_app/datdbase/database_utils.dart';
import 'package:sign_language_app/screens/navscreens/profile/language_guide.dart';
import 'package:sign_language_app/screens/navscreens/profile/profile.dart';

import '../../login_page.dart';
import '../../user_provider.dart';
import 'homepage.dart';

class NavigationDrawerWidget extends StatefulWidget {

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  // final Padding = EdgeInsets.only(left: 10);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Color.fromARGB(255, 120, 172, 182),
        child: ListView(
          // padding: Padding,
          children: [
            ListTile(
              title: Text('SignBridge',
                style: TextStyle(color: Color.fromARGB(255, 254, 253, 241),
                    fontFamily: 'pacifico',
                    fontSize: 30),
              ),



            ),
            Divider(color: Colors.white24),

            SizedBox(height: 48),
            buildMenuItem( text:'Home',
              icon:Icons.home,

              onClicked:() => selectedItem(context,0) ,
            ),

            SizedBox(height: 16),
            buildMenuItem( text:'Profile',
                icon:Icons.account_circle,
                onClicked:() => selectedItem(context,1)
            ),
             SizedBox(height: 16),
            buildMenuItem( text:'language guide',
                icon:Icons.book,
                onClicked:() => selectedItem(context,2)
            ),
            Divider(color: Colors.white24),
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
    final color=Color.fromARGB(255, 254, 253, 241);
    final hoverColor=Colors.white70;
    return ListTile(
      leading:Icon(icon,color:color),
      title:Text(text,style: TextStyle(color: color,fontSize:20),),
      hoverColor: hoverColor,

      onTap: onClicked,


    );

  }

  selectedItem (BuildContext context,int index)  {
    switch(index){

      case 0:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHome(),
        ));
        break;
    case 1:
      read();
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Profile()));
    break;

    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Profile(),

      break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => LanguageGuide(),
        ));
        break;

    }
  }
read() async {
  var provider = Provider.of<UserProvider>(context, listen: false);                        provider.user = await DataBase.readUser(provider.firebaseUser?.uid ?? "") ;

  provider.user= await DataBase.readUser(provider.firebaseUser!.uid);
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

