import 'package:flutter/material.dart';

class LanguageGuide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Language Guide'),
      ),
      body: Center(
        child: Image.asset(
          'assets/images/language_guide_image.jpg', // Replace with your image asset path
          width: 300,
          height: 300,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
