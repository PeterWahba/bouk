import 'package:caffa/Shared%20preferences/shared_preferences.dart';
import 'package:caffa/basket_controller/basket_controller.dart';
import 'package:caffa/utils/custom_themes.dart';
import 'package:caffa/utils/helpers.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BasketSalary extends StatefulWidget {
  BasketSalary({Key? key, required this.totalPrice, required this.feesPrice})
      : super(key: key);
  final double totalPrice;
  final double feesPrice;

  @override
  State<BasketSalary> createState() => _BasketSalaryState();
}

class _BasketSalaryState extends State<BasketSalary> with Helpers {
  final BasketController controller = Get.put(BasketController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "اجمالي عدد الأكواب المطلوبة",
                style: titilliumRegular.copyWith(fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
              ),
              Spacer(),
              Text(
                controller.totalCubs.toString(),
                style: titilliumRegular.copyWith(fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: mediaQueryHeight(context) / 50),
          DottedLine(dashColor: Colors.grey, dashLength: 11, dashGapLength: 10),
          SizedBox(height: mediaQueryHeight(context) / 50),
          Row(
            children: [
              Text(
                "اجمالي عدد الأكواب المتاحة ",
                style: titilliumRegular.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                    color: Colors.green),
              ),
              Spacer(),
              Text(
                '${controller.availableCups??0}',
                style: titilliumRegular.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                    color: Colors.green),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
