import 'package:caffa/basket_controller/basket_controller.dart';
import 'package:caffa/utils/custom_themes.dart';
import 'package:caffa/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Basket extends StatefulWidget {
  Basket(
      {Key? key,
      required this.categoriesName,
      required this.imageSrc,
      required this.index})
      : super(key: key);

  final String categoriesName;
  final String imageSrc;
  final int index;

  @override
  State<Basket> createState() => _BasketState();
}

class _BasketState extends State<Basket> with Helpers {
  final BasketController controller = Get.put(BasketController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 150,
        width: 190,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius:5 ,
              spreadRadius: 2
            )
          ]
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Lottie.asset(
                '${widget.imageSrc}',
                width: 80,
                height: 120,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.categoriesName,
                  style: titilliumRegular.copyWith(

                      fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: mediaQueryHeight(context) / 60),
                Row(
                  children: [
                    InkWell(
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: offWhite,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Center(
                          child: Icon(Icons.add),
                        ),
                      ),
                      onTap: () {
                        controller.plus(index: widget.index);
                      },
                    ),
                    SizedBox(width: mediaQueryHeight(context) / 60),
                    Obx(() => Text(
                        '${controller.basketProducts[widget.index].quantity}',
                        style:  titilliumRegular.copyWith(
                          fontWeight: FontWeight.bold,
                        ))),
                    SizedBox(width: mediaQueryHeight(context) / 60),
                    InkWell(
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: offWhite,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Icon(Icons.remove),
                      ),
                      onTap: () {
                        controller.minus(index: widget.index);
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(width: mediaQueryHeight(context) / 15),
            InkWell(
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: offWhite,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Center(
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ),
              onTap: () {
                controller.removeFromCart(index: widget.index);
              },
            ),
          ],
        ),
      ),
    );
  }
}
