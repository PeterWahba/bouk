import 'package:caffa/Models/User.dart';
import 'package:caffa/Screens/CheckOut/checkout_screen.dart';
import 'package:caffa/Screens/basket/presentation/basket_screen.dart';
import 'package:caffa/Shared%20preferences/shared_preferences.dart';
import 'package:caffa/basket_controller/basket_controller.dart';
import 'package:caffa/basket_controller/basket_model.dart';
import 'package:caffa/utils/helpers.dart';
import 'package:caffa/widgets/def_formFeild.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:radio_grouped_buttons/radio_grouped_buttons.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.userData});

  final UserData userData;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> with Helpers {
  ///horizontal list of buttons
  List<String> buttonList = ['قهوة اليوم حار', 'قهوة اليوم بارد'];
  var recordController = TextEditingController();
  final BasketController controller = Get.put(BasketController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Image.asset(
                  "assets/bouk.jpg",
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
                      Get.to(() => BasketScreen());

                      // Step 1: Fetch user data from Firestore
                      DocumentSnapshot userDataSnapshot = await FirebaseFirestore.instance
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
                      margin: EdgeInsets.only(top: 32.h),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Image.asset(
                        "assets/basket.png",
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
                  'X',
                  style: GoogleFonts.almarai(
                    fontSize: 18.w,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Text(
                  "معلومات المقهى",
                  style: GoogleFonts.almarai(
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
                //   style: GoogleFonts.almarai(
                //     fontSize: 16.w,
                //     color: Color(0XFFA8A8A8),
                //   ),
                // ),
                Spacer(),
                Text(
                  "تعليقات",
                  style: GoogleFonts.almarai(
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
            //       style: GoogleFonts.almarai(
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
            //     //   style: GoogleFonts.almarai(
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
                  fontSize: 18,
                  radioButtonValue: (value, index) {
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
                Get.to(() => CheckOutScreen());
              },
              child: Text(
                "بطاقة 5 أكواب قهوة ب SAR 45",
                style: GoogleFonts.almarai(
                  fontSize: 20.sp,
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
                Get.to(() => CheckOutScreen());
              },
              child: Text(
                "بطاقة 10 أكواب قهوة ب SAR 65",
                style: GoogleFonts.almarai(
                  fontSize: 20.sp,
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
