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
import 'package:caffa/widgets/custom_image.dart';
import 'package:caffa/widgets/def_formFeild.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:radio_grouped_buttons/radio_grouped_buttons.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.storeData});

  final StoreData storeData;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> with Helpers {
  /// horizontal list of buttons
  List<String> buttonList = ['قهوة اليوم حار', 'قهوة اليوم بارد'];
  var recordController = TextEditingController();
  final BasketController controller = Get.put(BasketController());
  double oldPurchasedPrice = 0;

  Future _loadUserData() async {
    // Fetch user data from Firestore
    DocumentSnapshot userDataSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(AppSettingsPreferences().id)
        .collection('stores')
        .doc(widget.storeData.id)
        .get();

    setState(() {
      AppSettingsPreferences().setAvailableCups(
          availableCups: userDataSnapshot.get('availableCups') ?? 0);
      oldPurchasedPrice = userDataSnapshot.get('price') ?? 0;
    });
    controller.setAvailableCups(userDataSnapshot.get('availableCups'));
  }

  @override
  void initState() {
    super.initState();
    if (!AppSettingsPreferences().isGuest) _loadUserData();
  }

  void launchMapsUrl(double lat, double lon) async {
    final url =
        Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lon');
    if (await canLaunchUrl(url)) {
      try {
        await launchUrl(url);
      } catch (e) {
        print('Error launching URL: $e');
      }
    } else {
      print('Could not launch URL: $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.storeData.name == 'دانكن') {
      buttonList = ['بلاك كوفي بارد', 'بلاك كوفي حار'];
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  CustomImage(
                    image: widget.storeData.image!,
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
                    "معلومات المقهى",
                    style: titilliumRegular.copyWith(
                      fontSize: 15.sp,
                      color: Color(0XFF2D005D),
                    ),
                  ),
                  Spacer(),
                  Text(
                    widget.storeData.name!,
                    style: titilliumRegular.copyWith(
                      fontSize: 15.w,
                      color: Color(0XFFA8A8A8),
                    ),
                  ),
                  SizedBox(
                    width: 23.w,
                  ),
                ],
              ),
              InkWell(
                  onTap: () {
                    launchMapsUrl(widget.storeData.latitude!,
                        widget.storeData.longitude!);
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 23.w,
                      ),
                      Row(
                        children: [
                          Text(
                            "الموقع",
                            style: titilliumRegular.copyWith(
                              fontSize: 15.sp,
                              color: Color(0XFF2D005D),
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Icon(
                            Icons.location_on_outlined,
                            color: Color(0XFF2D005D),
                            size: 20.sp,
                          ),
                        ],
                      ),
                      Spacer(),
                      Text(
                        widget.storeData.address ?? 'أحلى مقهى قريب منك.',
                        style: titilliumRegular.copyWith(
                          fontSize: 15.w,
                          color: Color(0XFFA8A8A8),
                        ),
                      ),
                      SizedBox(
                        width: 23.w,
                      ),
                    ],
                  )),
              SizedBox(
                height: 15.h,
              ),
              Container(
                height: 5.h,
                width: double.infinity,
                color: Color(0XFFF8F8F8),
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomRadioButton(
                    buttonLables: buttonList,
                    buttonValues: buttonList,
                    buttonHeight: 50.h,
                    buttonWidth: 160.w,
                    fontSize: 14.sp,
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
                      }
                    },
                    horizontal: true,
                    enableShape: true,
                    buttonSpace: 5,
                    unselectedButtonBorderColor: Color(0XFF2D005D),
                    buttonColor: Colors.white,
                    selectedColor: Color(0XFF2D005D),
                  ),
                ],
              ),
              // Padding(
              //   padding: EdgeInsets.only(top: 25, left: 40.h, right: 40.h),
              //   child: defaultFormFeild0(
              //     maxLines: 1,
              //     inputType: TextInputType.text,
              //     validatorText: 'أكتب طلب آخر',
              //     controller: recordController,
              //     labelText: 'أكتب طلب آخر',
              //   ),
              // ),
              SizedBox(
                height: 31.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Container(
                  padding: EdgeInsets.only(right: 16.0, left: 16.0, top: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "راعي الآوله 22 كوب",
                        style: titilliumRegular.copyWith(
                          fontSize: 15.sp,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0.h),
                      Text(
                        "• اشترك بعدد  22 كوب صالحة لمدة 30 يوم من قهوة اليوم.\n"
                        "•  بالاضافة الى مميزات ونقاط تضاف إلى محفظتك بعدأول عملية شراء.",
                        style: titilliumRegular.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 8.0.h),
                      Column(
                        children: [
                          Divider(
                            color: Colors.grey.withOpacity(.5), // لون الخط
                            thickness: 1.0, // سماكة الخط
                          ),
                          TextButton(
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
                                            AppSettingsPreferences()
                                                .availableCups,
                                        oldPurchasedPrice: oldPurchasedPrice,
                                      ));
                            },
                            child: Text(
                              "احصل عليها الآن",
                              style: titilliumRegular.copyWith(
                                fontSize: 15.sp,
                                // fontWeight: FontWeight.bold,
                                // color: Colors.blue, // لون النص
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Container(
                  padding: EdgeInsets.only(right: 16.0, left: 16.0, top: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "أجاويد 32 كوب",
                        style: titilliumRegular.copyWith(
                          fontSize: 15.sp,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0.h),
                      Text(
                        "• اشترك بعدد  32 كوب صالحة لمدة 30 يوم من قهوة اليوم.\n"
                        "•  بالاضافة الى مميزات ونقاط تضاف إلى محفظتك بعدأول عملية شراء.",
                        style: titilliumRegular.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 8.0.h),
                      Column(
                        children: [
                          Divider(
                            color: Colors.grey.withOpacity(.5), // لون الخط
                            thickness: 1.0, // سماكة الخط
                          ),
                          TextButton(
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
                                            AppSettingsPreferences()
                                                .availableCups,
                                        oldPurchasedPrice: oldPurchasedPrice,
                                      ));
                            },
                            child: Text(
                              "احصل عليها الآن",
                              style: titilliumRegular.copyWith(
                                fontSize: 15.sp,
                                // fontWeight: FontWeight.bold,
                                // color: Colors.blue, // لون النص
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),

              // ElevatedButton(
              //   onPressed: () {
              //     AppSettingsPreferences().isGuest
              //         ? Get.to(() => GuestScreen(
              //               isHomeScreen: false,
              //               appBarHeader: 'الدفع',
              //             ))
              //         : Get.to(() => CheckOutScreen(
              //               cups: 32,
              //               price: 32,
              //               storeData: widget.storeData,
              //               oldAvailableCups:
              //                   AppSettingsPreferences().availableCups,
              //               oldPurchasedPrice: oldPurchasedPrice,
              //             ));
              //   },
              //   child: Text(
              //     "أجاويد 32 كوب",
              //     style: titilliumRegular.copyWith(
              //       fontSize: 15.sp,
              //       fontWeight: FontWeight.bold,
              //       color: Color(0XFF2D005D),
              //     ),
              //   ),
              //   style: ElevatedButton.styleFrom(
              //     minimumSize: Size(300.w, 60.h),
              //     backgroundColor: Colors.transparent,
              //     shadowColor: Colors.transparent,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(100.r),
              //       side: BorderSide(
              //         color: Color(0XFF2D005D),
              //         width: 2.w,
              //       ),
              //     ),
              //     alignment: Alignment.center,
              //   ),
              // ),
              // SizedBox(
              //   height: 30.h,
              // )
            ],
          ),
        ),
      ),
    );
  }
}
