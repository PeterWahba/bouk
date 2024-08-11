import 'package:caffa/Screens/Auth/auth_screen.dart';
import 'package:caffa/Screens/Coffee/Auth/auth_screen.dart';
import 'package:caffa/utils/custom_themes.dart';
import 'package:caffa/utils/helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreenCoffee extends StatefulWidget {
  const RegisterScreenCoffee({super.key});

  @override
  State<RegisterScreenCoffee> createState() => _RegisterScreenCoffeeState();
}

class _RegisterScreenCoffeeState extends State<RegisterScreenCoffee>
    with Helpers {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _phoneController1;
  late TextEditingController _passwordController;
  late TextEditingController _addressController; // Controller for address

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _phoneController1 = TextEditingController();
    _passwordController = TextEditingController();
    _addressController =
        TextEditingController(); // Initialize address controller
    _getCurrentLocationAndAddress(); // Fetch address on page load
  }

  Future<void> _getCurrentLocationAndAddress() async {
    try {
      // Check for location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      // Get the current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Get the address from the coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        String fullAddress =
            "${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}";

        // Set the address in the TextField
        setState(() {
          _addressController.text = fullAddress;
        });
      }
    } catch (e) {
      print("Error fetching location: $e");
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _phoneController1.dispose();
    _passwordController.dispose();
    _addressController.dispose(); // Dispose address controller
    super.dispose();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _registerUser(BuildContext context) async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    print(_phoneController.text);
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 80.0,
              ),
            );
          },
        );
        // Create the user with email and password
        final UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // After sending OTP, save user data in Firestore
        final User? user = userCredential.user;
        if (user != null) {
          await _firestore.collection('users').doc(user.uid).set({
            'phoneNumber': _phoneController.text,
            'name': _nameController.text,
            'email': _emailController.text,
            'password': _passwordController.text,
            'id': user.uid,
            'userType': 'store',
            'isActive': false,
            // 'latitude': position.latitude,
            // 'longitude': position.longitude,
            // Add any other stores data you want to save
          }).then((onValue) async {
            await _firestore.collection('stores').doc(user.uid).set({
              'phoneNumber': _phoneController.text,
              'name': _nameController.text,
              'email': _emailController.text,
              'password': _passwordController.text,
              'id': user.uid,
              'userType': 'store',
              'image': '',
              'isActive': false
              // 'latitude': position.latitude,
              // 'longitude': position.longitude,
              // Add any other user data you want to save
            });
          }).then((onValue) {
            Get.offAll(() => AuthScreen(), transition: Transition.cupertino);
          });
        }
      } catch (e) {
        showSnackBar(
            context: context,
            message: 'Registration failed. Please try again.',
            error: true);
      } finally {
        // Close the dialog when done
        // Navigator.of(context).pop();
      }
    } else {
      // Handle empty email or password case
      print('Error: Email or password is empty');
      showSnackBar(
          context: context,
          message: 'Please enter valid email and password.',
          error: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0XFF2D005D),
              Color(0xFF7B1FA2),
            ],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60.h,
                ),
                RichText(
                  text: TextSpan(
                    style: titilliumRegular.copyWith(
                        fontSize: 18.sp, color: Colors.white),
                    children: <TextSpan>[
                      TextSpan(
                        text: "انضم إلى مجتمع القهوة:",
                        style: titilliumRegular.copyWith(
                          fontSize: 20.sp,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: " سجل الآن!",
                        style: titilliumRegular.copyWith(
                          fontSize: 14.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 12.h,
                // ),
                // Padding(
                //   padding: EdgeInsets.only(right: 35.w, left: 32.w),
                //   child: Text(
                //     "انغمس في المزيج المثالي من النكهة والأجواء، حيث يحكي كل كوب قصة من الحرفية والتواصل مع المجتمع.",
                //     style: titilliumRegular.copyWith(
                //       fontSize: 14.sp,
                //       color: Color(0XFFBCBCBC),
                //     ),
                //     textAlign: TextAlign.center,
                //   ),
                // ),
                SizedBox(
                  height: 50.h,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 28.w),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "قم بتسجيل المقهى",
                      style: titilliumRegular.copyWith(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
                SizedBox(
                  height: 26.h,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    maxLines: 1,
                    cursorHeight: 25.h,
                    textDirection: TextDirection.ltr,
                    style: titilliumRegular.copyWith(color: Colors.white),
                    controller: _nameController,
                    decoration: InputDecoration(
                      prefixIcon: SvgPicture.asset(
                        "assets/Frame 1 (3).svg",
                        color: Colors.white,
                        width: 24.w,
                        height: 24.h,
                        fit: BoxFit.scaleDown,
                      ),
                      contentPadding: const EdgeInsets.all(10),
                      counterText: "",
                      labelText: "إسم المقهى",
                      labelStyle: titilliumRegular.copyWith(
                          color: Colors.white, fontSize: 14.sp),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,

                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0XFFE3E3CE),
                        ),
                      ),
                      // focusColor: Color(0XFF22A45D),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0XFFE3E3CE),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 19.h,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    maxLines: 1,
                    cursorHeight: 25.h,
                    textDirection: TextDirection.ltr,
                    style: titilliumRegular.copyWith(color: Colors.white),
                    controller: _emailController,
                    decoration: InputDecoration(
                      prefixIcon: SvgPicture.asset(
                        "assets/Frame 1 (1).svg",
                        color: Colors.white,
                        width: 24.w,
                        height: 24.h,
                        fit: BoxFit.scaleDown,
                      ),
                      contentPadding: const EdgeInsets.all(10),
                      counterText: "",
                      labelText: "الإيميل الإلكتروني",
                      labelStyle: titilliumRegular.copyWith(
                          color: Colors.white, fontSize: 14.sp),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,

                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0XFFE3E3CE),
                        ),
                      ),
                      // focusColor: Color(0XFF22A45D),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0XFFE3E3CE),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 19.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    maxLines: 1,
                    cursorHeight: 25.h,
                    textDirection: TextDirection.ltr,
                    style: titilliumRegular.copyWith(color: Colors.white),
                    controller: _phoneController,
                    decoration: InputDecoration(
                      prefixIcon: SvgPicture.asset(
                        "assets/Frame 1 (4).svg",
                        color: Colors.white,
                        width: 24.w,
                        height: 24.h,
                        fit: BoxFit.scaleDown,
                      ),
                      contentPadding: const EdgeInsets.all(10),
                      counterText: "",
                      labelText: " رقم الهاتف +966",
                      labelStyle: titilliumRegular.copyWith(
                          color: Colors.white, fontSize: 14.sp),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,

                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0XFFE3E3CE),
                        ),
                      ),
                      // focusColor: Color(0XFF22A45D),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0XFFE3E3CE),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 19.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    maxLines: 1,
                    cursorHeight: 25.h,
                    textDirection: TextDirection.ltr,
                    style: titilliumRegular.copyWith(color: Colors.white),
                    controller: _phoneController1,
                    decoration: InputDecoration(
                      prefixIcon: SvgPicture.asset(
                        "assets/123.svg",
                        color: Colors.white,
                        width: 24.w,
                        height: 24.h,
                        fit: BoxFit.scaleDown,
                      ),
                      contentPadding: const EdgeInsets.all(10),
                      counterText: "",
                      labelText: "رقم الرخصة التجارية",
                      labelStyle: titilliumRegular.copyWith(
                          color: Colors.white, fontSize: 14.sp),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,

                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0XFFE3E3CE),
                        ),
                      ),
                      // focusColor: Color(0XFF22A45D),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0XFFE3E3CE),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 19.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    maxLines: 1,
                    cursorHeight: 25.h,
                    textDirection: TextDirection.ltr,
                    style: titilliumRegular.copyWith(color: Colors.white),
                    controller: _addressController,
                    decoration: InputDecoration(
                      prefixIcon: SvgPicture.asset(
                        "assets/123.svg",
                        color: Colors.white,
                        width: 24.w,
                        height: 24.h,
                        fit: BoxFit.scaleDown,
                      ),
                      contentPadding: const EdgeInsets.all(10),
                      counterText: "",
                      labelText: "العنوان",
                      labelStyle: titilliumRegular.copyWith(
                          color: Colors.white, fontSize: 14.sp),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,

                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0XFFE3E3CE),
                        ),
                      ),
                      // focusColor: Color(0XFF22A45D),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0XFFE3E3CE),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 19.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    maxLines: 1,
                    cursorHeight: 25.h,
                    textDirection: TextDirection.ltr,
                    style: titilliumRegular.copyWith(color: Colors.white),
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: SvgPicture.asset(
                        "assets/Frame 1 (2).svg",
                        color: Colors.white,
                        width: 24.w,
                        height: 24.h,
                        fit: BoxFit.scaleDown,
                      ),
                      contentPadding: const EdgeInsets.all(10),
                      counterText: "",
                      labelText: "كلمة السر",
                      labelStyle: titilliumRegular.copyWith(
                          color: Colors.white, fontSize: 14.sp),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,

                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0XFFE3E3CE),
                        ),
                      ),
                      // focusColor: Color(0XFF22A45D),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0XFFE3E3CE),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 33.h,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_nameController.text.isNotEmpty &&
                        _emailController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty
                        // && _phoneController.text.isNotEmpty
                    ) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Center(
                            child: SpinKitFadingCircle(
                              color: Colors.blue,
                              size: 80.0,
                            ),
                          );
                        },
                      );

                      _registerUser(context);
                      // Get.back();
                    } else {
                      showSnackBar(
                          context: context,
                          message: "أدخل البيانات المطلوبة",
                          error: true);
                    }
                  },
                  child: Text(
                    "إنشاء حساب",
                    style: titilliumRegular.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(318.w, 60.h),
                    backgroundColor: Color(0XFF2D005D),
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    alignment: Alignment.center,
                  ),
                ),
                // SizedBox(
                //   height: 18.h,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Container(
                //       height: 1.h,
                //       width: 93.w,
                //       color: Color(0XFFD9D9BC),
                //     ),
                //     SizedBox(
                //       width: 23.w,
                //     ),
                //     Text(
                //       "أو الاستمرار مع",
                //       style: titilliumRegular.copyWith(
                //         fontSize: 14.sp,
                //         fontWeight: FontWeight.bold,
                //         color: Color(0XFFBCBCBC),
                //       ),
                //     ),
                //     SizedBox(
                //       width: 23.w,
                //     ),
                //     Container(
                //       height: 1.h,
                //       width: 93.w,
                //       color: Color(0XFFD9D9BC),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: 18.h,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Container(
                //       height: 35.h,
                //       width: 100.w,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(53.r),
                //         border: Border.all(
                //           color: Color(0XFFEDEDED),
                //         ),
                //       ),
                //       child: Center(
                //         child: Image.asset(
                //           "assets/Rectangle 9 (2).png",
                //           width: 25.w,
                //           height: 25.h,
                //           fit: BoxFit.scaleDown,
                //         ),
                //       ),
                //     ),
                //     SizedBox(
                //       width: 23.w,
                //     ),
                //     Container(
                //       height: 35.h,
                //       width: 100.w,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(53.r),
                //         border: Border.all(
                //           color: Color(0XFFEDEDED),
                //         ),
                //       ),
                //       child: Center(
                //         child: Image.asset(
                //           "assets/Rectangle 9.png",
                //           width: 25.w,
                //           height: 25.h,
                //           fit: BoxFit.scaleDown,
                //         ),
                //       ),
                //     ),
                //     SizedBox(
                //       width: 23.w,
                //     ),
                //     Container(
                //       height: 35.h,
                //       width: 100.w,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(53.r),
                //         border: Border.all(
                //           color: Color(0XFFEDEDED),
                //         ),
                //       ),
                //       child: Center(
                //         child: Image.asset(
                //           "assets/Rectangle 9 (3).png",
                //           width: 25.w,
                //           height: 25.h,
                //           fit: BoxFit.scaleDown,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: 25.h,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => AuthScreen(),
                        transition: Transition.circularReveal);
                  },
                  child: RichText(
                    text: TextSpan(
                      style: titilliumRegular.copyWith(
                          fontSize: 18.sp, color: Colors.white),
                      children: <TextSpan>[
                        TextSpan(
                          text: "هل لديك حساب؟",
                          style: titilliumRegular.copyWith(
                            fontSize: 14.sp,
                            color: Color(0XFFBCBCBC),
                          ),
                        ),
                        TextSpan(
                          text: " تسجيل الدخول",
                          style: titilliumRegular.copyWith(
                            fontSize: 14.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
