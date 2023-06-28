import 'package:flutter/material.dart';

class CustomButon extends StatelessWidget {
  CustomButon({ this.onTap ,required this.text}) ;
  VoidCallback? onTap;
  String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ,
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 85, 133, 145),
          borderRadius: BorderRadius.circular(8),
        ),
        width: double.infinity,
        height: 60,
        child: Center(
          child: Text(text,
            style: TextStyle(color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 1),),

        ),
      ),
    );
  }
}
