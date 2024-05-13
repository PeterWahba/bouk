import 'dart:async';
import 'dart:io';
import 'package:caffa/Screens/Auth/verifyScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../Models/User.dart';
import '../Screens/Auth/auth_screen.dart';
import '../Shared preferences/shared_preferences.dart';
import '../utils/helpers.dart';

typedef UserAuthStatus = void Function({required bool loggedIn});

class FbAuthController with Helpers {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool> signIn(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        if (userCredential.user!.emailVerified) {
          // Step 1: Fetch user data from Firestore
          DocumentSnapshot userDataSnapshot = await FirebaseFirestore.instance
              .collection('users')
              .doc(userCredential.user!.uid)
              .get();
          Map<String, dynamic> userData =
              userDataSnapshot.data() as Map<String, dynamic>;
          UserData user = UserData.fromMap(userData);
          user.id = userCredential.user!.uid;
          print(user.id);
          AppSettingsPreferences().saveUser(user: user);
          return true;
        } else {
          // await signOut();
          showSnackBar(
              context: context,
              message: 'Verity email to login into the app!',
              error: true);
          return false;
        }
      }
      return false;
    } on FirebaseAuthException catch (e) {
      _controlException(context, e);
    } catch (e) {}
    return false;
  }

  bool loggedIn() => _firebaseAuth.currentUser != null;

  StreamSubscription<User?> checkUserStatus(UserAuthStatus userAuthStatus) {
    return _firebaseAuth.authStateChanges().listen((event) {
      userAuthStatus(loggedIn: event != null);
    });
  }

  void _controlException(
      BuildContext context, FirebaseAuthException exception) {
    showSnackBar(
        context: context, message: exception.message ?? 'Error!', error: true);
    switch (exception.code) {
      case 'invalid-email':
        break;
      case 'user-disabled':
        break;
      case 'user-not-found':
        break;
      case 'wrong-password':
        break;
    }
  }

  Future<String> _uploadImageToStorage(String userId, File? _image) async {
    try {
      String fileName =
          'profile_images/$userId.png'; // Unique path for each user's image
      final firebase_storage.Reference storageReference =
          firebase_storage.FirebaseStorage.instance.ref(fileName);

      // Upload the file to Firebase Storage
      await storageReference.putFile(_image!);

      // Get the download URL for the uploaded file
      String downloadURL = await storageReference.getDownloadURL();

      return downloadURL;
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }

  Future<bool> createAccount(
    File? _image, {
    required BuildContext context,
    required String name,
    required String email,
    required String phone,
    required String company_name,
    required String password,
    required String token,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      userCredential.user?.sendEmailVerification();
      String imageURL =
          await _uploadImageToStorage(userCredential.user!.uid, _image);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'name': name,
        'availableCups': 0,
        'email': email,
        'phone': phone,
        'company_name': company_name,
        'password': password,
        'imageURL': imageURL,
        'token': token,
        'userType': 'client',
      });

      Map<String, dynamic> userdata = {
        "id": userCredential.user!.uid,
        "name": name,
        "phone": phone,
        'availableCups': 0,
        "imageURL": imageURL,
        "email": email,
        "companyName": company_name,
        'token': token,
        'userType': 'client',

      };

      UserData userData = UserData.fromMap(userdata);

      AppSettingsPreferences().saveUser(user: userData);

      return true;
    } on FirebaseAuthException catch (e) {
      _controlException(context, e);
    } catch (e) {}
    return false;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await AppSettingsPreferences().updateLoggedIn();
    Get.off(AuthScreen());
  }

  Future<bool> forgetPassword(
      {required BuildContext context,
        required String email}) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email)
          .then((value) {
        showSnackBar(
            context: context,
            message: 'تم إرسال رسالة إعادة التعيين بنجاح على حسابك',
            error: false);
        return true;
      })
          .catchError((onError) {
        showSnackBar(
            context: context,
            message: 'خطأ ! أعد المحاوله مره أخرى',
            error: true);
        return false;
      });
    } on FirebaseAuthException catch (e) {
      _controlException(context, e);
    } catch (e) {}
    return false;
  }

}
