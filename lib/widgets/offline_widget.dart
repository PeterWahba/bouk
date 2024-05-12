import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class OfflineWidget extends StatelessWidget {
  const OfflineWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/no-internet.json'),
            SizedBox(height: 80.h),
            Text(
              "لا يوجد اتصال بالإنترنت",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 40.h),
            Text(
              "فشل الاتصال بالإنترنت، يرجى التحقق من اتصال شبكة هاتفك",
              maxLines: 3,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge,
            )
          ],
        ),
      ),
    );
  }
}
