import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/helpers.dart';
import '../../../widgets/code_text_field.dart';
import '../Home/home_screen.dart';

class OTPScreenCoffee extends StatefulWidget {
  const OTPScreenCoffee({
    super.key,
    required this.verificationId,
  });
  final String verificationId;

  @override
  State<OTPScreenCoffee> createState() => _OTPScreenCoffeeState();
}

class _OTPScreenCoffeeState extends State<OTPScreenCoffee> with Helpers {
  String? _code;
  late TextEditingController _firstCodeTextController;
  late TextEditingController _secondCodeTextController;
  late TextEditingController _thirdCodeTextController;
  late TextEditingController _fourthCodeTextController;
  late TextEditingController _fiveCodeTextController;
  late TextEditingController _sexCodeTextController;

  late FocusNode _firstFocusNode;
  late FocusNode _secondFocusNode;
  late FocusNode _thirdFocusNode;
  late FocusNode _fourthFocusNode;
  late FocusNode _fiveFocusNode;
  late FocusNode _sexFocusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firstCodeTextController = TextEditingController();
    _secondCodeTextController = TextEditingController();
    _thirdCodeTextController = TextEditingController();
    _fourthCodeTextController = TextEditingController();
    _fiveCodeTextController = TextEditingController();
    _sexCodeTextController = TextEditingController();

    _firstFocusNode = FocusNode();
    _secondFocusNode = FocusNode();
    _thirdFocusNode = FocusNode();
    _fourthFocusNode = FocusNode();
    _fiveFocusNode = FocusNode();
    _sexFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _firstCodeTextController.dispose();
    _secondCodeTextController.dispose();
    _thirdCodeTextController.dispose();
    _fourthCodeTextController.dispose();
    _fiveCodeTextController.dispose();
    _sexCodeTextController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> _verifyOTP(String verificationId, String smsCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      // OTP verification successful, navigate to the home screen
      // Replace Navigator with your navigation logic
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreenCoffee()),
      );
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 20),
          physics: NeverScrollableScrollPhysics(),
          children: [
            SizedBox(
              height: 94.h,
            ),
            Text(
              "ادخل رمز التحقق الذي تم ارساله لرقم هاتفك",
              style: GoogleFonts.almarai(
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
                color: Color(0XFF000000),
              ),
            ),
            SizedBox(
              height: 43.h,
            ),
            Row(
              children: [
                Expanded(
                  child: CodeTextField(
                    codeTextController: _firstCodeTextController,
                    focusNode: _firstFocusNode,
                    onChange: (String value) {
                      if (value.isNotEmpty) {
                        _secondFocusNode.requestFocus();
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Expanded(
                  child: CodeTextField(
                    codeTextController: _secondCodeTextController,
                    focusNode: _secondFocusNode,
                    onChange: (String value) {
                      if (value.isNotEmpty) {
                        _thirdFocusNode.requestFocus();
                      } else {
                        _firstFocusNode.requestFocus();
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Expanded(
                  child: CodeTextField(
                    codeTextController: _thirdCodeTextController,
                    focusNode: _thirdFocusNode,
                    onChange: (String value) {
                      if (value.isNotEmpty) {
                        _fourthFocusNode.requestFocus();
                      } else {
                        _secondFocusNode.requestFocus();
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Expanded(
                  child: CodeTextField(
                    codeTextController: _fourthCodeTextController,
                    focusNode: _fourthFocusNode,
                    onChange: (String value) {
                      if (value.isNotEmpty) {
                        _fiveFocusNode.requestFocus();
                      } else {
                        _thirdFocusNode.requestFocus();
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Expanded(
                  child: CodeTextField(
                    codeTextController: _fiveCodeTextController,
                    focusNode: _fiveFocusNode,
                    onChange: (String value) {
                      if (value.isNotEmpty) {
                        _sexFocusNode.requestFocus();
                      } else {
                        _fourthFocusNode.requestFocus();
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Expanded(
                  child: CodeTextField(
                    codeTextController: _sexCodeTextController,
                    focusNode: _sexFocusNode,
                    onChange: (String value) {
                      if (value.isEmpty) {
                        _fiveFocusNode.requestFocus();
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            Text(
              "لم أتلق رمزًا (00: 15 ثانية)",
              style: GoogleFonts.almarai(
                color: Color(0XFF13362A),
                fontSize: 15.sp,
              ),
            ),
            Text(
              "أعد الارسال مرة اخرى",
              style: GoogleFonts.almarai(
                color: Color(0XFFA8A8A8),
                fontSize: 15.sp,
                height: 1.h,
              ),
            ),
            SizedBox(
              height: 100.h,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 36.w),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0XFF13362A),
                      minimumSize: Size(75.w, 75.h),
                      shape: CircleBorder(),
                    ),
                    onPressed: () async {
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
                        PhoneAuthCredential credential =
                            await PhoneAuthProvider.credential(
                                verificationId: widget.verificationId,
                                smsCode: _code!);
                        FirebaseAuth.instance
                            .signInWithCredential(credential)
                            .then((value) => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreenCoffee()),
                                ));
                      } catch (e) {}
                      // if (_code == widget.verificationId) {
                      //   _verifyOTP(widget.verificationId, _code!);
                      // } else {
                      //   showSnackBar(
                      //       context: context,
                      //       message: "الكود الذي أدخلته خاطئ",
                      //       error: true);
                      // }
                    },
                    child: SvgPicture.asset(
                      "assets/Frame 1.svg",
                      width: 31.w,
                      height: 31.h,
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 36.w),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0XFFF2F2F2),
                      minimumSize: Size(75.w, 75.h),
                      shape: CircleBorder(),
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    child: SvgPicture.asset(
                      "assets/arrow-right.svg",
                      color: Color(0XFF9B9B9B),
                      width: 31.w,
                      height: 31.h,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
