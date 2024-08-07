import 'package:flutter/material.dart';

Widget defaultFormFeild0({
  var cursorColor = Colors.black,
  var color = Colors.black,
  var borderColor = Colors.black,
  required String validatorText,
  required var controller,
  required var inputType,
  IconButton? suffixIcon,
  Function? suffixPressed,
  Icon? prefixIcon,
  required String labelText,
  bool isObsecured = false,
  context,
  int? maxLines,
}) =>
    TextFormField(
      maxLines: maxLines,
      cursorColor: cursorColor,
      validator: (value) {
        if (value!.isEmpty) {
          return validatorText;
        }
        return null;
      },
      controller: controller,
      keyboardType: inputType,
      obscureText: isObsecured,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        filled: true,
        fillColor: Colors.black.withOpacity(0),
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
