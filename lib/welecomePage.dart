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
                  color: Color.fromARGB(255, 254, 253, 241),  //Background color to paragraph
                ),

              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.6,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 120, 172, 182), //frame color to image
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
                    color: Color.fromARGB(255, 120, 172, 182) //frame color to image
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
                    color: Color.fromARGB(255, 254, 253, 241), //Background color to paragraph
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(70))
                ),
                child: Column(
                  children: [
                    Text('Welcome to SignBridge',
                      style: TextStyle(fontSize:25,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 53, 86,95 ).withOpacity(0.6), //color to text
                          fontFamily: 'pacifico' ),
                    ),
                    SizedBox(height: 10),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Text('This application presents how to learn Arabic Alphabet Sign Language (ArSL). It can provide an opportunity to communicate with deaf or dumb people.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 53, 86,95 ).withOpacity(0.6) //color to text
                          ),
                        )
                    ),
                    SizedBox(height: 10),
                    Material(
                      color: Color.fromARGB(255, 85, 133, 145), //color for buttom
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