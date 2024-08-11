import 'package:caffa/Screens/Auth/auth_screen.dart';
import 'package:caffa/Screens/ContactUs/contact_us_screen.dart';
import 'package:caffa/Screens/GuestMode/guest_screen.dart';
import 'package:caffa/Screens/info/info_screen.dart';
import 'package:caffa/Screens/settings/settings.dart';
import 'package:caffa/Shared%20preferences/shared_preferences.dart';
import 'package:caffa/fb-controllers/fb_auth_controller.dart';
import 'package:caffa/utils/custom_themes.dart';
import 'package:caffa/widgets/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar:
          CustomAppBar(context: context, title: 'حسابي', isHomeScreen: true),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            buildListTile(
                // Colors.black,
                "إعدادات الحساب",
                Icons.arrow_forward_ios, () {
              AppSettingsPreferences().isGuest?
              Get.to(() => GuestScreen(isHomeScreen: false, appBarHeader: 'حسابي'  ,))
              :
              Get.to(() => SettingsScreen());
            }),
            buildListTile(
                // Colors.black,
                "الشروط والأحكام",
                Icons.arrow_forward_ios, () {
              Get.to(() =>
                  InfoScreen(data: 'conditions', title: 'الشروط والأحكام'));
            }),
            buildListTile(
                // Colors.black,
                "سياسة الخصوصية",
                Icons.arrow_forward_ios, () {
              Get.to(() => InfoScreen(data: 'faq', title: 'سياسة الخصوصية'));
            }),
            buildListTile(
              // Colors.black,
                "من نحن",
                Icons.arrow_forward_ios, () {
              Get.to(() => InfoScreen(data: 'aboutUs', title: 'من نحن'));
            }),
            buildListTile(
              // Colors.black,
                "تواصل معنا",
                Icons.arrow_forward_ios, () {
              Get.to(() => ContactUsPage());
            }),
            buildListTile(
                // Colors.black,
                "إبقى على تواصل",
                Icons.arrow_forward_ios, () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return _buildBottomSheet(context);
                },
              );
            }),
            !AppSettingsPreferences().isGuest
                ? buildListTile(
                    // Colors.black,
                    "تسجيل الخروج",
                    Icons.arrow_forward_ios, () {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              elevation: 24.0,
                              title: Center(
                                child: Text('هل أنت متأكد ؟',
                                    style: robotoBold.copyWith(
                                        fontSize: 22.sp, color: Colors.black)),
                              ),
                              content: Text(
                                  textAlign: TextAlign.center,
                                  'سوف تقوم بتسجيل الخروج من حسابك',
                                  style: titilliumRegular.copyWith(
                                      fontSize: 18.sp, color: Colors.black)),
                              actions: [
                                CupertinoDialogAction(
                                  child: Container(
                                    child: Text(
                                      'تسجيل الخروج',
                                      style: titilliumRegular.copyWith(
                                          fontSize: 16.sp, color: Colors.red),
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
                                      color: Colors.green,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ));
                  })
                : buildListTile(
                    // Colors.black,
                    "تسجيل الدخول",
                    Icons.arrow_forward_ios, () {
                    Get.to(() => AuthScreen());
                  }),
            SizedBox(height: 150.h,)
          ],
        ),
      ),
    );
  }
}

Widget buildListTile(String title, icon, tabHandler) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
    child: Card(
      color: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(10)),
      ),
      elevation: 5.0,
      child: Container(
        // color: Colors.white,
        height: 70,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Text(
              title,
              style: titilliumRegular.copyWith(
                  fontWeight: FontWeight.w700, fontSize: 16.sp),
            ),
            trailing: Icon(
              icon,
              size: 16.sp,
            ),
            onTap: tabHandler,
          ),
        ),
      ),
    ),
  );
}

Widget _buildBottomSheet(BuildContext context) {
  return Container(
    height: 200.0,
    child: GridView.count(
      crossAxisCount: 3,
      children: List.generate(apps.length, (index) {
        return GestureDetector(
          onTap: () {
            _launchApp(context, apps[index]['package']);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipOval(
                child: Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200, // لون الخلفية للصورة
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Image.asset(
                      apps[index]['image'],
                      width: 50.0,
                      height: 50.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                apps[index]['name'],
                style: titleHeader.copyWith(fontSize: 14.sp),
              ),
            ],
          ),
        );
      }),
    ),
  );
}

void _launchApp(BuildContext context, String packageName) async {
  final url = '$packageName';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Cannot open $packageName')),
    );
  }
}

// Future<void> _launchUrl() async {
//   final Uri _url = Uri.parse('https://flutter.dev');
//
//   if (!await launchUrl(_url)) {
//     throw Exception('Could not launch $_url');
//   }
// }

List<Map<String, dynamic>> apps = [
  {
    'name': 'Instagram',
    'image': 'assets/instagram_icon.png',
    'package': instagram ?? ''
  },
  {
    'name': 'Facebook',
    'image': 'assets/facebook_icon.png',
    'package': facebook ?? ''
  },
  {
    'name': 'What\'s App',
    'image': 'assets/whatsapp_icon.png',
    'package': whatsApp ?? ''
  },
  // أضف المزيد من التطبيقات حسب الحاجة
];
