import 'package:caffa/Screens/Auth/reset_pass_screen.dart';
import 'package:caffa/utils/custom_themes.dart';
import 'package:caffa/utils/helpers.dart';
import 'package:caffa/widgets/custom_appbar.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/components.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen>
    with Helpers {
  var oldPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmNewPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isObsecured1 = true;
  bool isObsecured2 = true;
  var state;

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    setState(() {
      state = 'loading';
    });
    var user = FirebaseAuth.instance.currentUser;
    String email = user!.email!;

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: oldPassword,
      );

      user.updatePassword(newPassword).then((_) {
        print("Successfully changed password");
        setState(() {
          state = 'success';
        });
        setState(() {
          newPasswordController.text = '';
        });
        setState(() {
          oldPasswordController.text = '';
        });
        setState(() {
          confirmNewPasswordController.text = '';
        });

        showSnackBar(context: context, message: 'تم تغيير كلمة المرور بنجاح');
      }).catchError((error) {
        showSnackBar(
            context: context,
            message: 'حدث خطأ أثناء تغيير كلمة المرور برجاء إعادة المحاولة',
            error: true);

        print("Password can't be changed" + error.toString());

        setState(() {
          state = 'error';
        });
        //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      setState(() {
        state = 'error';
      });
      showSnackBar(context: context, message: e.code.toString(), error: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(context: context, title: 'الإعدادات', isHomeScreen: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  'تغيير كلمة المرور',
                  style: titilliumRegular.copyWith(
                    color: Colors.black,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: size.height * .07,
                ),
                defaultFormFeild(
                  borderColor: Colors.black,
                  color: Colors.black,
                  context: context,
                  isObsecured: isObsecured1,
                  validatorText: 'كلمة المرور القديمة',
                  controller: oldPasswordController,
                  suffixIcon: IconButton(
                      color: Colors.black,
                      icon: isObsecured1
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          isObsecured1 = !isObsecured1;
                        });
                      }),
                  inputType: TextInputType.visiblePassword,
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Colors.black,
                  ),
                  labelText: 'كلمة المرور القديمة',
                ),
                const SizedBox(
                  height: 25.0,
                ),
                defaultFormFeild(
                  borderColor: Colors.black,
                  color: Colors.black,
                  context: context,
                  isObsecured: isObsecured2,
                  validatorText: 'كلمة المرور الجديدة',
                  controller: newPasswordController,
                  suffixIcon: IconButton(
                      color: Colors.black,
                      icon: isObsecured2
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          isObsecured2 = !isObsecured2;
                        });
                      }),
                  inputType: TextInputType.visiblePassword,
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Colors.black,
                  ),
                  labelText: 'كلمة المرور الجديدة',
                ),
                const SizedBox(
                  height: 25.0,
                ),
                ConditionalBuilder(
                  condition: state != 'loading',
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        changePassword(
                            oldPassword: oldPasswordController.text,
                            newPassword: newPasswordController.text);
                      } else {
                        showSnackBar(
                            context: context,
                            message: 'من فضلك أكتب كلمة المرور',error: true);
                      }
                    },
                    child: Text(
                      "تغيير كلمة المرور",
                      style: titilliumRegular.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(318.w, 60.h),
                      backgroundColor: Color(0xff2D005D),
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                  fallback: (context) =>
                      Center(child: CircularProgressIndicator()),
                ),
                SizedBox(
                  height: 12,
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
                          fontSize: 15.sp,
                          color: Color(0XFF2D005D),
                        ),
                        textAlign: TextAlign.left,
                      ),
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
}
