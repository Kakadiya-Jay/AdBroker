import 'package:cloud_firestore/cloud_firestore.dart';

//Ignore this File

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  //saving the user Data in Collection
  Future savingUserData(
      String fullName, String email, String contact, String role) async {
    return await userCollection.doc(uid).set({
      "uid": uid,
      "name": fullName,
      "email": email,
      "contact": contact,
      "role": role,
      "profile_pic": "",
      "last_sign_in": DateTime.now(),
      "user_status_active": true,
    });
  }

  //getting the user Data from Collection
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }
}
