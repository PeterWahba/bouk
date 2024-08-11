import 'dart:async';

import 'package:caffa/Screens/Auth/register_screen.dart';
import 'package:caffa/Screens/Auth/reset_pass_screen.dart';
import 'package:caffa/Screens/Auth/emaiVerifyScreen.dart';
import 'package:caffa/Screens/Coffee/Auth/register_screen.dart';
import 'package:caffa/Screens/Home_store/home_store_screen.dart';
import 'package:caffa/Screens/SuperAdmin/suber_admin_screen.dart';
import 'package:caffa/Screens/dashboard/dashboard_screen.dart';
import 'package:caffa/Shared%20preferences/shared_preferences.dart';
import 'package:caffa/utils/custom_themes.dart';
import 'package:caffa/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../fb-controllers/fb_auth_controller.dart';
import '../Coffee/Auth/auth_screen.dart';
import '../Home/home_screen.dart';
import 'OTPVerifyScreen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with Helpers {
  late StreamSubscription stream;
  late TextEditingController _emailcontroller;
  late TextEditingController _passwordcontroller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailcontroller = TextEditingController();
    _passwordcontroller = TextEditingController();
  }

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
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
                  height: 100.h,
                ),
                Text(
                  " مرحباً بك ",
                  style: titilliumRegular.copyWith(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 35.w, left: 32.w),
                  child: Image.asset('assets/boukLogo.png'),
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
                // SizedBox(
                //   height: 20.h,
                // ),
                // Padding(
                //   padding: EdgeInsets.only(right: 28.w),
                //   child: Align(
                //     alignment: Alignment.centerRight,
                //     child: Text(
                //       "قم بالتسجيل في حسابك الجديد",
                //       style: titilliumRegular.copyWith(
                //         fontSize: 20.sp,
                //         fontWeight: FontWeight.bold,
                //         color: Colors.white,
                //       ),
                //       textAlign: TextAlign.right,
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 32.h,
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
                    controller: _emailcontroller,
                    decoration: InputDecoration(
                      prefixIcon: SvgPicture.asset(
                        color: Colors.white,
                        "assets/Frame 1 (1).svg",
                        width: 24.w,
                        height: 24.h,
                        fit: BoxFit.scaleDown,
                      ),
                      contentPadding: const EdgeInsets.all(8),
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
                            width: 1,
                            color: Colors.grey.shade300,
                            style: BorderStyle.solid),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 28.h,
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
                //   height: 22.h,
                // ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                  child: TextField(
                    keyboardType: TextInputType.visiblePassword,
                    maxLines: 1,
                    cursorHeight: 25.h,
                    textDirection: TextDirection.ltr,
                    style: titilliumRegular.copyWith(color: Colors.white),
                    obscureText: true,
                    controller: _passwordcontroller,
                    decoration: InputDecoration(
                      prefixIcon: SvgPicture.asset(
                        color: Colors.white,
                        "assets/Frame 1 (2).svg",
                        width: 24.w,
                        height: 24.h,
                        fit: BoxFit.scaleDown,
                      ),
                      contentPadding: const EdgeInsets.all(8),
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
                            width: 1,
                            color: Colors.grey.shade300,
                            style: BorderStyle.solid),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 13.h,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => ResetPasswordScreen(),
                        transition: Transition.circularReveal);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 28.w),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "هل نسيت كلمة السر؟",
                        style: titilliumRegular.copyWith(
                          fontSize: 13.sp,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 47.h,
                ),
                ElevatedButton(
                  onPressed: () {
                    performLogin();
                  },
                  child: Text(
                    "تسجيل الدخول",
                    style: titilliumRegular.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0XFF2D005D),
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
                  height: 25.h,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => RegisterScreen(),
                        transition: Transition.circularReveal);
                  },
                  child: RichText(
                    text: TextSpan(
                      style: titilliumRegular.copyWith(
                          fontSize: 18.sp, color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'ليس لديك حساب!  ',
                          style: titilliumRegular.copyWith(
                            fontSize: 14.sp,
                            color: Color(0XFFBCBCBC),
                          ),
                        ),
                        TextSpan(
                          text: " فتح حساب جديد",
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
                InkWell(
                  onTap: () {
                    Get.to(() => RegisterScreenCoffee());
                  },
                  child: Text(
                    "تسجيل دخول كمقهى",
                    style: titilliumRegular.copyWith(
                      fontSize: 14.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                InkWell(
                  onTap: () {
                    Get.offAll(() => DashBoardScreen(),
                        transition: Transition.circularReveal);
                    AppSettingsPreferences.sharedPreferences!
                        .setBool('isGuest', true);
                  },
                  child: RichText(
                    text: TextSpan(
                      style: titilliumRegular.copyWith(
                          fontSize: 16.sp, color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'الإستمرار  ',
                          style: titilliumRegular.copyWith(
                            fontSize: 14.sp,
                            color: Color(0XFFBCBCBC),
                          ),
                        ),
                        TextSpan(
                          text: "كزائر",
                          style: titilliumRegular.copyWith(
                            fontSize: 15.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> performLogin() async {
    if (checkData()) {
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
      await login();
    }
  }

  bool checkData() {
    if (_emailcontroller.text.isNotEmpty &&
        _passwordcontroller.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> login() async {
    bool status = await FbAuthController().signIn(
      context: context,
      email: _emailcontroller.text,
      password: _passwordcontroller.text,
    );

    if (!status) {
      showSnackBar(context: context, message: 'خطأ ! برجاء أعد المحاوله', error: true);
      return;
    }

    final userType = AppSettingsPreferences().userType;
    final isVerified = AppSettingsPreferences().isVerified;

    stream = FbAuthController().checkUserStatus(({required bool loggedIn}) {
      if (loggedIn) {
        if (userType == 'superAdmin') {
          Get.offAll(() => SuperAdminScreen(), transition: Transition.cupertino);
        } else if (userType == 'client') {
          Get.offAll(() => DashBoardScreen(), transition: Transition.cupertino);
        } else {
          Get.offAll(() => HomeStoreScreen(), transition: Transition.cupertino);
        }
      } else {
        Get.to(() => AuthScreen());
      }
    });

    if (!isVerified) {
      Get.to(() => EmailVerifyScreen());
    }
  }


// Future<void> login() async {
  //   bool status = await FbAuthController().signIn(
  //       context: context,
  //       email: _emailcontroller.text,
  //       password: _passwordcontroller.text);
  //   print(status);
  //   if (status && AppSettingsPreferences().userType == 'superAdmin') {
  //     stream = FbAuthController().checkUserStatus(({required bool loggedIn}) {
  //       loggedIn
  //           ? Get.offAll(() => SuperAdminScreen(),
  //               transition: Transition.cupertino)
  //           : Get.to(() => AuthScreen());
  //     });
  //   } else if (status && AppSettingsPreferences().isVerified) {
  //     stream = FbAuthController().checkUserStatus(({required bool loggedIn}) {
  //       loggedIn
  //           ? (AppSettingsPreferences().userType == 'client'
  //               ? Get.offAll(() => DashBoardScreen(),
  //                   transition: Transition.cupertino)
  //               : Get.offAll(() => HomeStoreScreen()))
  //           : Get.to(() => AuthScreen());
  //     });
  //   } else if (status && !AppSettingsPreferences().isVerified) {
  //     Get.to(() => EmailVerifyScreen());
  //   } else {
  //     showSnackBar(
  //         context: context, message: 'خطأ ! برجاء أعد المحاوله', error: true);
  //   }
  // }
}
