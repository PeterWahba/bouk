import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(
              height: 30.h,
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
                  "بطاقاتي",
                  style: GoogleFonts.almarai(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 45.h,
            ),
            Container(
              width: 354.w,
              height: 229.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: Color(0XFFFAFAFA),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 24.w,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "رقم المستهلك",
                        style: GoogleFonts.almarai(
                          fontSize: 12.sp,
                          color: Color(0XFF24373D),
                        ),
                      ),
                      Text(
                        "102340000001242",
                        style: GoogleFonts.almarai(
                          fontSize: 14.sp,
                          color: Color(0XFF24373D),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "تاريخ الفاتورة",
                        style: GoogleFonts.almarai(
                          fontSize: 12.sp,
                          color: Color(0XFF24373D),
                        ),
                      ),
                      Text(
                        "27 Mar 2024",
                        style: GoogleFonts.almarai(
                          fontSize: 14.sp,
                          color: Color(0XFF24373D),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "مبلغ مستحق",
                        style: GoogleFonts.almarai(
                          fontSize: 12.sp,
                          color: Color(0XFF24373D),
                        ),
                      ),
                      Text(
                        "SAR 103.98",
                        style: GoogleFonts.almarai(
                          fontSize: 14.sp,
                          color: Color(0XFF2D005D),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "إسم المقهى",
                        style: GoogleFonts.almarai(
                          fontSize: 12.sp,
                          color: Color(0XFF24373D),
                        ),
                      ),
                      Text(
                        "COFFEE ADDICTS",
                        style: GoogleFonts.almarai(
                          fontSize: 12.sp,
                          color: Color(0XFF2D005D),
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  Spacer(),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset("assets/Rectangle 1714.png"),
                      Text(
                        "تم إستهلاك",
                        style: GoogleFonts.almarai(
                          fontSize: 14.sp,
                          color: Color(0XFF2D005D),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "(1/5)",
                        style: GoogleFonts.almarai(
                          fontSize: 14.sp,
                          color: Color(0XFF2D005D),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
