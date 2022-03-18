import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

/*
AuthenticationService class is used for verification and authentication of the
user credentials such as email and graphical password.
This service class contains functions - verifyAndUpdateUserEmail, signIn, 
signUp.
*/

class AuthenticationService extends ChangeNotifier {
  final FirebaseFirestore _firestoreReference = FirebaseFirestore.instance;
  User? currentUser;
  String? userEmail;
  bool emailVerified = false;
  bool signedIn = false;

  Future<void> createUser(String? email) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email!, password: "LenovoG570!");
      userEmail = email;
      currentUser = FirebaseAuth.instance.currentUser;
      await currentUser?.sendEmailVerification();
      await currentUser?.reload();
      debugPrint("Email verification sent!");
    } catch (signUpError) {
      debugPrint(signUpError.toString());
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: "LenovoG570!");
      debugPrint("signed in");
    }
  }

  /*
  This function notifies the listeners if the email is verified.
  */
  Future<bool> isVerified() async {
    currentUser = FirebaseAuth.instance.currentUser;
    await currentUser?.reload();
    emailVerified = currentUser!.emailVerified;
    notifyListeners();
    return currentUser!.emailVerified;
  }

  /*
  This function is used to signup the user. It takes a list of image urls as
  input.
  */
  Future<void> signUp(List<String?> password) async {
    try {
      _firestoreReference.collection("users").doc(userEmail).set({
        userEmail!: password,
      });
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  bool isSignedIn() {
    return signedIn;
  }

  /*
  This function is used to signin the user. It takes the user email and a list
  of image urls as input.
  */
  Future<void> signIn(String? email, List<String?> password) async {
    try {
      var snapshot =
          await _firestoreReference.collection("users").doc(email).get();
      List<String?> originalPassword = [];
      snapshot.data()!.forEach((key, value) {
        for (dynamic url in value) {
          originalPassword.add(url.toString());
        }
      });
      int counter = 0;
      for (String? url in originalPassword) {
        if (counter == 3) {
          signedIn = true;
          debugPrint("Signed In successfully");
          notifyListeners();
          break;
        } else if (password.contains(url)) {
          counter++;
        } else {}
      }
      if (counter < 3) {
        signedIn = false;
        debugPrint("Wrong password");
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      debugPrint("Signed out");
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
