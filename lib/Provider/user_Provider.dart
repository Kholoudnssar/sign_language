import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:sign_language_app/datdbase/database_utils.dart';

import '../../Models/My_User.dart';

class UserProvider extends ChangeNotifier {
  User? firebaseUser;
  User_Data? user;

  UserPrvider() {
    initMyUser();
  }

  UserProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    initMyUser();
  }

  void initMyUser() async {
    if (firebaseUser != null) {
      User? firebaseUser = await FirebaseAuth.instance.currentUser;
        await FirebaseFirestore.instance
            .collection(User_Data.CollecationName)
            .doc(firebaseUser!.uid)
            .get()
            .then((value) {
          user = User_Data.fromJson(value.data()!);
        }).catchError((error) {
          print(error.toString());
        });
      }

  }
}
