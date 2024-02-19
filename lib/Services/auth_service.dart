import 'package:ad_brokers/Helpers/helper_function.dart';
import 'package:ad_brokers/Services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  //login
  Future loginWithEmailandPassword(String email, String password) async {
    try {
      user = (await _auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (ex) {
      return ex.message;
    }
  }

  //Sign up

  Future registerWithEmailandPassword(String name, String email, String contact,
      String role, String password) async {
    try {
      user = (await _auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        await DatabaseService(uid: user!.uid)
            .savingUserData(name, email, contact, role);
        return true;
      }
    } on FirebaseAuthException catch (ex) {
      return ex.message;
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
      await _auth.signOut();
    } catch (ex) {
      return null;
    }
  }
}
