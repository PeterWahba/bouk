import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../SuccessOrdered/success_ordered_screen.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 45.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 38.w,
                ),
                InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: SvgPicture.asset("assets/Frame 20.svg")),
                SizedBox(
                  width: 11.w,
                ),
                Text(
                  "الدفع",
                  style: GoogleFonts.almarai(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 42.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50.h,
                    width: 83.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      border: Border.all(
                        color: Color(0XFFEFEFEF),
                      ),
                    ),
                    child: Center(
                      child: Image.asset(
                        "assets/Rectangle 231.png",
                      ),
                    ),
                  ),
                  Container(
                    height: 50.h,
                    width: 83.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      border: Border.all(
                        color: Color(0XFFEFEFEF),
                      ),
                    ),
                    child: Center(
                      child: Image.asset(
                        "assets/Rectangle 230.png",
                      ),
                    ),
                  ),
                  Container(
                    height: 50.h,
                    width: 83.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      border: Border.all(
                        color: Color(0XFFEFEFEF),
                      ),
                      color: Color(0XFF2D005D),
                    ),
                    child: Center(
                      child: Text(
                        "Card",
                        style: GoogleFonts.almarai(
                          fontSize: 15.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 50.h,
                    width: 83.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      border: Border.all(
                        color: Color(0XFFEFEFEF),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "PayPal",
                        style: GoogleFonts.almarai(
                          fontSize: 15.sp,
                          color: Colors.black.withOpacity(.4),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 36.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: SizedBox(
                height: 53.h,
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  maxLines: 1,
                  cursorHeight: 25.h,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(18),
                    counterText: "",
                    labelText: "الاسم على البطاقة",
                    labelStyle: GoogleFonts.almarai(
                      color: Color(0XFF000000).withOpacity(.3),
                      fontSize: 15.sp,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(
                        width: 1,
                        color: Color(0XFFE3E3CE),
                      ),
                    ),
                    // focusColor: Color(0XFF22A45D),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                          width: 1,
                          color: Colors.grey.shade300,
                          style: BorderStyle.solid),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 11.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: SizedBox(
                height: 53.h,
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  maxLines: 1,
                  cursorHeight: 25.h,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(18),
                    counterText: "",
                    labelText: "رقم البطاقة",
                    labelStyle: GoogleFonts.almarai(
                      color: Color(0XFF000000).withOpacity(.3),
                      fontSize: 15.sp,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(
                        width: 1,
                        color: Color(0XFFE3E3CE),
                      ),
                    ),
                    // focusColor: Color(0XFF22A45D),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                          width: 1,
                          color: Colors.grey.shade300,
                          style: BorderStyle.solid),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 11.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: Row(
                children: [
                  SizedBox(
                    width: 235.w,
                    height: 53.h,
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      maxLines: 1,
                      cursorHeight: 25.h,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(18),
                        counterText: "",
                        labelText: "تاريخ الانتهاء",
                        labelStyle: GoogleFonts.almarai(
                          color: Color(0XFF000000).withOpacity(.3),
                          fontSize: 15.sp,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(
                            width: 1,
                            color: Color(0XFFE3E3CE),
                          ),
                        ),
                        // focusColor: Color(0XFF22A45D),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                              width: 1,
                              color: Colors.grey.shade300,
                              style: BorderStyle.solid),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    width: 66.w,
                    height: 53.h,
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      maxLines: 1,
                      cursorHeight: 25.h,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(18),
                        counterText: "",
                        labelText: "CVV",
                        labelStyle: GoogleFonts.almarai(
                          color: Color(0XFF000000).withOpacity(.3),
                          fontSize: 15.sp,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(
                            width: 1,
                            color: Color(0XFFE3E3CE),
                          ),
                        ),
                        // focusColor: Color(0XFF22A45D),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                              width: 1,
                              color: Colors.grey.shade300,
                              style: BorderStyle.solid),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(right: 18.w, left: 14.w),
              child: Row(
                children: [
                  Text(
                    "المجموع الفرعي",
                    style: GoogleFonts.almarai(
                      fontSize: 16.sp,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "SAR 99.99",
                    style: GoogleFonts.almarai(
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 18.w, left: 14.w),
              child: Row(
                children: [
                  Text(
                    "الضريبة",
                    style: GoogleFonts.almarai(
                      fontSize: 16.sp,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "SAR 3.99",
                    style: GoogleFonts.almarai(
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 23.h,
            ),
            Padding(
              padding: EdgeInsets.only(right: 18.w, left: 14.w),
              child: Container(
                height: 1.h,
                color: Color(0XFFD9D9D9),
              ),
            ),
            SizedBox(
              height: 14.h,
            ),
            Padding(
              padding: EdgeInsets.only(right: 18.w, left: 14.w),
              child: Row(
                children: [
                  Text(
                    "المبلغ الإجمالي",
                    style: GoogleFonts.almarai(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "SAR 103.98",
                    style: GoogleFonts.almarai(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0XFF2D005D),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 31.h,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => SuccessOrderedScreen());
                },
                child: Text(
                  "إطلب الأن",
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
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }
}
