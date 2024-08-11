import 'package:caffa/Models/User.dart';
import 'package:caffa/Screens/Home_store/clients_screen.dart';
import 'package:caffa/Screens/Home_store/component/qr_screen.dart';
import 'package:caffa/Screens/SuperAdmin/banner_settings.dart';
import 'package:caffa/Screens/SuperAdmin/stores_settings.dart';
import 'package:caffa/Shared%20preferences/shared_preferences.dart';
import 'package:caffa/fb-controllers/fb_auth_controller.dart';
import 'package:caffa/utils/custom_themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SuperAdminScreen extends StatefulWidget {
  const SuperAdminScreen({super.key});

  @override
  State<SuperAdminScreen> createState() => _SuperAdminScreenState();
}

class _SuperAdminScreenState extends State<SuperAdminScreen> {

  @override
  void initState() {
    // TODO: implement initSta
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100.h,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                        height: 30.h,
                      ),
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
                              SizedBox(
                                width: 15,
                              ),
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
                                  icon: Icon(
                                    Icons.logout_outlined,
                                    color: Colors.red,
                                  ),
                                  onPressed: () => {
                                    showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          elevation: 24.0,
                                          title: Text('هل أنت متأكد ؟',
                                              textAlign: TextAlign.center,
                                              style: titilliumRegular.copyWith(
                                                  fontSize: 20.sp,
                                                  color: Colors.black)),
                                          content: Text(
                                              'سوف تقوم بتسجيل الخروج من حسابكم',
                                              textAlign: TextAlign.center,
                                              style: titilliumRegular.copyWith(
                                                  fontSize: 18.sp,
                                                  color: Colors.black)),
                                          actions: [
                                            CupertinoDialogAction(
                                              child: Container(
                                                child: Text(
                                                  'تسجيل الخروج',
                                                  style: titilliumRegular.copyWith(
                                                      fontSize: 16.sp,
                                                      color:
                                                      Colors.red),
                                                ),
                                              ),
                                              onPressed: () {
                                                FbAuthController()
                                                    .signOut();
                                              },
                                            ),
                                            CupertinoDialogAction(
                                              child: Text('إلغاء',
                                                style: titilliumRegular.copyWith(
                                                  fontSize: 16.sp,
                                                  color:
                                                  Colors.green),),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        ))
                                  }),
                              Image.asset("assets/boukLogo.png",height: 25.h,),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () {
                        Get.to(BannersSettingsScreen());
                      },
                      child: HomeScreenItem(
                          'assets/banner.json', 'إدارة الإعلانات')),
                  const SizedBox(
                    width: 15,
                  ),
                  InkWell(
                      onTap: () {
                        Get.to(StoreSettingsScreen());
                      },
                      child: HomeScreenItem('assets/store.json', 'إدارة المقاهي')),
                ],
              ),
            ),
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.person),
        //   onPressed: () {
        //     Get.to(ClientsScreen(users: futureUserData,));
        //   },
        // ),
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
        )),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          img,
          width: MediaQuery.of(context).size.width * .27,
          height: MediaQuery.of(context).size.height * .1,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          '${text}',
          style: titilliumRegular.copyWith(fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 2,
        ),

      ],
    ),
  );
}

