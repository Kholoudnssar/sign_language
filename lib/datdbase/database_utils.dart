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


  static Stream<DocumentSnapshot<User_Data>> readUserFromFirStoreStrem(
      String uId) {
    return getUserCollectin().doc(uId).snapshots();
  }

  // static Future<void> deleteImage(
  //     {required String imageUrl, required String userId}) async {
  //   // Delete image from Firebase Storage
  //   final storageRef = FirebaseStorage.instance.refFromURL(imageUrl);
  //   storageRef.delete();
  // }

  // static Future<void> updateImagesForDelete(
  //     {required int index, required String userId}) async {
  //   final userRef = getUserCollectin().doc(userId);
  //
  //
  //   await userRef.update({
  //     'listimageurl': [index].removeAt(index),
  //   });
  // }

  // FieldValue.arrayRemove([imageUrl]
  static Future<void> UpdateUser(
      {required String userId, required String newName}) async {
    getUserCollectin().doc(userId).update({'fName': newName});
  }




}
