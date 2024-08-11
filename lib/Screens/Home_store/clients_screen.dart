import 'package:caffa/Models/User.dart';
import 'package:caffa/utils/custom_themes.dart';
import 'package:caffa/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClientsScreen extends StatelessWidget {
  final List<UserData> users;

  const ClientsScreen({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: CustomAppBar(
          context: context, title: 'العملاء الحاليين', isHomeScreen: false),
      body: SingleChildScrollView(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: users.length,
            itemBuilder: (context, index) => buildListTile(
                // Colors.black,
                users[index].name!,
                'عدد الأكواب المتبقية ${users[index].availableCups!}',
                () {})),
      ),
    ));
  }
}

Widget buildListTile(String title, String text, tabHandler) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
    child: Card(
      color: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(10)),
      ),
      elevation: 5.0,
      child: Container(
        // color: Colors.white,
        height: 70,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Text(
              text,
              style: titilliumRegular.copyWith(
                fontFamily: '',
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            trailing: Text(
              title,
              style: titilliumRegular.copyWith(
                fontFamily: '',
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            onTap: tabHandler,
          ),
        ),
      ),
    ),
  );
}
