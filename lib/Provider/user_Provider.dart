// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:sign_language_app/datdbase/database_utils.dart';
//
// import '../../Models/My_User.dart';
//
// class UserProvider extends ChangeNotifier {
//   User? firebaseUser;
//   User_Data user;
//
//   UserPrvider() {
//     initMyUser();
//   }
//
//   UserProvider() {
//     firebaseUser = FirebaseAuth.instance.currentUser;
//     initMyUser();
//   }
//
//   void initMyUser() async {
//     if (firebaseUser != null) {
//       user = await DataBase.readUser(firebaseUser?.uid ?? "");
//     }
//   }
// }
