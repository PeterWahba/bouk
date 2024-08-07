import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/Frame (1).png"),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 110.h,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: [
                    SizedBox(
                      width: 38.w,
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: SvgPicture.asset("assets/Frame 20.svg"),
                    ),
                    SizedBox(
                      width: 11.w,
                    ),
                    Text(
                      "عنواني",
                      style: GoogleFonts.almarai(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              Spacer(),
              Container(
                height: 206.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      width: 343.w,
                      height: 54,
                      padding: EdgeInsets.only(top: 9.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9.r),
                        color: Color(0XFFF6F6F6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 9.w,
                          ),
                          SvgPicture.asset(
                            "assets/map-marker.svg",
                            width: 20.w,
                            height: 20.h,
                            fit: BoxFit.fill,
                            color: Color(0XFF2D005D),
                          ),
                          SizedBox(
                            width: 6.w,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "المدينة - السعودية ",
                                style: GoogleFonts.almarai(
                                  color: Colors.black,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "حي السلطانة - المدينة المنورة",
                                style: GoogleFonts.almarai(
                                  color: Color(0XFFACACAC),
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Text(
                            "البيت",
                            style: GoogleFonts.almarai(
                              color: Color(0XFF000000),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 19.w,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 29.h,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // performLogin();
                        // Get.to(() => HomeScreen(),
                        //     transition: Transition.circularReveal);
                      },
                      child: Text(
                        "تأكيد العنوان",
                        style: GoogleFonts.almarai(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Color(0XFF020202),
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
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
