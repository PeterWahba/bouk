import 'package:caffa/Shared%20preferences/shared_preferences.dart';
import 'package:caffa/utils/custom_themes.dart';
import 'package:caffa/utils/helpers.dart';
import 'package:caffa/widgets/custom_appbar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';

class ContactUsPage extends StatefulWidget {
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> with Helpers {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Future<void> _sendMessage() async {
    if (_formKey.currentState!.validate()) {
      // إخفاء لوحة المفاتيح
      FocusScope.of(context).unfocus();

      // عرض Dialog الانتظار
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Center(
            child: SpinKitFadingCircle(
              color: Colors.blue,
              size: 80.0,
            ),
          );
        },
      );

      // إرسال البيانات إلى Firestore
      await FirebaseFirestore.instance.collection('contact_us').add({
        'email': AppSettingsPreferences().isGuest
            ? _emailController.text.trim()
            : AppSettingsPreferences().email,
        'message': _messageController.text,
        'timestamp': FieldValue.serverTimestamp(),
      }).then((onValue) {
        // إغلاق Dialog الانتظار
        Navigator.of(context).pop();
        FocusScope.of(context).unfocus();

      });

      // عرض رسالة نجاح
      showSnackBar(context: context, message: 'تم الإرسال بنجاح');

      // مسح الحقول
      _emailController.clear();
      _messageController.clear();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: CustomAppBar(
          context: context, title: 'تواصل معنا', isHomeScreen: false),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 16.0),
                Lottie.asset('assets/contactUs.json', height: 250.h),
                SizedBox(height: 50.h),
                AppSettingsPreferences().isGuest
                    ? TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                            labelText: 'البريد الإلكتروني',
                            labelStyle: titilliumRegular.copyWith(
                              fontSize: 16.sp,
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'من فضلك أكتب بريدك الإلكتروني';
                          } else if (!EmailValidator.validate(value.trim())) {
                            return 'من فضلك أكتب بريد إلكتروني صحيح';
                          }
                          return null;
                        },
                      )
                    : SizedBox(height: 16.0),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _messageController,
                  decoration: InputDecoration(
                      labelText: 'رسالتك',
                      labelStyle: titilliumRegular.copyWith(
                        fontSize: 16.sp,
                      )),
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'من فضلك أكتب رسالتك';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // AppSettingsPreferences().isGuest
                    _sendMessage();
                  },
                  child: Text(
                    "إرسال",
                    style: titilliumRegular.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(300.w, 60.h),
                    backgroundColor: Color(0XFF2D005D),
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    alignment: Alignment.center,
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
