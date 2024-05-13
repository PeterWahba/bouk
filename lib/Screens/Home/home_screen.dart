import 'package:caffa/Models/User.dart';
import 'package:caffa/Shared%20preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Details/details_screen.dart';
import '../Location/location_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<UserData>> _futureuserData;
  late int availableCups = 0;

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
    _futureuserData = _loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 280.h,
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
                              Get.to(() => LocationScreen());
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "موقعي:",
                                  style: GoogleFonts.almarai(
                                    fontSize: 12.sp,
                                    color: Color(0XFFB7B7B7),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Al Madinah, Saudi Arabia",
                                      style: GoogleFonts.almarai(
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
                          labelText: "إبحث عن مقهاك المفضلة",
                          labelStyle: GoogleFonts.almarai(
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
                  height: 78.h,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 29.w),
                  child: Text(
                    "مقاهي قريبة مني",
                    style: GoogleFonts.almarai(
                      fontSize: 20.w,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Expanded(
                  child: FutureBuilder(
                      future: _futureuserData,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: SpinKitFadingCircle(
                              color: Colors.blue,
                              size: 80.0,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          List<UserData> products = snapshot.data!;

                          if (products.isNotEmpty) {
                            return ListView.builder(
                              padding: EdgeInsets.all(0),
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Get.to(() => DetailsScreen(
                                          userData: products[index],
                                        ));
                                  },
                                  child: SizedBox(
                                    height: 220.h,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 23.w),
                                          child: Stack(
                                            children: [
                                              Image.asset("assets/bouk.jpg"),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 11.h),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: 232.w,
                                                      height: 29.h,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0XFF2D005D),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  10.r),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10.r),
                                                        ),
                                                      ),
                                                      padding: EdgeInsets.only(
                                                          right: 9.w, top: 4.h),
                                                      child: Text(
                                                        "احصل على 5 أكواب قهوة بسعر رمزي",
                                                        style:
                                                            GoogleFonts.almarai(
                                                          color: Colors.white,
                                                          fontSize: 14.sp,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 70.w,
                                                    ),
                                                    Icon(
                                                      Icons.favorite_border,
                                                      color: Colors.white,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: 29.w, left: 35.w),
                                          child: Row(
                                            children: [
                                              Text(
                                                'X',
                                                style: GoogleFonts.almarai(
                                                  fontSize: 18.w,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Spacer(),
                                              Text(
                                                "4.9",
                                                style: GoogleFonts.almarai(
                                                  fontSize: 15.w,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0XFFFFA800),
                                                ),
                                              ),
                                              Icon(
                                                Icons.star_rate_rounded,
                                                color: Color(0XFFFFA800),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(right: 29.w),
                                          child: Text(
                                            "بعيدة عني ب 10 دقائق بالسيارة",
                                            style: GoogleFonts.almarai(
                                                fontSize: 14.w,
                                                color: Colors.black
                                                    .withOpacity(.7)),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              itemCount: 1,
                            );
                          } else {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 15.w,
                                vertical: 15.h,
                              ),
                              height: 151.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0.r),
                                color: Color(0xffF8F8F7),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey
                                        .withOpacity(0.5), // Shadow color
                                    spreadRadius:
                                        2, // How far the shadow spreads
                                    blurRadius: 10, // Soften the shadow
                                    offset: Offset(2,
                                        2), // Offset in the X and Y direction
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.warning,
                                    size: 80.r,
                                    color: const Color.fromARGB(255, 201, 8, 8),
                                  ),
                                  SizedBox(
                                    width: 15.w,
                                  ),
                                  Text(
                                    "لا يوجد مقاهي",
                                    style: GoogleFonts.tajawal(
                                      fontSize: 16.sp,
                                      color:
                                          const Color.fromARGB(255, 201, 8, 8),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                        }
                      }),
                ),
              ],
            ),
            Positioned(
              top: 192.h,
              right: 30.w,
              child: Center(
                child: Image.asset("assets/Frame 17.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
