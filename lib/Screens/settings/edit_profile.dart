import 'package:caffa/Models/User.dart';
import 'package:caffa/Shared%20preferences/shared_preferences.dart';
import 'package:caffa/utils/helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'components/components.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> with Helpers {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var state;
  UserData? userDate;

  Future<void> updateUserData({
    required String name,
    required String phone,
  }) async {
    setState(() {
      state = 'loading';
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(AppSettingsPreferences().id)
        .update({
      'name': nameController.text.trim(),
      'phoneNumber': phoneController.text.trim(),
    }).then((value) async {
      // Step 1: Fetch user data from Firestore
      DocumentSnapshot userDataSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(AppSettingsPreferences().id)
          .get();
      Map<String, dynamic> userData =
          userDataSnapshot.data() as Map<String, dynamic>;
      userDate = UserData.fromMap(userData);
      AppSettingsPreferences().saveUser(user: userDate!);
      setState(() {
        nameController.text = AppSettingsPreferences().name;
        phoneController.text = AppSettingsPreferences().phoneNumber;
      });

      setState(() {
        state = 'success';
      });

      showSnackBar(context: context, message: 'تم تحديث البيانات بنجاح');
    }).catchError((onError) {
      setState(() {
        state = 'error';
      });
      showSnackBar(context: context, message: onError.toString(), error: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (userDate != null &&
        userDate!.name != nameController.text.trim() &&
        userDate!.phoneNumber != phoneController.text.trim()) {
      nameController.text = userDate!.name!;
      phoneController.text = userDate!.phoneNumber!;
    }

    nameController.text = AppSettingsPreferences().name;
    phoneController.text = AppSettingsPreferences().phoneNumber;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            )),
        backgroundColor: Color(0XFF313131),
        title: Text(
          'الإعدادات',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 10,
        actions: const [
          Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Icon(
              Icons.settings_outlined,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  'تعديل بيانات الحساب',
                  style: GoogleFonts.lato(
                    color: Colors.black,
                    textStyle: Theme.of(context).textTheme.headlineMedium,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(
                  height: size.height * .03,
                ),
                CircleAvatar(
                  radius: 80.0.h,
                  backgroundColor: offWhite,
                  child: Lottie.asset('assets/editprofile.json'),
                ),
                SizedBox(
                  height: size.height * .03,
                ),
                defaultFormFeild(
                  borderColor: Colors.black,
                  color: Colors.black,
                  context: context,
                  validatorText: 'الإسم',
                  controller: nameController,
                  inputType: TextInputType.name,
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  labelText: 'الإسم',
                ),

                SizedBox(
                  height: 15.0.h,
                ),
                defaultFormFeild(
                  borderColor: Colors.black,
                  color: Colors.black,
                  context: context,
                  validatorText: 'رقم الهاتف',
                  controller: phoneController,
                  inputType: TextInputType.phone,
                  prefixIcon: Icon(
                    Icons.phone_outlined,
                    color: Colors.black,
                  ),
                  labelText: 'رقم الهاتف',
                ),
                SizedBox(
                  height: 80.h,
                ),
                ConditionalBuilder(
                  condition: state != 'loading',
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        updateUserData(
                            name: nameController.text.trim(),
                            phone: phoneController.text.trim());
                      }
                    },
                    child: Text(
                      "تعديل البيانات",
                      style: GoogleFonts.almarai(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(318.w, 60.h),
                      backgroundColor: Color(0xff2D005D),
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                  fallback: (context) =>
                      Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
