import 'dart:convert';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'navbar.dart';
import 'profile/image_view_screen.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);
  static const String roudeName='ff';

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  File? imageFile;
  String resultText = '';
  String? image_url;
  @override
  Widget build(BuildContext context) {
    var hight=MediaQuery.of(context).size.height;
    var wedith=MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 254, 253, 241) ,// page background


      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 85, 133, 145), // appbar color
        title: const Text('Home'
          , style: TextStyle(color: Colors.white,
              fontFamily: 'pacifico',
              fontSize: 25),
        ),
       ),
      body: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             (imageFile != null) ?
              Container(
                width: wedith*0.9,
                height: hight*0.6,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  image: DecorationImage(image: FileImage(imageFile!),fit: BoxFit.cover),
                  border: Border.all(width: 8,color: Colors.black12),
                  borderRadius: BorderRadius.circular(12.0),
                ),

              )
            :
              Padding(
                padding: const EdgeInsets.only(top:45),
                child: Container(
                  width: wedith*0.9,
                  height: hight*0.6,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 254, 253, 241), //color for inside box
                    border: Border.all(width: 8,color:Color.fromARGB(255, 120, 172, 182)), //color for frame
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                    child: Text('image should appear here',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 22,
                          color: Color.fromARGB(255, 53, 86,95 ).withOpacity(0.6) //color to text
                      ),
                    )
                ),
              ),
            Spacer(),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 85, 133, 145), // Background buttom color
                        ),
                        onPressed: () => captureImage(source: ImageSource.camera),
                        child: const Text('Capture',
                          style: TextStyle(color: Colors.white,
                              fontFamily: 'pacifico',
                              fontSize: 23),
                        )
                    )
                ),

                const SizedBox( width: 20,),


                Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 85, 133, 145), // Background button color
                        ),
                        onPressed: () => captureImage(source: ImageSource.gallery),
                        child: const Text('upload',
                          style: TextStyle(color: Colors.white,
                              fontFamily: 'pacifico',
                              fontSize: 23),
                        )
                    )
                ),

              ],
            ),
            const SizedBox(height: 20),
            Text(resultText),
            const SizedBox(height: 20),
            Visibility(

              visible: (image_url != null),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 85, 133, 145), // Background color
                  ),
                onPressed: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ImageViewScreen(imageUrl: image_url!))
                  );
                },
                child: Text("View result " ,
                         style: TextStyle(color: Colors.white,
                                fontFamily: 'pacifico',
                          fontSize: 23
                         ),
                       )),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> captureImage({required ImageSource source}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: source);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        resultText = 'Uploading image...';
      });

      uploadImage(imageFile!);
    }
  }

  Future<void> uploadImage(File imageFile) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(
          'http://graduation-asr.westeurope.cloudapp.azure.com'));
      print(1);
      request.files.add(
          await http.MultipartFile.fromPath('image', '${imageFile.path}'));

      //    var multipartFile=  await http.MultipartFile.fromPath('image', '${imageFile.path}');
      // print(2);
      // if (multipartFile != null) {
      //   request.files.add(multipartFile);
      //   print('File added to request.');
      // } else {
      //   setState(() {
      //     resultText = 'Error: Failed to add file to request.';
      //   });
      //   return;
      // }
      http.StreamedResponse response = await request.send();
      print(3);
      if (response.statusCode == 200) {
        var data = jsonDecode(await response.stream.bytesToString());
        setState(() {
          image_url = data['image'];
        });
      }
      else {
        setState(() {
          resultText = '${response.statusCode}';
        });
        print(response.reasonPhrase);
      }
    }catch(e)
    {
      setState(() {
        resultText = '${e}';
        print(4);
      });

    }
  }



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


