import 'dart:io';
import 'package:caffa/Models/Store.dart';
import 'package:caffa/Models/User.dart';
import 'package:caffa/Shared%20preferences/shared_preferences.dart';
import 'package:caffa/utils/custom_themes.dart';
import 'package:caffa/utils/helpers.dart';
import 'package:caffa/widgets/custom_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';  // إضافة مكتبة اختيار الصور
import 'package:lottie/lottie.dart';
import 'package:firebase_storage/firebase_storage.dart'; // إضافة مكتبة Firebase Storage
import '../../widgets/custom_appbar.dart';
import '../../widgets/components.dart';

class EditProfileScreen extends StatefulWidget {
  final bool isHomeStore;

  const EditProfileScreen({super.key, this.isHomeStore = false});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> with Helpers {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var state;
  UserData? userDate;
  StoreData? store;
  String? image; // متغير لتخزين رابط الصورة المرفوعة

  // وظيفة لاختيار الصورة ورفعها
  Future<void> pickAndUploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      String fileName = pickedFile.name;
      Reference storageReference =
      FirebaseStorage.instance.ref().child('store_images/$fileName');
      UploadTask uploadTask = storageReference.putFile(File(pickedFile.path));
      await uploadTask.whenComplete(() async {
        String imageUrl = await storageReference.getDownloadURL();
        setState(() {
          image = imageUrl; // حفظ رابط الصورة في المتغير
        });
        showSnackBar(context: context, message: 'تم رفع الصورة بنجاح');
      });
    } else {
      showSnackBar(
          context: context, message: 'لم يتم اختيار أي صورة', error: true);
    }
  }

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

  Future<void> updateStoreData({
    required String name,
    required String phone,
    required String image,
  }) async {
    setState(() {
      state = 'loading';
    });

    FirebaseFirestore.instance
        .collection('stores')
        .doc(AppSettingsPreferences().id)
        .update({
      'name': nameController.text.trim(),
      'phoneNumber': phoneController.text.trim(),
      'image': image,
    }).then((value) async {
      DocumentSnapshot userDataSnapshot = await FirebaseFirestore.instance
          .collection('stores')
          .doc(AppSettingsPreferences().id)
          .get();
      Map<String, dynamic> userData =
      userDataSnapshot.data() as Map<String, dynamic>;
      store = StoreData.fromMap(userData);
      AppSettingsPreferences().saveStore(store: store!);
      setState(() {
        nameController.text = AppSettingsPreferences().name;
        phoneController.text = AppSettingsPreferences().phoneNumber;
      });

      setState(() {
        state = 'success';
      });
      _loadUserData();
      showSnackBar(context: context, message: 'تم تحديث البيانات بنجاح');
    }).catchError((onError) {
      setState(() {
        state = 'error';
      });
      showSnackBar(context: context, message: onError.toString(), error: true);
    });
  }

  Future _loadUserData() async {
    // Step 1: Fetch user data from Firestore
    DocumentSnapshot userDataSnapshot = await FirebaseFirestore.instance
        .collection('stores')
        .doc(AppSettingsPreferences().id)
        .get();
    Map<String, dynamic> userData =
    userDataSnapshot.data() as Map<String, dynamic>;
    setState(() {
      store = StoreData.fromMap(userData);
      AppSettingsPreferences().saveStore(store: store!);
      print("Store data loaded: ${store!.name}");
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.isHomeStore) {
      _loadUserData();
    }
    nameController.text = AppSettingsPreferences().name;
    phoneController.text = AppSettingsPreferences().phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // عرض مؤشر تحميل إذا كانت البيانات لم تُحمَّل بعد
    if (widget.isHomeStore && store == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // استعراض البيانات بعد تحميلها
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(context: context, title: 'الإعدادات', isHomeScreen: false),
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
                  style: titilliumRegular.copyWith(
                    color: Colors.black,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: size.height * .03,
                ),
                widget.isHomeStore
                    ? GestureDetector(
                  onTap: pickAndUploadImage, // اختيار ورفع الصورة
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: image != null
                        ? SizedBox(height:250.h,child: CustomImage(image: image!))
                        : SizedBox(height:250.h,child:CustomImage(image: store!.image!)),
                  ),
                )
                    : CircleAvatar(
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
                        if (widget.isHomeStore) {
                          updateStoreData(
                            name: nameController.text.trim(),
                            phone: phoneController.text.trim(),
                            image: image ?? store!.image!,
                          );
                        } else {
                          updateUserData(
                            name: nameController.text.trim(),
                            phone: phoneController.text.trim(),
                          );
                        }
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
