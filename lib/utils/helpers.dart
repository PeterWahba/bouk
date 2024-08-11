import 'package:flutter/material.dart';

import 'custom_themes.dart';

mixin Helpers{
  void showSnackBar({required BuildContext context,required String message, bool error = false}){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message,style: titilliumRegular),
        backgroundColor: error ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: Duration(milliseconds: 700),
      )
    );
  }

  double mediaQueryHeight(context) => MediaQuery.of(context).size.height;
  double mediaQueryWidth(context) => MediaQuery.of(context).size.width;

  Color offWhite = Color(0xFFF2F3F8);
  Color offBlue = Color(0xFF1D71B8);


}