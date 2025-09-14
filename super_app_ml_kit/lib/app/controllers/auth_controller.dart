import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../routes/app_pages.dart';

// class AuthController extends GetxController {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   Rxn<User> user = Rxn<User>();
//
//   @override
//   void onInit() {
//     super.onInit();
//     user.bindStream(_auth.authStateChanges());
//   }
//
//   bool isLoggedIn() => user.value != null;
//
//   Future<void> signIn(String email, String password) async {
//     try {
//       await _auth.signInWithEmailAndPassword(email: email, password: password);
//     } catch (e) {
//       Get.snackbar("Error", e.toString());
//     }
//   }
//
//   Future<void> signUp(String email, String password) async {
//     try {
//       await _auth.createUserWithEmailAndPassword(email: email, password: password);
//     } catch (e) {
//       Get.snackbar("Error", e.toString());
//     }
//   }
//
//   Future<void> signOut() async {
//     await _auth.signOut();
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_app_ml_kit/app/routes/app_pages.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User?> firebaseUser = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(_auth.authStateChanges()); // Listen auth changes
    ever(firebaseUser, _setInitialScreen); // Redirect when user changes
  }

  _setInitialScreen(User? user) async {
    final prefs = await SharedPreferences.getInstance();

    if (user == null) {
      // User NOT logged in
      prefs.remove("uid");
      Get.offAllNamed(Routes.SIGNIN);
    } else {
      // User logged in
      prefs.setString("uid", user.uid);
      Get.offAllNamed(Routes.HOME);
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await _auth.signOut();
    prefs.remove("uid");
  }
}

