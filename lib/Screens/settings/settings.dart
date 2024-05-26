import 'package:caffa/fb-controllers/fb_auth_controller.dart';
import 'package:caffa/utils/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'change_password.dart';
import 'components/components.dart';
import 'edit_profile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with Helpers {
  @override
  Widget build(BuildContext context) {
    bool _hasInternet = false;

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
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            buildListTile(
                // Colors.black,
                "تعديل بيانات الحساب",
                Icons.edit_outlined, () {
              Get.to(() => EditProfileScreen());
            }),
            buildListTile(
                // Colors.black,
                "تغيير كلمة المرور",
                Icons.lock_outlined, () {
              Get.to(() => ChangePasswordScreen());
            }),
            buildListTile(
                // Colors.black,
                "حذف حسابي",
                Icons.delete_outline_outlined, () async {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        elevation: 24.0,
                        title: const Text('هل أنت متأكد'),
                        content: const Text('لن تسطيع استرجاع الحساب مجدداً'),
                        actions: [
                          CupertinoDialogAction(
                            child: Text(
                              'حذف',
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () {
                              setState(() {
                                var user = FirebaseAuth.instance.currentUser;
                                if (user != null) {
                                  user.delete().then((value) async {
                                    showSnackBar(
                                        context: context,
                                        message: 'تم حذف الحساب بنجاح');
                                    FbAuthController().signOut();
                                  }).catchError((onError) {
                                    showSnackBar(
                                        context: context,
                                        message: '$onError',
                                        error: true);
                                  });
                                }
                              });
                              Navigator.pop(context);
                            },
                          ),
                          myDivider(),
                          CupertinoDialogAction(
                            child: Text('إلغاء'),
                            onPressed: () {
                              setState(() {});
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ));
            }),
          ],
        ),
      ),
    );
  }
}
