import 'package:caffa/Models/User.dart';
import 'package:caffa/utils/custom_themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Details/details_screen.dart';

class HomeScreenCoffee extends StatefulWidget {
  const HomeScreenCoffee({super.key});

  @override
  State<HomeScreenCoffee> createState() => _HomeScreenCoffeeState();
}

class _HomeScreenCoffeeState extends State<HomeScreenCoffee> {
  // late Future<List<UserData>> _futureuserData;
  Future<List<UserData>> _loadUsers() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      List<UserData> users = querySnapshot.docs.map((doc) {
        return UserData.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
      print(users);

      return users;
    } catch (error) {
      // Handle Firestore read error here
      print('Firestore read error: $error');
      return [];
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _futureuserData = _loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFFF9F9F9),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 210.h,
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0XFF313131),
                    Color(0XFF131313),
                  ],
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          // Get.to(() => LocationScreen());
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "موقع المقهى:",
                              style: titilliumRegular.copyWith(
                                fontSize: 12.sp,
                                color: Color(0XFFB7B7B7),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Al Madinah, Saudi Arabia",
                                  style: titilliumRegular.copyWith(
                                    fontSize: 14.sp,
                                    color: Color(0XFFFFFFFF),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down_sharp,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Image.asset("assets/Group 3147.png")
                    ],
                  ),
                  SizedBox(
                    height: 26.h,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    maxLines: 1,
                    cursorHeight: 25.h,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0XFF313131),
                      prefixIcon: Image.asset(
                        "assets/search-normal.png",
                        width: 24.w,
                        height: 24.h,
                        fit: BoxFit.scaleDown,
                      ),
                      suffixIcon: Container(
                        margin: EdgeInsets.only(left: 9.5.w),
                        decoration: BoxDecoration(
                          color: Color(0XFF2D005D),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            "assets/furnitur-icon.svg",
                          ),
                        ),
                        width: 46.5.w,
                        height: 40.5.h,
                      ),
                      contentPadding: const EdgeInsets.all(18),
                      counterText: "",
                      labelText: "البحث ",
                      labelStyle: titilliumRegular.copyWith(
                          color: Color(0XFF989898), fontSize: 14.sp),
                      floatingLabelBehavior: FloatingLabelBehavior.never,

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: Colors.transparent,
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
                ],
              ),
            ),
            SizedBox(
              height: 26.h,
            ),
            Padding(
              padding: EdgeInsets.only(right: 29.w),
              child: Text(
                "التحليلات",
                style: titilliumRegular.copyWith(
                  fontSize: 24.w,
                ),
              ),
            ),
            SizedBox(
              height: 14.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 165.w,
                  height: 115.h,
                  decoration: BoxDecoration(
                    color: Color(
                      0XFF2D005D,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "280%",
                        style: titilliumRegular.copyWith(
                          fontSize: 24.w,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "نمو المبيعات",
                        style: titilliumRegular.copyWith(
                          fontSize: 20.w,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 4.w,
                ),
                Container(
                  width: 165.w,
                  height: 115.h,
                  decoration: BoxDecoration(
                    color: Color(
                      0XFF2D005D,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "1200+",
                        style: titilliumRegular.copyWith(
                          fontSize: 24.w,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "طلبات جديدة",
                        style: titilliumRegular.copyWith(
                          fontSize: 20.w,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.only(right: 29.w),
              child: Text(
                "تحكم في المقهى",
                style: titilliumRegular.copyWith(
                  fontSize: 24.w,
                ),
              ),
            ),
            SizedBox(
              height: 14.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(() => DetailsScreenCoffee());
                  },
                  child: Container(
                    width: 172.w,
                    height: 150.h,
                    decoration: BoxDecoration(
                      color: Color(
                        0XFFF5F5F5,
                      ),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    padding: EdgeInsets.only(right: 11.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset("assets/Group 411.png"),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "بروفايل المقهى",
                          style: titilliumRegular.copyWith(
                            fontSize: 16.w,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "اكتشف الخصائص والأصول الفريدة لعروض القهوة لدينا.",
                          style: titilliumRegular.copyWith(
                            fontSize: 10.w,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 14.w,
                ),
                Container(
                  width: 172.w,
                  height: 150.h,
                  decoration: BoxDecoration(
                    color: Color(
                      0XFFF5F5F5,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  padding: EdgeInsets.only(right: 11.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset("assets/Group 411 (1).png"),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "مينو المقهى",
                        style: titilliumRegular.copyWith(
                          fontSize: 16.w,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "تصفح مجموعتنا المتنوعة من إبداعات وتخصصات القهوة المصنوعة يدويًا.",
                        style: titilliumRegular.copyWith(
                          fontSize: 10.w,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 14.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 172.w,
                  height: 150.h,
                  decoration: BoxDecoration(
                    color: Color(
                      0XFFF5F5F5,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  padding: EdgeInsets.only(right: 11.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset("assets/Group 411 (2).png"),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "طلبات المقهى",
                        style: titilliumRegular.copyWith(
                          fontSize: 16.w,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "ضع خلطات القهوة المفضلة لديك بكل سهولة وراحة.",
                        style: titilliumRegular.copyWith(
                          fontSize: 10.w,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 14.w,
                ),
                Container(
                  width: 172.w,
                  height: 150.h,
                  decoration: BoxDecoration(
                    color: Color(
                      0XFFF5F5F5,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  padding: EdgeInsets.only(right: 11.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset("assets/Rectangle 16.png"),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "عملاء المقهى",
                        style: titilliumRegular.copyWith(
                          fontSize: 16.w,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "تواصل مع عشاق القهوة الكرام وأفراد المجتمع.",
                        style: titilliumRegular.copyWith(
                          fontSize: 10.w,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
