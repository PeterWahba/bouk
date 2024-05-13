import 'package:caffa/basket_controller/basket_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'basket_components/basket_Empty.dart';
import 'basket_components/basket_appBar.dart';
import 'basket_components/basket_widget.dart';
import 'package:add_to_cart_animation/add_to_cart_animation.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({Key? key}) : super(key: key);

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  final BasketController controller = Get.put(BasketController());
  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCartAnimation;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BasketController>(
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            appBar: BasketAppBar(
              context: context,
              title: 'سلة المشتريات', controller: controller,
            ),
            body: controller.basketProducts.isEmpty?EmptyCart() :SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  BasketSection(
                    firstCategoryName: "categoryName",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
