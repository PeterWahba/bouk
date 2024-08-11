import 'package:caffa/utils/custom_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsScreenCoffee extends StatefulWidget {
  const DetailsScreenCoffee({super.key});
  @override
  State<DetailsScreenCoffee> createState() => _DetailsScreenCoffeeState();
}

class _DetailsScreenCoffeeState extends State<DetailsScreenCoffee> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  "assets/Group 87.png",
                  height: 292.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    width: 50.w,
                    height: 50.h,
                    margin: EdgeInsets.only(top: 32.h, right: 23.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: SvgPicture.asset(
                      "assets/Frame 2 (1).svg",
                      width: 24.w,
                      height: 24.h,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                Positioned(
                  left: 23.w,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      width: 50.w,
                      height: 50.h,
                      margin: EdgeInsets.only(top: 32.h),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: SvgPicture.asset(
                        "assets/heart.svg",
                        width: 24.w,
                        height: 24.h,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 13.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 23.w,
                ),
                Text(
                  "COFFEE ADDICTS",
                  style: titilliumRegular.copyWith(
                    fontSize: 18.w,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Text(
                  "معلومات المقهى",
                  style: titilliumRegular.copyWith(
                    fontSize: 16.sp,
                    color: Color(0XFF2D005D),
                  ),
                ),
                SizedBox(
                  width: 23.w,
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 23.w,
                ),
                Text(
                  "أحلى مقهى قريب منك.",
                  style: titilliumRegular.copyWith(
                    fontSize: 16.w,
                    color: Color(0XFFA8A8A8),
                  ),
                ),
                Spacer(),
                Text(
                  "تعليقات",
                  style: titilliumRegular.copyWith(
                    fontSize: 16.sp,
                    color: Color(0XFF2D005D),
                  ),
                ),
                SizedBox(
                  width: 23.w,
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 23.w,
                ),
                SvgPicture.asset("assets/star.svg"),
                SvgPicture.asset("assets/star.svg"),
                SvgPicture.asset("assets/star.svg"),
                SvgPicture.asset("assets/star.svg"),
                SvgPicture.asset("assets/star.svg"),
                SizedBox(
                  width: 8.w,
                ),
                Text(
                  "4.9",
                  style: titilliumRegular.copyWith(
                    fontSize: 15.w,
                    color: Color(0XFFFFA800),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 23.w,
                ),
                SvgPicture.asset("assets/star (1) 1.svg"),
                SizedBox(
                  width: 6.w,
                ),
                Text(
                  "مفتوح حتى الساعة 2:30 صباحًا",
                  style: titilliumRegular.copyWith(
                    fontSize: 14.w,
                    color: Color(0XFFA8A8A8),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            Container(
              height: 5.h,
              width: double.infinity,
              color: Color(0XFFF8F8F8),
            ),
            SizedBox(
              height: 13.h,
            ),
            Image.asset("assets/Rectangle 1713.png"),
            SizedBox(
              height: 31.h,
            ),
            Image.asset("assets/Frame 68.png"),
            SizedBox(
              height: 15.h,
            ),
          ],
        ),
      ),
    ));
  }
}
