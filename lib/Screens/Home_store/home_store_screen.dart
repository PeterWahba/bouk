import 'package:caffa/Models/User.dart';
import 'package:caffa/Screens/Home_store/clients_screen.dart';
import 'package:caffa/Screens/Home_store/component/qr_screen.dart';
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

class HomeStoreScreen extends StatefulWidget {
  const HomeStoreScreen({super.key});

  @override
  State<HomeStoreScreen> createState() => _HomeStoreScreenState();
}

class _HomeStoreScreenState extends State<HomeStoreScreen> {
  late List<UserData> futureUserData;
  late int availableCups = 0;

  Future _loadUserData() async {
    // Step 1: Fetch user data from Firestore
    DocumentSnapshot userDataSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(AppSettingsPreferences().id)
        .get();
    Map<String, dynamic> userData =
        userDataSnapshot.data() as Map<String, dynamic>;
    UserData user = UserData.fromMap(userData);
    setState(() {
      AppSettingsPreferences().saveUser(user: user);
    });
    print(AppSettingsPreferences().availableCups);
  }

  Future<List<UserData>> _loadUsers() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('stores')
          .doc(AppSettingsPreferences().id)
          .collection('clients')
          .get();

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
    // TODO: implement initSta
    //  te
    super.initState();
    _loadUserData();
    _loadUsers().then((onValue)
    {
      futureUserData = onValue;
    });

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
                                "${AppSettingsPreferences().name}",
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
                              Image.asset("assets/Group 3147.png"),
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
                        Get.to(QRScanScreen());
                      },
                      child: HomeScreenItem(
                          'assets/qrScanner.json', 'طلب جديد', '')),
                  const SizedBox(
                    width: 15,
                  ),
                  HomeScreenItem('assets/coffeCup.json', 'إجمالي الأكواب',
                      AppSettingsPreferences().availableCups),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.person),
          onPressed: () {
            Get.to(ClientsScreen(users: futureUserData,));
          },
        ),
      ),
    );
  }

  Widget HomeScreenItem(img, text, totalCups) => Container(
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
              style: titilliumRegular.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 2,
            ),
            totalCups != ''
                ? Text(
                    '${totalCups}',
                    style: titilliumRegular.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                  )
                : SizedBox(),
          ],
        ),
      );
}

