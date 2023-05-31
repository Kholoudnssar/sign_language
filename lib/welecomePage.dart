import 'package:flutter/material.dart';
import 'package:sign_language_app/login_page.dart';

class WelcomePage extends StatelessWidget {
  static const String roudeName='kk';
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Stack(children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.6,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),

              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.6,
                decoration: BoxDecoration(
                  color: Colors.blue[300],
                  borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(70)),
                ),
                child: Center(
                  child: Image.asset('assets/images/logo3.jpg',width: 400,height:400,scale: 0.8,),



                ),


              )
            ],

            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.666,
                decoration: BoxDecoration(
                    color: Colors.blue[300]
                ),

              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.666,
                padding: EdgeInsets.only(top: 40,bottom: 0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(70))
                ),
                child: Column(
                  children: [
                    Text('welcome to SignBridge',
                      style: TextStyle(fontSize:25,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Parisienne' ),
                    ),
                    SizedBox(height: 10),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Text('This application presents how to learn Arabic Alphabet Sign Language (ArSL). It can provide an opportunity to communicate with deaf or dumb people.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black.withOpacity(0.6)
                          ),
                        )
                    ),
                    SizedBox(height: 10),
                    Material(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>LoginPage() ,

                          ),);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 80
                          ),
                          child: Text(
                            'Get Start',
                            style: TextStyle(color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1),
                          ),
                        ),
                      ),
                    )

                  ],

                ),

              ),
            )
          ],
        ),
      ),
    );
  }
}