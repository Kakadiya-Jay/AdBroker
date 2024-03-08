import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

//Ignore this File

class DatabaseService {
  final String uid;
  final String? userRole;

  DatabaseService({required this.uid, this.userRole});

  //Creating Collection References
  final CollectionReference advertisersCollection =
      FirebaseFirestore.instance.collection("Advertisers");
  final CollectionReference publishersCollection =
      FirebaseFirestore.instance.collection("Publishers");

  //saving the user Data in Collection
  Future savingUserData(String fullName, String email, String contact) async {
    if (userRole == "Advertisers") {
      return await advertisersCollection.doc(uid).set({
        "uid": uid,
        "name": fullName,
        "email": email,
        "contact": contact,
        "role": userRole,
        "profile_pic": "",
        "last_sign_in": DateTime.now(),
        "user_status_active": true,
      });
    } else {
      return await publishersCollection.doc(uid).set({
        "uid": uid,
        "name": fullName,
        "email": email,
        "contact": contact,
        "role": userRole,
        "profile_pic": "",
        "last_sign_in": DateTime.now(),
        "user_status_active": true,
      });
    }
  }

  //getting the user Data from Collection
  Future gettingAdvertisersData(String email) async {
    QuerySnapshot snapshot =
        await advertisersCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  Future gettingPublishersData(String email) async {
    QuerySnapshot snapshot =
        await publishersCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  //update user data inside the collection
  Future updateAdvertiserProfile(
      String username, String email, String contact, String imageUrl) async {
    try {
      await advertisersCollection.doc(uid).update(
        {
          "name": username,
          "email": email,
          "contact": contact,
          "profile_pic": imageUrl.toString(),
        },
      );
      return true;
    } on FirebaseAuthException catch (ex) {
      return ex.message.toString();
    } on FormatException catch (ex) {
      return ex.message.toString();
    } on PlatformException catch (ex) {
      return ex.message.toString();
    } catch (ex) {
      return ex.toString();
    }
  }
}
