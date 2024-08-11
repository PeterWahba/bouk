import 'package:caffa/Models/Store.dart';
import 'package:caffa/Models/User.dart';
import 'package:caffa/Screens/CheckOut/checkout_screen.dart';
import 'package:caffa/Screens/GuestMode/guest_screen.dart';
import 'package:caffa/Screens/basket/presentation/basket_screen.dart';
import 'package:caffa/Shared%20preferences/shared_preferences.dart';
import 'package:caffa/basket_controller/basket_controller.dart';
import 'package:caffa/basket_controller/basket_model.dart';
import 'package:caffa/utils/custom_themes.dart';
import 'package:caffa/utils/helpers.dart';
import 'package:caffa/widgets/def_formFeild.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:radio_grouped_buttons/radio_grouped_buttons.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.storeData});

  final StoreData storeData;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> with Helpers {
  ///horizontal list of buttons
  List<String> buttonList = ['قهوة اليوم حار', 'قهوة اليوم بارد'];
  var recordController = TextEditingController();
  final BasketController controller = Get.put(BasketController());
  double oldPurchasedPrice = 0;

  Future _loadUserData() async {
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
      oldPurchasedPrice = userDataSnapshot.get('price') ?? 0;
    });
    controller.setAvailableCups(userDataSnapshot.get('availableCups'));
    print(AppSettingsPreferences().availableCups);
  }

  @override
  void initState() {
    // TODO: implement initSta
    //  te
    // setState(() {
    //   widget.isFirst = false;
    // });
    super.initState();
    if (!AppSettingsPreferences().isGuest) _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.storeData.name == 'دانكن')
      buttonList = ['بلاك كوفي بارد', 'بلاك كوفي حار'];
    return SafeArea(
        child: Scaffold(
      // backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Image.network(
                  widget.storeData.image!,
                  height: 292.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    width: 50.w,
                    height: 50.h,
                    margin: EdgeInsets.only(top: 32.h, right: 23.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: SvgPicture.asset(
                      "assets/Frame 2 (1).svg",
                      width: 24.w,
                      height: 24.h,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                Positioned(
                  left: 23.w,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      width: 50.w,
                      height: 50.h,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 32.h),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: SvgPicture.asset(
                        "assets/heart.svg",
                        width: 24.w,
                        height: 24.h,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 80.w,
                  child: InkWell(
                    onTap: () async {
                      AppSettingsPreferences().isGuest
                          ? Get.to(() => GuestScreen(
                                isHomeScreen: false,
                                appBarHeader: 'سلة المشتريات',
                              ))
                          : Get.to(() => BasketScreen(
                                isHomeScreen: false,
                                storeData: widget.storeData,
                              ));

                      // Step 1: Fetch user data from Firestore
                      DocumentSnapshot userDataSnapshot =
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(AppSettingsPreferences().id)
                              .get();
                      Map<String, dynamic> userData =
                          userDataSnapshot.data() as Map<String, dynamic>;
                      UserData user = UserData.fromMap(userData);
                      AppSettingsPreferences().saveUser(user: user);
                    },
                    child: Container(
                      width: 50.w,
                      height: 50.h,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 32.h),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: SvgPicture.asset(
                        "assets/cart.svg",
                        width: 24.w,
                        height: 24.h,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 13.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 23.w,
                ),
                Text(
                  widget.storeData.name!,
                  style: titilliumRegular.copyWith(
                    fontSize: 18.w,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Text(
                  "معلومات المقهى",
                  style: titilliumRegular.copyWith(
                    fontSize: 16.sp,
                    color: Color(0XFF2D005D),
                  ),
                ),
                SizedBox(
                  width: 23.w,
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 23.w,
                ),
                // Text(
                //   "أحلى مقهى قريب منك.",
                //   style: titilliumRegular.copyWith(
                //     fontSize: 16.w,
                //     color: Color(0XFFA8A8A8),
                //   ),
                // ),
                Spacer(),
                Text(
                  "تعليقات",
                  style: titilliumRegular.copyWith(
                    fontSize: 16.sp,
                    color: Color(0XFF2D005D),
                  ),
                ),
                SizedBox(
                  width: 23.w,
                ),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            // Row(
            //   children: [
            //     SizedBox(
            //       width: 23.w,
            //     ),
            //     SvgPicture.asset("assets/star.svg"),
            //     SvgPicture.asset("assets/star.svg"),
            //     SvgPicture.asset("assets/star.svg"),
            //     SvgPicture.asset("assets/star.svg"),
            //     SvgPicture.asset("assets/star.svg"),
            //     SizedBox(
            //       width: 8.w,
            //     ),
            //     Text(
            //       "4.9",
            //       style: titilliumRegular.copyWith(
            //         fontSize: 15.w,
            //         color: Color(0XFFFFA800),
            //       ),
            //     ),
            //   ],
            // ),
            // Row(
            //   children: [
            //     SizedBox(
            //       width: 23.w,
            //     ),
            //     SvgPicture.asset("assets/star (1) 1.svg"),
            //     // SizedBox(
            //     //   width: 6.w,
            //     // ),
            //     // Text(
            //     //   "مفتوح حتى الساعة 2:30 صباحًا",
            //     //   style: titilliumRegular.copyWith(
            //     //     fontSize: 14.w,
            //     //     color: Color(0XFFA8A8A8),
            //     //   ),
            //     // ),
            //   ],
            // ),
            // SizedBox(
            //   height: 15.h,
            // ),
            Container(
              height: 5.h,
              width: double.infinity,
              color: Color(0XFFF8F8F8),
            ),
            SizedBox(
              height: 13.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomRadioButton(
                  buttonLables: buttonList,
                  buttonValues: buttonList,
                  buttonHeight: 50.h,
                  buttonWidth: 160.w,
                  fontSize: 18.sp,
                  radioButtonValue: (value, index) {
                    if (AppSettingsPreferences().isGuest) {
                      showSnackBar(
                          context: context,
                          message: 'برجاء تسجيل الدخول',
                          error: true);
                    } else {
                      controller.AddToCart(
                          productModel: BasketModel(
                              quantity: 1,
                              productId: index,
                              productName: value.toString()));

                      showSnackBar(
                          context: context,
                          message: 'تم الإضافه إلى السلة بنجاح',
                          error: false);
                      print("Button value " + value.toString());
                      print("Integer value " + index.toString());
                    }
                  },
                  horizontal: true,
                  enableShape: true,
                  buttonSpace: 5,
                  unselectedButtonBorderColor: Color(0XFF2D005D),
                  buttonColor: Colors.white,
                  selectedColor: Color(0XFF2D005D),
                ),
                // Spacer(),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 25, left: 40.h, right: 40.h),
              child: defaultFormFeild0(
                maxLines: 1,
                inputType: TextInputType.text,
                validatorText: 'أكتب طلب آخر',
                controller: recordController,
                labelText: 'أكتب طلب آخر',
              ),
            ),
            SizedBox(
              height: 31.h,
            ),
            ElevatedButton(
              onPressed: () {
                AppSettingsPreferences().isGuest
                    ? Get.to(() => GuestScreen(
                          isHomeScreen: false,
                          appBarHeader: 'الدفع',
                        ))
                    : Get.to(() => CheckOutScreen(
                          cups: 22,
                          price: 22,
                          storeData: widget.storeData,
                          oldAvailableCups:
                              AppSettingsPreferences().availableCups,
                          oldPurchasedPrice: oldPurchasedPrice,
                        ));
              },
              child: Text(
                "بطاقة راعي الآوله 22 كوب",
                style: titilliumRegular.copyWith(
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
            SizedBox(
              height: 13.h,
            ),
            ElevatedButton(
              onPressed: () {
                AppSettingsPreferences().isGuest
                    ? Get.to(() => GuestScreen(
                          isHomeScreen: false,
                          appBarHeader: 'الدفع',
                        ))
                    : Get.to(() => CheckOutScreen(
                          cups: 32,
                          price: 32,
                          storeData: widget.storeData,
                          oldAvailableCups:
                              AppSettingsPreferences().availableCups,
                          oldPurchasedPrice: oldPurchasedPrice,
                        ));
              },
              child: Text(
                "بطاقة راعي الآوله 32 كوب",
                style: titilliumRegular.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0XFF2D005D),
                ),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(300.w, 60.h),
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.r),
                  side: BorderSide(
                    color: Color(0XFF2D005D),
                    width: 2.w,
                  ),
                ),
                alignment: Alignment.center,
              ),
            ),
            SizedBox(
              height: 30.h,
            )
          ],
        ),
      ),
    ));
  }
}
