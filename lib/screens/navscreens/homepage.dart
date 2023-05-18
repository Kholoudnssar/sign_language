import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'profile/image_view_screen.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  File? imageFile;
  String resultText = '';
  String? image_url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('INTERPRETER'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imageFile != null)
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(imageFile!),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            else
              const Icon(Icons.image, size: 150),
            ElevatedButton(
              onPressed: () {
                captureImage();
              },
              child: const Text('Capture Image'),
            ),
            const SizedBox(height: 20),
            Text(resultText),
            const SizedBox(height: 20),
            Visibility(

              visible: (image_url != null),
              child: ElevatedButton(
                onPressed: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ImageViewScreen(imageUrl: image_url!))
                  );
                },
                child: Text("View Image Screen"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> captureImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        resultText = 'Uploading image...';
      });

       uploadImage(imageFile!);
    }
  }

  Future<void> uploadImage(File imageFile) async {
    var request = http.MultipartRequest('POST', Uri.parse('http://graduation-asr.westeurope.cloudapp.azure.com:8000/'));
    print(1);
    request.files.add(await http.MultipartFile.fromPath('image', '${imageFile.path}'));
    print(2);
    http.StreamedResponse response = await request.send();
    print(3);
    if (response.statusCode == 200) {
      var data = jsonDecode(await response.stream.bytesToString());
      setState(() {
        image_url = data['image'];
      });

      // download image
      // http.Response response = await http.get(Uri.parse(image_url));

      // Create a file with the provided save path
      // String savePath = (await getExternalStorageDirectory()).path + '/image.jpg';
      // File imageFile = File(savePath);

      // Write the image data to the file
      // await imageFile.writeAsBytes(response.bodyBytes);

      // Show a success message or perform any further operations

      // List<int> bytes = response.bodyBytes;
      // await imageFile.writeAsBytes(bytes);
    }
    else {
      print(response.reasonPhrase);
    }
  }
}
