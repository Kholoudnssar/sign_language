import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/My_User.dart';

class DataBase {

  static CollectionReference<User_Data> getUserCollectin() {
    return FirebaseFirestore.instance
        .collection(User_Data.CollecationName)
        .withConverter(
        fromFirestore: (snapshot, _) => User_Data.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson());
  }

  static Future<void> creatDBforUser(User_Data user) {
    //To take same FirebaseAuth If Do not under stand go Register View model
    return getUserCollectin().doc(user.id).set(user);
  }

  static Future<User_Data> readUser(String uId) async {
    //Response Data For User By login ,take uId
    var userSnapshot = await getUserCollectin().doc(uId).get();
    return userSnapshot.data()!;
  }
}
