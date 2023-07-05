import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:sign_language_app/models/My_User.dart';

import '../datdbase/database_utils.dart';

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
      user = await DataBase.readUser(firebaseUser?.uid ?? "");
    }
  }
}
