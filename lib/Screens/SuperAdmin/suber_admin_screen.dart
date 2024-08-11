import 'package:caffa/Models/User.dart';
import 'package:caffa/Screens/Home_store/clients_screen.dart';
import 'package:caffa/Screens/Home_store/component/qr_screen.dart';
import 'package:caffa/Screens/SuperAdmin/banner_settings.dart';
import 'package:caffa/Screens/SuperAdmin/stores_settings.dart';
import 'package:caffa/Shared%20preferences/shared_preferences.dart';
import 'package:caffa/fb-controllers/fb_auth_controller.dart';
import 'package:caffa/utils/custom_themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'active_stores_screen.dart';
import 'non_active_store_screen.dart';

class SuperAdminScreen extends StatefulWidget {
  const SuperAdminScreen({super.key});

  @override
  State<SuperAdminScreen> createState() => _SuperAdminScreenState();
}

class _SuperAdminScreenState extends State<SuperAdminScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // الجزء العلوي من الشاشة
            Container(
              height: MediaQuery.of(context).size.height * 0.13, // نصف الصفحة
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0XFF313131),
                    Color(0XFF131313),
                  ],
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "مرحباً !",
                            style: titilliumRegular.copyWith(
                              fontSize: 14.sp,
                              color: Color(0XFFB7B7B7),
                            ),
                          ),
                          SizedBox(width: 15),
                          Text(
                            'BOUK',
                            style: titilliumRegular.copyWith(
                              fontSize: 15.sp,
                              color: Color(0XFFFFFFFF),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon:
                                Icon(Icons.logout_outlined, color: Colors.red),
                            onPressed: () => {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  elevation: 24.0,
                                  title: Text(
                                    'هل أنت متأكد ؟',
                                    textAlign: TextAlign.center,
                                    style: titilliumRegular.copyWith(
                                      fontSize: 20.sp,
                                      color: Colors.black,
                                    ),
                                  ),
                                  content: Text(
                                    'سوف تقوم بتسجيل الخروج من حسابكم',
                                    textAlign: TextAlign.center,
                                    style: titilliumRegular.copyWith(
                                      fontSize: 18.sp,
                                      color: Colors.black,
                                    ),
                                  ),
                                  actions: [
                                    CupertinoDialogAction(
                                      child: Container(
                                        child: Text(
                                          'تسجيل الخروج',
                                          style: titilliumRegular.copyWith(
                                              fontSize: 16.sp,
                                              color: Colors.red),
                                        ),
                                      ),
                                      onPressed: () {
                                        FbAuthController().signOut();
                                      },
                                    ),
                                    CupertinoDialogAction(
                                      child: Text(
                                        'إلغاء',
                                        style: titilliumRegular.copyWith(
                                            fontSize: 16.sp,
                                            color: Colors.green),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              )
                            },
                          ),
                          Image.asset(
                            "assets/boukLogo.png",
                            height: 25.h,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // الجزء السفلي الذي يحتوي على الـ GridView
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 80.h),
                child: GridView.builder(
                  padding: EdgeInsets.all(16.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // عدد الأعمدة
                    crossAxisSpacing: 16.0, // المسافة بين الأعمدة
                    mainAxisSpacing: 16.0, // المسافة بين الصفوف
                    childAspectRatio: 1, // نسبة العرض إلى الارتفاع لكل عنصر
                  ),
                  itemCount: 4, // عدد العناصر في الشبكة
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return InkWell(
                          onTap: () {
                            Get.to(BannersSettingsScreen());
                          },
                          child: HomeScreenItem(
                              'assets/banner.json', 'إدارة الإعلانات'),
                        );
                      case 1:
                        return InkWell(
                          onTap: () {
                            Get.to(StoreSettingsScreen());
                          },
                          child: HomeScreenItem(
                              'assets/messages.json', 'قائمة الرسائل'),
                        );
                      case 2:
                        return InkWell(
                            onTap: () {
                              Get.to(ActiveStoresScreen());
                            },
                            child: HomeScreenItem(
                                'assets/notActive.json', 'المقاهي النشطه'));
                      case 3:
                        return InkWell(
                            onTap: () {
                              Get.to(NonActiveStoresScreen());
                            },
                            child: HomeScreenItem(
                                'assets/active.json', 'المقاهي الغير النشطه'));
                      default:
                        return SizedBox.shrink();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget HomeScreenItem(img, text) => Container(
        width: MediaQuery.of(context).size.width * .4,
        height: MediaQuery.of(context).size.height * .22,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: Color(0XFF020202),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              img,
              width: MediaQuery.of(context).size.width * .27,
              height: MediaQuery.of(context).size.height * .1,
            ),
            SizedBox(height: 10),
            Text(
              text,
              style: titilliumRegular.copyWith(
                  fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 2),
          ],
        ),
      );
}
