
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider/flutter_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Provider/user_Provider.dart';
import '../../../datdbase/database_utils.dart';
import '../../../models/My_User.dart';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  User_Data? model;
File ? profileImage;
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    getUser();
    getEmailFromFirebase(email);
  }

  @override
  Widget build(BuildContext context) {
    // username.text=model!.fName;

    User? firebaseUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 85, 133, 145),
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'pacifico',
            fontSize: 25,
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 85, 133, 145),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 50.0),
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 80.0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 254, 253, 241),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 80.0),
                    Container(
                      padding: EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
                      child: Column(
                        children: [
                          StreamBuilder<DocumentSnapshot<User_Data>>(
                            stream: DataBase.readUserFromFirStoreStrem(firebaseUser!.uid),
                            builder: (
                                BuildContext context,
                                AsyncSnapshot<DocumentSnapshot<User_Data>> snapshot,
                                ) {
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }
                              if (!snapshot.hasData) {
                                return Text('No Data');
                              }
                              final DocumentSnapshot<User_Data> documentSnapshot = snapshot.data!;
                              if (!documentSnapshot.exists) {
                                return Text('Document does not exist');
                              }
                              final User_Data user = documentSnapshot.data()!;
                              return Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    color: Color.fromARGB(255, 120, 172, 182),
                                    size: 40,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Welcome ${user.fName}',
                                    style: TextStyle(color: Colors.black,fontSize: 20),
                                  ),
                                ],
                              );
                            },
                          ),
                            SizedBox(height: 20.0),
                            TextField(
                            controller: username,
                            decoration: InputDecoration(
                              labelText: 'Username',
                              prefixIcon: Icon(Icons.person),
                              border: myInputBorder(),
                              enabledBorder: myInputBorder(),
                              focusedBorder: myFocusBorder(),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          TextField(
                            controller: email,
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email),
                              border: myInputBorder(),
                              enabledBorder: myInputBorder(),
                              focusedBorder: myFocusBorder(),
                            ),
                          ),
                          SizedBox(height: 20.0),
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
                          SizedBox(height: 20.0),

                          ElevatedButton(
                            onPressed: () async {
                              UpdateName(username.text);
                              ClearForm();
                              User? firebaseUser = await FirebaseAuth.instance.currentUser;
                              firebaseUser?.updatePassword(password.text).then((_) {
                                print("Successfully changed password");
                              }).catchError((error) {
                                print("Password can't be changed" + error.toString());
                              });
                            },
                            child: Text('Update'),
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 85, 133, 145),
                              // padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                              fixedSize: Size(double.infinity, 50),
                              textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 180, // Set the desired height for the profile image
                  width: 180, // Set the desired width for the profile image
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: ClipOval(
                          child: StreamBuilder<DocumentSnapshot<User_Data>>(
                            stream: DataBase.readUserFromFirStoreStrem(firebaseUser!.uid),
                            builder: (
                                BuildContext context,
                                AsyncSnapshot<DocumentSnapshot<User_Data>> snapshot,
                                ) {
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }
                              if (!snapshot.hasData) {
                                return Text('No Data');
                              }
                              final DocumentSnapshot<User_Data> documentSnapshot = snapshot.data!;
                              if (!documentSnapshot.exists) {
                                return Text('Document does not exist');
                              }
                              final User_Data user = documentSnapshot.data()!;
                              return Image.network(
                                user.image ?? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        right: 15.5,
                        child: Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            shape: BoxShape.circle,
                          ),
                          child: InkWell(
                            onTap: () {
                              getProfileImage();
                              profileImageUpload();
                            },
                            child: Icon(
                              Icons.edit,
                              size: 30.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  OutlineInputBorder myInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Colors.black,
        width: 3,
      ),
    );
  }

  OutlineInputBorder myFocusBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Colors.cyan,
        width: 3,
      ),
    );
  }

  getUser() async {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('user')
        .doc(firebaseUser!.uid)
        .get()
        .then((value) {
      model = User_Data.fromJson(value.data()!);
      // Provider.of<UserProvider>(context).user=;
    });
  }

  void ChangePassword(String password) async {
    User? firebaseUser = await FirebaseAuth.instance.currentUser;
    firebaseUser?.updatePassword(password).then((_) {
      print("Successfully changed password");
    }).catchError((error) {
      print("Password can't be changed" + error.toString());
    });
  }
  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
    } else {
      print('No selected images');
    }
  }

  Future<void> profileImageUpload() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Handle the case when the user is not authenticated
      return;
    }

    final id = user.uid;
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final fileName = '$id-$timestamp.png';
    final ref = FirebaseStorage.instance.ref('$id/$fileName');

    // Assign the profileImage variable with the desired File object
    // profileImage = /* Provide the File object for the profile image */;

    try {
      await ref.putFile(profileImage!);
      final url = await ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection(User_Data.CollecationName) // Replace with your collection name
          .doc(id)
          .update({
        'image': url,
      });
    } catch (error) {
      // Handle the error appropriately
      print('Error uploading profile image: $error');
    }
  }


  void getEmailFromFirebase(email) async {
    User? firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      email.text = firebaseUser.email!;
      username.text = firebaseUser.displayName!;
    }
  }

  void UpdateName(username) async {
    User? firebaseUser = await FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection(User_Data.CollecationName)
        .doc(firebaseUser!.uid)
        .update({
      'fName': username.toString(),
    });
  }



  void ClearForm() {
    username.clear();
  }
}
