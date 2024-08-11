import 'package:caffa/Models/Store.dart';
import 'package:caffa/Models/User.dart';
import 'package:caffa/Screens/Details/details_screen.dart';
import 'package:caffa/Shared%20preferences/shared_preferences.dart';
import 'package:caffa/basket_controller/basket_controller.dart';
import 'package:caffa/utils/helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'alert_dialoge.dart';
import 'basket_products.dart';
import 'basket_salary.dart';

class BasketSection extends StatefulWidget with Helpers {
  BasketSection(
      {Key? key, required this.firstCategoryName, required this.storeData})
      : super(key: key);
  final BasketController controller = Get.put(BasketController());

  final String firstCategoryName;
  final StoreData storeData;
  late bool isTapped = false;
  @override
  State<BasketSection> createState() => _BasketSectionState();
}

class _BasketSectionState extends State<BasketSection> {
  final BasketController controller = Get.put(BasketController());

  Future _loadUserData() async {
    int availableCups = AppSettingsPreferences().availableCups;

    Future.delayed(Duration(seconds: 5)).then((value) async {
      // Step 1: Fetch user data from Firestore
      DocumentSnapshot userDataSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(AppSettingsPreferences().id)
          .collection('stores')
          .doc(widget.storeData.id)
          .get();

      // Map<String, dynamic> userData =
      //     userDataSnapshot.data() as Map<String, dynamic>;
      // UserData user = UserData.fromMap(userData);
      print(userDataSnapshot.data());
      setState(() {
        AppSettingsPreferences().setAvailableCups(
            availableCups: userDataSnapshot.get('availableCups') ?? 0);
      });


      print(AppSettingsPreferences().availableCups);
      if (availableCups != AppSettingsPreferences().availableCups&& widget.isTapped ) {
        print('object');

        ///TODO
        // Get.to(DetailsScreen(storeData: user));
        controller.deleteCartProducts(context);
      }

    });
  }

  @override
  void initState() {
    // TODO: implement initSta
    //  te
    // setState(() {
    //   widget.isFirst = false;
    // });
    super.initState();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    _loadUserData();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          BasketProducts(
            firstCategoryName: widget.firstCategoryName,
          ),
          BasketSalary(
            totalPrice: 100,
            feesPrice: 20,
          ),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                if (AppSettingsPreferences().availableCups <
                    controller.totalCubs) {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return alertDialog(
                          imageSrc: 'assets/failed.json',
                          text:
                              'رصيدك الحالى من الأكواب لا يكفي من فضلك قم بشراء بطاقة أكواب جديدة',
                          isQRCode: false,
                        );
                      });
                } else
                {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return alertDialog(
                          imageSrc: 'assets/coffe.png',
                          text: 'قم بالإسترداد فى المقهى',
                          isQRCode: true,
                        );
                      });
                  setState(() {
                    widget.isTapped = true;
                  });
                }

              },
              child: Text(
                "أطلب الآن",
                style: GoogleFonts.almarai(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(300.w, 60.h),
                backgroundColor: Color(0XFF2D005D),
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.r),
                ),
                alignment: Alignment.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
