import 'dart:async';

import 'package:caffa/Screens/Auth/auth_screen.dart';
import 'package:caffa/Screens/Auth/emaiVerifyScreen.dart';
import 'package:caffa/Screens/Home/home_screen.dart';
import 'package:caffa/Screens/Home_store/home_store_screen.dart';
import 'package:caffa/Screens/dashboard/dashboard_screen.dart';
import 'package:caffa/Shared%20preferences/shared_preferences.dart';
import 'package:caffa/fb-controllers/fb_auth_controller.dart';
import 'package:caffa/utils/custom_themes.dart';
import 'package:caffa/utils/helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'OTPVerifyScreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with Helpers {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  late StreamSubscription stream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _registerUser(BuildContext context) async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    print(_phoneController.text);
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 80.0,
              ),
            );
          },
        );
        // Create the user with email and password
        final UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // After sending OTP, save user data in Firestore
        final User? user = userCredential.user;
        if (user != null) {
          await _firestore.collection('users').doc(user.uid).set({
            'phoneNumber': _phoneController.text,
            'name': _nameController.text,
            'email': _emailController.text,
            'password': _passwordController.text,
            'id': user.uid,
            'availableCups': 0,
            'isVerified': false,
            'userType': 'client',

            // Add any other user data you want to save
          });
          login().then((value) {
            _nameController.text = '';
            _emailController.text = '';
            _phoneController.text = '';
            _passwordController.text = '';
          });
          showSnackBar(
              context: context,
              message: 'Registration ٍSuccessfully.',
              error: false);
        }
      } catch (e) {
        showSnackBar(
            context: context,
            message: 'Registration failed. Please try again.',
            error: true);
      } finally {
        // Close the dialog when done
        Navigator.of(context).pop();
      }
    } else {
      // Handle empty email or password case
      print('Error: Email or password is empty');
      showSnackBar(
          context: context,
          message: 'Please enter valid email and password.',
          error: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0XFF2D005D),
              Color(0xFF7B1FA2),
            ],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60.h,
                ),
                Text(
                  "مرحبا بك في  Bouk",
                  style: titilliumRegular.copyWith(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                // SizedBox(
                //   height: 12.h,
                // ),
                // Padding(
                //   padding: EdgeInsets.only(right: 35.w, left: 32.w),
                //   child: Text(
                //     "رفيقك في المقهى الرقمي. اكتشف واستبدل واستمتع بتجارب القهوة الخالية من المتاعب.",
                //     style: titilliumRegular.copyWith(
                //       fontSize: 14.sp,
                //       color: Color(0XFFBCBCBC),
                //     ),
                //     textAlign: TextAlign.center,
                //   ),
                // ),
                SizedBox(
                  height: 50.h,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 28.w),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "قم بالتسجيل في حسابك الجديد",
                      style: titilliumRegular.copyWith(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
                SizedBox(
                  height: 26.h,
                ),
                // Padding(
                //   padding: EdgeInsets.only(right: 28.w),
                //   child: Align(
                //     alignment: Alignment.centerRight,
                //     child: Text(
                //       "الإسم الكامل",
                //       style: titilliumRegular.copyWith(
                //         fontSize: 16.sp,
                //         fontWeight: FontWeight.bold,
                //         color: Colors.white,
                //       ),
                //       textAlign: TextAlign.right,
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 11.h,
                // ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    maxLines: 1,
                    cursorHeight: 25.h,
                    textDirection: TextDirection.ltr,
                    style: titilliumRegular.copyWith(color: Colors.white),
                    controller: _nameController,
                    decoration: InputDecoration(
                      prefixIcon: SvgPicture.asset(
                        "assets/Frame 1 (3).svg",
                        color: Colors.white,
                        width: 24.w,
                        height: 24.h,
                        fit: BoxFit.scaleDown,
                      ),
                      contentPadding: const EdgeInsets.all(8),
                      counterText: "",
                      labelText: "الإسم الكامل",
                      labelStyle: titilliumRegular.copyWith(
                          color: Colors.white, fontSize: 14.sp),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,

                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0XFFE3E3CE),
                        ),
                      ),
                      // focusColor: Color(0XFF22A45D),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0XFFE3E3CE),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 19.h,
                ),
                // Padding(
                //   padding: EdgeInsets.only(right: 28.w),
                //   child: Align(
                //     alignment: Alignment.centerRight,
                //     child: Text(
                //       "الإيميل الإلكتروني",
                //       style: titilliumRegular.copyWith(
                //         fontSize: 16.sp,
                //         fontWeight: FontWeight.bold,
                //         color: Colors.white,
                //       ),
                //       textAlign: TextAlign.right,
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 11.h,
                // ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    maxLines: 1,
                    cursorHeight: 25.h,
                    textDirection: TextDirection.ltr,
                    style: titilliumRegular.copyWith(color: Colors.white),
                    controller: _emailController,
                    decoration: InputDecoration(
                      prefixIcon: SvgPicture.asset(
                        "assets/Frame 1 (1).svg",
                        color: Colors.white,
                        width: 24.w,
                        height: 24.h,
                        fit: BoxFit.scaleDown,
                      ),
                      contentPadding: const EdgeInsets.all(10),
                      counterText: "",
                      labelText: "الإيميل الإلكتروني",
                      labelStyle: titilliumRegular.copyWith(
                          color: Colors.white, fontSize: 14.sp),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,

                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0XFFE3E3CE),
                        ),
                      ),
                      // focusColor: Color(0XFF22A45D),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0XFFE3E3CE),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 19.h,
                ),
                // Padding(
                //   padding: EdgeInsets.only(right: 28.w),
                //   child: Align(
                //     alignment: Alignment.centerRight,
                //     child: Text(
                //       "رقم الهاتف",
                //       style: titilliumRegular.copyWith(
                //         fontSize: 16.sp,
                //         fontWeight: FontWeight.bold,
                //         color: Colors.white,
                //       ),
                //       textAlign: TextAlign.right,
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 11.h,
                // ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    maxLines: 1,
                    cursorHeight: 25.h,
                    textDirection: TextDirection.ltr,
                    style: titilliumRegular.copyWith(color: Colors.white),
                    controller: _phoneController,
                    decoration: InputDecoration(
                      prefixIcon: SvgPicture.asset(
                        "assets/Frame 1 (4).svg",
                        color: Colors.white,
                        width: 24.w,
                        height: 24.h,
                        fit: BoxFit.scaleDown,
                      ),
                      contentPadding: const EdgeInsets.all(10),
                      counterText: "",
                      labelText: "رقم الهاتف +966",
                      labelStyle: titilliumRegular.copyWith(
                          color: Colors.white, fontSize: 14.sp),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0XFFE3E3CE),
                        ),
                      ),
                      // focusColor: Color(0XFF22A45D),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0XFFE3E3CE),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 19.h,
                ),
                // Padding(
                //   padding: EdgeInsets.only(right: 28.w),
                //   child: Align(
                //     alignment: Alignment.centerRight,
                //     child: Text(
                //       "كلمة السر",
                //       style: titilliumRegular.copyWith(
                //         fontSize: 16.sp,
                //         fontWeight: FontWeight.bold,
                //         color: Colors.white,
                //       ),
                //       textAlign: TextAlign.right,
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 11.h,
                // ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    maxLines: 1,
                    cursorHeight: 25.h,
                    textDirection: TextDirection.ltr,
                    style: titilliumRegular.copyWith(color: Colors.white),
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: SvgPicture.asset(
                        "assets/Frame 1 (2).svg",
                        color: Colors.white,
                        width: 24.w,
                        height: 24.h,
                        fit: BoxFit.scaleDown,
                      ),
                      contentPadding: const EdgeInsets.all(10),
                      counterText: "",
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      labelText: "كلمة السر",
                      labelStyle: titilliumRegular.copyWith(
                          color: Colors.white, fontSize: 14.sp),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0XFFE3E3CE),
                        ),
                      ),
                      // focusColor: Color(0XFF22A45D),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0XFFE3E3CE),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 33.h,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_nameController.text.isNotEmpty &&
                        _emailController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty
                        // _phoneController.text.isNotEmpty
                    ) {
                      // showDialog(
                      //   context: context,
                      //   builder: (context) {
                      //     return Center(
                      //       child: SpinKitFadingCircle(
                      //         color: Colors.blue,
                      //         size: 80.0,
                      //       ),
                      //     );
                      //   },
                      // );

                      _registerUser(context);
                      // Get.back();
                    } else {
                      showSnackBar(
                          context: context,
                          message: "أدخل البيانات المطلوبة",
                          error: true);
                    }
                  },
                  child: Text(
                    "إنشاء حساب",
                    style: titilliumRegular.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(318.w, 60.h),
                    backgroundColor: Colors.white,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    alignment: Alignment.center,
                  ),
                ),
                SizedBox(
                  height: 18.h,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Container(
                //       height: 1.h,
                //       width: 93.w,
                //       color: Color(0XFFD9D9BC),
                //     ),
                //     SizedBox(
                //       width: 23.w,
                //     ),
                //     Text(
                //       "أو الاستمرار مع",
                //       style: titilliumRegular.copyWith(
                //         fontSize: 14.sp,
                //         fontWeight: FontWeight.bold,
                //         color: Color(0XFFBCBCBC),
                //       ),
                //     ),
                //     SizedBox(
                //       width: 23.w,
                //     ),
                //     Container(
                //       height: 1.h,
                //       width: 93.w,
                //       color: Color(0XFFD9D9BC),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: 18.h,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Container(
                //       height: 35.h,
                //       width: 100.w,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(53.r),
                //         border: Border.all(
                //           color: Color(0XFFEDEDED),
                //         ),
                //       ),
                //       child: Center(
                //         child: Image.asset(
                //           "assets/Rectangle 9 (2).png",
                //           width: 25.w,
                //           height: 25.h,
                //           fit: BoxFit.scaleDown,
                //         ),
                //       ),
                //     ),
                //     SizedBox(
                //       width: 23.w,
                //     ),
                //     Container(
                //       height: 35.h,
                //       width: 100.w,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(53.r),
                //         border: Border.all(
                //           color: Color(0XFFEDEDED),
                //         ),
                //       ),
                //       child: Center(
                //         child: Image.asset(
                //           "assets/Rectangle 9.png",
                //           width: 25.w,
                //           height: 25.h,
                //           fit: BoxFit.scaleDown,
                //         ),
                //       ),
                //     ),
                //     SizedBox(
                //       width: 23.w,
                //     ),
                //     Container(
                //       height: 35.h,
                //       width: 100.w,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(53.r),
                //         border: Border.all(
                //           color: Color(0XFFEDEDED),
                //         ),
                //       ),
                //       child: Center(
                //         child: Image.asset(
                //           "assets/Rectangle 9 (3).png",
                //           width: 25.w,
                //           height: 25.h,
                //           fit: BoxFit.scaleDown,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: 25.h,
                // ),
                InkWell(
                  onTap: () {
                    Get.to(() => AuthScreen(),
                        transition: Transition.circularReveal);
                  },
                  child: RichText(
                    text: TextSpan(
                      style: titilliumRegular.copyWith(
                          fontSize: 18.sp, color: Colors.white),
                      children: <TextSpan>[
                        TextSpan(
                          text: "هل لديك حساب؟",
                          style: titilliumRegular.copyWith(
                            fontSize: 14.sp,
                            color: Color(0XFFBCBCBC),
                          ),
                        ),
                        TextSpan(
                          text: " تسجيل الدخول",
                          style: titilliumRegular.copyWith(
                            fontSize: 14.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    bool status = await FbAuthController().signIn(
        context: context,
        email: _emailController.text,
        password: _passwordController.text);
    print(status);
    if (status && AppSettingsPreferences().isVerified) {
      stream = FbAuthController().checkUserStatus(({required bool loggedIn}) {
        loggedIn
            ? Get.off(() => DashBoardScreen(), transition: Transition.cupertino)
            : Get.to(() => AuthScreen());
      });
    } else if (status && !AppSettingsPreferences().isVerified) {
      Get.to(() => EmailVerifyScreen());
    } else {
      showSnackBar(
          context: context, message: 'خطأ ! برجاء أعد المحاوله', error: true);
    }
  }
}
