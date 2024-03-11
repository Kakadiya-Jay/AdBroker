import 'package:ad_brokers/Helpers/helper_function.dart';
import 'package:ad_brokers/Services/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  User? user;

  //login
  Future loginWithEmailandPassword(
      String email, String password, String userRole) async {
    try {
      user = (await _auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;

      if (user != null) {
        await _fireStore.collection(userRole).doc(user!.uid).update(
          {
            "last_sign_in": DateTime.now(),
            "user_status_active": true,
          },
        );
        return true;
      }
    } on FirebaseAuthException catch (ex) {
      return ex.message;
    } on FormatException catch (ex) {
      return ex.message;
    } on PlatformException catch (ex) {
      return ex.message;
    } catch (ex) {
      return ex.toString();
    }
  }

  //Sign up
  Future registerWithEmailandPassword(String name, String email, String contact,
      String role, String password) async {
    try {
      user = (await _auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;

      if (user != null) {
        await DatabaseService(uid: user!.uid, userRole: role)
            .savingUserData(name, email, contact);
        return true;
      }
    } on FirebaseAuthException catch (ex) {
      return ex.message;
    } on FormatException catch (ex) {
      return ex.message;
    } on PlatformException catch (ex) {
      return ex.message;
    } catch (ex) {
      return ex.toString();
    }
  }

  //Forgot Password
  Future forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      // _auth.confirmPasswordReset(code: code, newPassword: newPassword)
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

  //log out
  Future signOut() async {
    try {
      await HelperFunctions.saveUserLoggedInStatus(false);
      await HelperFunctions.saveUserNameSF("");
      await HelperFunctions.saveUserEmailSF("");
      await HelperFunctions.saveUserContactSF("");
      await HelperFunctions.saveUserRoleSF("");
      await HelperFunctions.saveAdvBrandNameSF("");
      await HelperFunctions.saveAdvBrandURLSF("");
      await HelperFunctions.saveUserImageURLSF("");
      await _auth.signOut();
    } catch (ex) {
      return ex.toString();
    }
  }
}
