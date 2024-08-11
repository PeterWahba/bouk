import 'package:caffa/utils/custom_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


PreferredSizeWidget CustomAppBar({
  required BuildContext context,
  required String title,
  required bool isHomeScreen,
}) =>
    AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      title: Text(title,
          style: titilliumRegular.copyWith(
              fontWeight: FontWeight.bold, color: Colors.white,fontSize: 20.sp)),
      centerTitle: true,
      backgroundColor: Color(0XFF2D005D),
      elevation: 0.0,
      automaticallyImplyLeading: true,
      leading:!isHomeScreen? IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back),
      ):SizedBox(),

      actions:[],
    );
