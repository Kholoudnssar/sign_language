import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  TextEditingController username= TextEditingController();
  TextEditingController email= TextEditingController();
  TextEditingController password= TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 85, 133, 145),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top:50.0),
        child: Stack(
        children:[
          Container(
            margin: EdgeInsets.only(top: 80.0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 254, 253, 241),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
              
              )
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 80.0,
                ),
      
                Container(
                  padding: EdgeInsets.only(top: 40.0,left: 20.0,right: 20.0),
                  child: Column(
                    children: [TextField(
                      controller: username,
                      decoration: InputDecoration(
                        labelText: 'username',
                        prefixIcon: Icon(Icons.person),
                        border: myInputBorder(),
                        enabledBorder: myInputBorder(),
                        focusedBorder: myFocusBorder(),
                
                      ),
                    ),
                    SizedBox(height: 20.0,),
                
                    TextField(
                      controller: email,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        border: myInputBorder(),
                        enabledBorder: myInputBorder(),
                        focusedBorder: myFocusBorder(),
                
                      ),
                    ),
                    SizedBox(height: 20.0,),
                
                    TextField(
                      controller: password,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.password),
                        border: myInputBorder(),
                        enabledBorder: myInputBorder(),
                        focusedBorder: myFocusBorder(),
                
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    ElevatedButton(onPressed: (){



                    },
                     child: Text('update'),
                     style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 85, 133, 145),
                      padding: EdgeInsets.symmetric(horizontal: 25.0,vertical: 20.0),
                      textStyle: TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold)
                     ),)
                
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
          alignment: Alignment.topCenter,
          child: Stack(
            children:  [
              ClipOval(
                child: Image.asset('assets/images/logo4.jpg',width: 150,height: 150,fit: BoxFit.cover,),
              ),
             Positioned(
              bottom: 5,
              right: 15.5,
               child: Container(
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Colors.blueGrey,shape: BoxShape.circle
                ),
                child: Icon(Icons.edit,size: 30.0 ,)),
             )
            ],
              
          ),
        ),
           ])),
      ), );
  }
  OutlineInputBorder myInputBorder(){
    return OutlineInputBorder(
      borderRadius:BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Colors.black,
        width: 3
      ) );
  }
  OutlineInputBorder myFocusBorder(){
    return OutlineInputBorder(
      borderRadius:BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Colors.cyan,
        width: 3
      ) );
  }

}

