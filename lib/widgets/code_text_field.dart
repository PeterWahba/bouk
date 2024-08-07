import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CodeTextField extends StatelessWidget {
  final TextEditingController codeTextController;
  final FocusNode focusNode;
  final void Function(String value) onChange;

  CodeTextField({
    required this.codeTextController,
    required this.focusNode,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 49.h,
      width: 50.w,
      child: TextField(
        controller: codeTextController,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        onChanged: onChange,
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: Color(0XFFF2F2F2),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(17.r),
              borderSide: BorderSide(color: Colors.white, width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(17.r),
              borderSide: BorderSide(color: Color(0XFF13362A), width: 1)),
        ),
      ),
    );
  }
}
