import 'package:caffa/Screens/Cards/cards_screen.dart';
import 'package:caffa/utils/custom_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SuccessOrderedScreen extends StatefulWidget {
  const SuccessOrderedScreen({super.key});

  @override
  State<SuccessOrderedScreen> createState() => _SuccessOrderedScreenState();
}

class _SuccessOrderedScreenState extends State<SuccessOrderedScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50.h,
              ),
              Padding(
                padding: EdgeInsets.only(right: 38.w),
                child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back_ios_sharp)),
              ),
              Padding(
                padding: EdgeInsets.only(right: 24.w, top: 58.h),
                child: Image.asset("assets/Rectangle 177.png"),
              ),
              SizedBox(
                height: 11.h,
              ),
              Center(
                child: Text(
                  "تم تأكيد طلبك!",
                  style: titilliumRegular.copyWith(
                    fontSize: 20.w,
                    fontWeight: FontWeight.bold,
                    color: Color(0XFF2D005D),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 36.w),
                  child: Text(
                    "ستجد الكرت الافتراضي في ملفك الشخصي. اضغط على الزر أدناه وتحقق من بطاقتك",
                    style: titilliumRegular.copyWith(
                      fontSize: 18.w,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // performLogin();
                    Get.to(() => CardScreen(isHomeScreen: false,),
                        transition: Transition.circularReveal);
                  },
                  child: Text(
                    "تحقق من بطاقتك",
                    style: titilliumRegular.copyWith(
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
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
