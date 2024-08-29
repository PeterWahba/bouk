import 'package:caffa/utils/custom_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget myDivider() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 15),
      child: Container(
        width: double.infinity,
        height: 0.4,
        color: Colors.grey,
      ),
    );



Widget defaultFormFeild({
  var cursorColor=Colors.black,
  var color=Colors.white,
  var borderColor=Colors.white,
  required String validatorText,
  required var controller,
  required var inputType,
  suffixIcon ,
  suffixPressed,
  required Icon prefixIcon ,
  required String labelText,
  bool isObsecured=false,
  onTap,
  context

})=>TextFormField(
  cursorColor: cursorColor,
  onChanged: onTap,
  validator: (value){
    if(value!.isEmpty)
    {return validatorText;}
    return null;
  },
  controller: controller,
  keyboardType: inputType,
  obscureText: isObsecured,
  decoration: InputDecoration(
    labelStyle: titilliumRegular.copyWith(
      fontSize: 18.sp,
      color: color,
      fontWeight: FontWeight.w700,
    ),
    filled: true,
    fillColor: Colors.white.withOpacity(0),
    enabledBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(40.0),
      borderSide: BorderSide(
        color: borderColor.withOpacity(.5),
        width: 1,
      ),
    ),
    labelText: labelText,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,


  ),
);



Widget buildListTile(String title, icon,tabHandler) {
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
            leading: Icon(
              icon,
              size: 20,
            ),
            title: Text(
              title,
              style: titilliumRegular.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 16.sp
              ),
            ),
            onTap:tabHandler,
          ),
        ),
      ),
    ),
  );
}
