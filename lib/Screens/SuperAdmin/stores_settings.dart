import 'package:caffa/utils/custom_themes.dart';
import 'package:caffa/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'active_stores_screen.dart';
import 'non_active_store_screen.dart';

class StoreSettingsScreen extends StatefulWidget {
  const StoreSettingsScreen({super.key});

  @override
  State<StoreSettingsScreen> createState() => _StoreSettingsScreenState();
}

class _StoreSettingsScreenState extends State<StoreSettingsScreen> {

  @override
  void initState() {
    // TODO: implement initSta
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(context: context, title: 'إدارة المقاهي', isHomeScreen: false),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    Get.to(ActiveStoresScreen());
                  },
                  child: HomeScreenItem(
                      'assets/notActive.json', 'المقاهي النشطه')),
              const SizedBox(
                width: 15,
              ),
              InkWell(
                  onTap: () {
                    Get.to(NonActiveStoresScreen());
                  },
                  child: HomeScreenItem(
                      'assets/active.json', 'المقاهي الغير النشطه')),            ],
          ),
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
          width: MediaQuery.of(context).size.width * .28,
          height: MediaQuery.of(context).size.height * .13,
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

