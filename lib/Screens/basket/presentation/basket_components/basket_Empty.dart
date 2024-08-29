import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/emptyCart.json',height: 250.h),
            SizedBox(height: 80.h),
            Text(
              "سلة المشتريات فارغة",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 10.h),
            Text(
              "قم بإضافة بعض المنتجات إلى سلة المشتريات",
              maxLines: 3,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
      ),
    );
  }
}
