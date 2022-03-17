import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

/*
AuthenticationService class is used for verification and authentication of the
user credentials such as email and graphical password.
This service class contains functions - verifyAndUpdateUserEmail, signIn, 
signUp.
*/

class AuthenticationService extends ChangeNotifier {
  final FirebaseFirestore _firestoreReference = FirebaseFirestore.instance;
  User? currentUser = FirebaseAuth.instance.currentUser;
  bool? emailVerified = false;
  bool? signedIn = false;

  /*
  This function will provide email verification(OTP), and will update the user
  email. Also notifies the listeners if the email is verified.
  */
  Future<void> verifyAndUpdateUserEmail(
      BuildContext context, String? newEmail) async {
    await currentUser?.verifyBeforeUpdateEmail(newEmail!);
    await currentUser?.reload();

    if (currentUser!.emailVerified) {
      emailVerified = true;
      notifyListeners();
    }
  }

  /*
  This function is used to signup the user. It takes a list of image urls as
  input.
  */
  Future<void> signUp(List<String?> password) async {
    final email = currentUser?.email;

    try {
      _firestoreReference.collection("users").doc(email).set({
        email!: password,
      });
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /*
  This function is used to signin the user. It takes the user email and a list
  of image urls as input.
  */
  Future<void> signIn(String? email, List<String?> password) async {
    var snapshot =
        await _firestoreReference.collection("users").doc(email).get();
    List<String?> originalPassword = snapshot.data()![email];
    int counter = 0;
    for (String? url in originalPassword) {
      if (counter == 3) {
        signedIn = true;
        notifyListeners();
        break;
      } else if (password.contains(url)) {
        counter++;
      } else {}
    }
    if (counter < 3) {
      signedIn = false;
      notifyListeners();
    }
  }
}
