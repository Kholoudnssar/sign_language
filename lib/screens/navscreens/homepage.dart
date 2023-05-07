import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class Myhome extends StatefulWidget {
  const Myhome({super.key});

  @override
  State<Myhome> createState() => _MyhomeState();
}

class _MyhomeState extends State<Myhome> {
   File? imageFile;
  
  get picker => null;
  _showOption(BuildContext context){
    return showDialog(context: context,
     builder: (context) => 
     AlertDialog(
      title: Text('make a choice '),
      content: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.image),
              title: Text('Gallery'),
              onTap:()=> _imageFromGallery(context),
            ),
            ListTile(
              leading: Icon(Icons.image),
              title: Text('Camera'),
              onTap:()=> _imageFromCamer(context),
            ),
          ],
        ),

      ),
     )
     
     );

  }
  Future _imageFromGallery(BuildContext context) async{
   var image = await picker.pickImage(source: ImageSource.gallery);
   setState(() {
     imageFile = image;
   });
   Navigator.pop(context);
  }
  Future _imageFromCamer(BuildContext context) async{
    var image = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      imageFile = image;
    });
    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 0.0,
        title:const Text('Interpreter'),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 30.0,
          fontWeight: FontWeight.w400,
        ),
        

        ),
        body: Center(
          child: imageFile!=null
          ?Image.file(imageFile!,width: 400,height: 400,)
          :Text('there is no image')

          
        ),
        floatingActionButton: FloatingActionButton(onPressed: () => _showOption(context),
        child: Icon(Icons.add_a_photo_outlined),
        
        ),
        
      );

  
  }
}