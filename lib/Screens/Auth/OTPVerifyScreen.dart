import 'dart:async';
import 'package:caffa/Screens/Home/home_screen.dart';
import 'package:caffa/Shared%20preferences/shared_preferences.dart';
import 'package:caffa/utils/helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

class OTPVerifyScreen extends StatefulWidget {
  String isVerified = '';
  String _contact = '${AppSettingsPreferences().phoneNumber}';
  String verificationID = '';

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<OTPVerifyScreen> with Helpers {
  // Future<void> verify() async {
  //   setState(() {
  //     state = 'loading';
  //   });
  //   var user = await FirebaseAuth.instance.currentUser;
  //   user!.sendEmailVerification().then((value) {
  //     showDialog(
  //         context: context,
  //         builder: (_) => AlertDialog(
  //               elevation: 24.0,
  //               title: const Text('من فضلك تفقد بريدك الإلكتروني'),
  //               content: const Text(
  //                   'تفقد بريدك الإلكتروني وأضغط على الرابط لتفعيل حسابك '),
  //               actions: [
  //                 CupertinoDialogAction(
  //                   child: const Text(
  //                     'Ok',
  //                     style: TextStyle(fontWeight: FontWeight.bold),
  //                   ),
  //                   onPressed: () {
  //                     setState(() {});
  //                     Navigator.pop(context);
  //                   },
  //                 ),
  //               ],
  //             ));
  //
  //     setState(() {
  //       state = 'success';
  //     });
  //     showSnackBar(
  //         context: context, message: 'Link sent Successfully', error: false);
  //     Timer.periodic(Duration(seconds: 1), (timer) async {
  //       (await FirebaseAuth.instance.currentUser)!..reload();
  //       print(FirebaseAuth.instance.currentUser!.emailVerified);
  //       // do something or call a function
  //       if (FirebaseAuth.instance.currentUser!.emailVerified == true) {
  //         Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(builder: (context) => HomeScreen()),
  //         );
  //         timer.cancel();
  //       }
  //     });
  //   }).catchError((onError) {
  //     setState(() {
  //       state = 'error';
  //     });
  //     showSnackBar(
  //         context: context,
  //         message: 'Registration failed. Please try again.',
  //         error: true);
  //   });
  // }

  var state;

  // //OTP Verification
  String smsOTP = '';

  // String verificationId = '';
  // String errorMessage = '';
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final _otpPinFieldKey = GlobalKey<OtpPinFieldState>();

  //
  // //this is method is used to initialize data
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   // Load data only once after screen load
  //   if (widget._isInit) {
  //     widget._contact = '${AppSettingsPreferences().phoneNumber}';
  //     generateOtp(widget._contact);
  //     widget._isInit = false;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    print(AppSettingsPreferences().id);
    print(AppSettingsPreferences().phoneNumber);
    print(AppSettingsPreferences().availableCups);

    verifyPhoneNumber(widget._contact);

    //Getting screen height width
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
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
                      textStyle: Theme.of(context).textTheme.headlineMedium,
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
                      ? Lottie.asset('assets/verifyEmail.json')
                      : Lottie.asset('assets/verify.json')),
            ),

            state == 'success'
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'أدخل 6 أرقام التي تم إرسالها إلى ${widget._contact} ',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: screenWidth * 0.025),
                        child: OtpPinField(
                          key: _otpPinFieldKey,
                          textInputAction: TextInputAction.done,
                          maxLength: 6,
                          fieldWidth: 40,
                          onSubmit: (text) {
                            smsOTP = text;
                          },
                          onChange: (text) {},
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      widget.isVerified == 'Loading'
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: () async {
                                signInWithOTP(smsOTP);
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
                    ],
                  )
                : SizedBox(
                    height: screenHeight * 0.02,
                  ),
          ],
        ),
      ),
    );
  }

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) async {
        // Save the verification ID somewhere
        widget.verificationID = await verificationId;
        widget.verificationID = verificationId;
        setState(() {
          state = 'success';
        });
        print('_verificationId');
        print(widget.verificationID);
        showSnackBar(
            context: context, message: 'تم إرسال الكود بنجاح', error: false);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> signInWithOTP(String smsCode) async {
    setState(() {
      widget.isVerified = 'Loading';
    });

    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      if (state == 'success') {
        if (smsOTP.isEmpty || smsOTP.length < 6) {
          showSnackBar(
              context: context,
              message: 'please enter 6 digit otp',
              error: true);
          setState(() {
            widget.isVerified = 'false';
          });
          return;
        } else {
          print('smsCode');
          print(smsCode.toString());
          print(widget.verificationID.toString());

          PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: widget.verificationID,
            smsCode: smsCode,
          );
          UserCredential userCredential =
              await auth.signInWithCredential(credential);
          User? user = userCredential.user;

          if (user!.uid != Null) {
            setState(() {
              widget.isVerified = 'true';
            });
            showSnackBar(
                context: context,
                message: 'تم تفعيل الحساب بنجاح',
                error: false);

            // change isVerified to True
            await FirebaseFirestore.instance
                .collection('users')
                .doc(AppSettingsPreferences().id)
                .update({
              'isVerified': true,
            });

            Get.to(() => HomeScreen());
          }
        }
      } else
        showSnackBar(
            context: context,
            message: 'من فضلك إنتظر حتى يتم إرسال الكود',
            error: true);
      setState(() {
        widget.isVerified = 'false';
      });
      // User is signed in
    } catch (e) {
      // Handle errors
      setState(() {
        widget.isVerified = 'false';
      });

      print('erorrrrrrrrrrrrr');
    }
  }
}
