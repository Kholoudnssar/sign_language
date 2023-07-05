import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class LanguageGuide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color.fromARGB(255, 120, 172, 182),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 85, 133, 145),
        title: const Text(
          'language Guide',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'pacifico',
            fontSize: 25,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(205, 30, 205, 10),
        child: PhotoView(
          imageProvider: AssetImage(
            'assets/images/guide.jpeg', // Replace with your image asset path
          ),
          backgroundDecoration: const BoxDecoration(color: Colors.transparent),
          enableRotation: true,
          errorBuilder: (context, error, stackTrace) => const Center(
            child: Text('Load failed!'),
          ),
          loadingBuilder: (context, progress) => const Center(
            child: CircularProgressIndicator(),
          ),
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2.0,
          initialScale: PhotoViewComputedScale.covered,
          basePosition: Alignment.center,
          // filterQuality: FilterQuality.medium,
          heroAttributes: PhotoViewHeroAttributes(tag: 'tag'),
        ),
      ),
    );
  }
}
