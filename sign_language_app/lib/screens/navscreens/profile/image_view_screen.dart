import 'package:photo_view/photo_view.dart';
import 'package:flutter/material.dart';
class ImageViewScreen extends StatelessWidget {
  final String imageUrl;
  const ImageViewScreen({Key? key,required this.imageUrl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PhotoView(
        imageProvider: NetworkImage(
            imageUrl
        ),
        backgroundDecoration:const BoxDecoration(
            color: Colors.transparent
        ),
        enableRotation: true,
        errorBuilder: (context, object, stackTrace) =>
            const Icon(Icons.all_inclusive_rounded),
        loadingBuilder: (context, progress) =>
        const Center(
          child: SizedBox(
            width: 20.0,
            height: 20.0,
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
