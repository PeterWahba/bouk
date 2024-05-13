import 'package:caffa/basket_controller/basket_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'basket_items_widget.dart';


class BasketProducts extends StatefulWidget {
  const BasketProducts({Key? key, required this.firstCategoryName}) : super(key: key);

  final String firstCategoryName;

  @override
  State<BasketProducts> createState() => _BasketProductsState();
}

class _BasketProductsState extends State<BasketProducts> {
  final BasketController controller = Get.put(BasketController());


  @override
  Widget build(BuildContext context) {

    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.basketProducts.length,
      itemBuilder: (BuildContext context, int index) {
        return  Basket(
          categoriesName: controller.basketProducts[index].productName.toString(),
          imageSrc: 'assets/coffe.png',
          index: index,

        );
      },
    );
  }
}
