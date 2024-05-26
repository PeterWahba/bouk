import 'dart:async';
import 'package:caffa/Screens/Home/home_screen.dart';
import 'package:caffa/Shared%20preferences/shared_preferences.dart';
import 'package:caffa/utils/helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class EmailVerifyScreen extends StatefulWidget {
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<EmailVerifyScreen> with Helpers {
  Future<void> verify() async {
    setState(() {
      state = 'loading';
    });
    var user = await FirebaseAuth.instance.currentUser;
    user!.sendEmailVerification().then((value) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                elevation: 24.0,
                title: const Text('من فضلك تفقد بريدك الإلكتروني'),
                content: const Text(
                    'تفقد بريدك الإلكتروني وأضغط على الرابط لتفعيل حسابك '),
                actions: [
                  CupertinoDialogAction(
                    child: const Text(
                      'Ok',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      setState(() {});
                      Navigator.pop(context);
                    },
                  ),
                ],
              ));

      setState(() {
        state = 'success';
      });
      showSnackBar(
          context: context, message: 'Link sent Successfully', error: false);
      Timer.periodic(Duration(seconds: 1), (timer) async {
        (await FirebaseAuth.instance.currentUser)!..reload();
        print(FirebaseAuth.instance.currentUser!.emailVerified);
        // do something or call a function
        if (FirebaseAuth.instance.currentUser!.emailVerified == true) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
          // change isVerified to True
          await FirebaseFirestore.instance
              .collection('users')
              .doc(AppSettingsPreferences().id)
              .update({
            'isVerified': true,
          });
          timer.cancel();
        }
      });
    }).catchError((onError) {
      setState(() {
        state = 'error';
      });
      showSnackBar(
          context: context,
          message: 'Registration failed. Please try again.',
          error: true);
    });
  }

  var state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text('تفعيل الحساب'),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: Colors.redAccent,
                    size: 35,
                  ),
                  Text(
                    'حسابك ليس مفعل',
                    style: GoogleFonts.lato(
                      color: Colors.redAccent,
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: Center(
                  child: state == 'success'
                      ? Lottie.asset('assets/verify.json')
                      : Lottie.asset('assets/verifyEmail.json')),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: ConditionalBuilder(
                  condition: state != 'loading',
                  builder: (context) => Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            verify();
                          },
                          child: Text(
                            "فعل حسابك",
                            style: GoogleFonts.almarai(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(318.w, 60.h),
                            backgroundColor: Color(0XFF2D005D),
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.r),
                            ),
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                  fallback: (context) => Center(
                        child: SpinKitFadingCircle(
                          color: Colors.blue,
                          size: 80.0,
                        ),
                      )),
            )
          ],
        ),
      ),
    );
  }
}
