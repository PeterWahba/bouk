import 'package:caffa/Screens/Auth/auth_screen.dart';
import 'package:caffa/utils/custom_themes.dart';
import 'package:caffa/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class GuestScreen extends StatelessWidget {
  final bool isHomeScreen;
  final String appBarHeader;
  const GuestScreen({super.key, required this.isHomeScreen, required this.appBarHeader});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(context: context, title: appBarHeader, isHomeScreen: isHomeScreen),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/guestMode.json', height: 250.h),
            SizedBox(height: 80.h),
            Text("المعذرة!",
                style: titilliumRegular.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0XFF2D005D),
                )),
            SizedBox(height: 10.h),
            Text(
              "تسجيل الدخول مطلوب",
              maxLines: 3,
              textAlign: TextAlign.center,
              style: titilliumRegular.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 47.h,
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(() => AuthScreen(),
                    transition: Transition.circularReveal);
              },
              child: Text(
                "الرجاء تسجيل الدخول",
                style: titilliumRegular.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(250.w, 60.h),
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
    );
  }
}
