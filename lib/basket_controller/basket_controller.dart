import 'dart:async';
import 'package:caffa/Shared%20preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../utils/helpers.dart';
import 'basket_model.dart';

class BasketController extends GetxController with Helpers {
  var counter = <int>[].obs;
  var basketProducts = <BasketModel>[].obs; // قائمة المنتجات في سلة التسوق

  void minus({required int index}) async {
    if (counter[index] > 1) {
      counter[index]--;
      basketProducts[index] = BasketModel.fromJson({
        'productId': basketProducts[index].productId,
        'productName': basketProducts[index].productName,
        'quantity': counter[index],
      });
      calcTotalCubs();
    }
  }

  void plus({required int index}) async {
    counter[index]++;
    basketProducts[index] = BasketModel.fromJson({
      'productId': basketProducts[index].productId,
      'productName': basketProducts[index].productName,
      'quantity': counter[index],
    });
    calcTotalCubs();

  }

  Future<void> deleteCartProducts(context) async {
    basketProducts.clear();
    counter.clear();
    calcTotalCubs();
    update();
    showSnackBar(

        context: context,
        message: 'تم حذف  السلة بنجاح',
        error: true);// Manually trigger update after clearing the list

  }

  Future<void> AddToCart({
    required BasketModel productModel,
  }) async {
    calcTotalCubs();
  checkIfContain(ID: productModel.productId!).then((value) {
      if (productIfContain == false) {
        counter.insert(counter.length, 1);
        BasketModel basketModel;
        basketModel = BasketModel.fromJson({
          'productId': productModel.productId,
          'productName': productModel.productName,
          'quantity': 1,
        });
        basketProducts.add(basketModel);
        calcTotalCubs();
      } else {
        plus(index: index);
        calcTotalCubs();
        print(index);
      }
    });
    update(); // Manually trigger update after clearing the list
    calcTotalCubs();

  }

  bool productIfContain = false;
  int index = 0;

  Future<void> checkIfContain({required int ID}) async {
    productIfContain = false;
    if (basketProducts.isNotEmpty) {
      basketProducts.asMap().forEach((elementIndex, element) {
        if (element.productId == ID) {
          productIfContain = true;
          index = elementIndex;
        }
      });
    }
  }


  Future<void> removeFromCart({
    required int index,
  }) async {
    counter.removeAt(index);
    basketProducts.removeAt(index);
    calcTotalCubs();
    update(); // Manually trigger update after clearing the list

  }
  int totalCubs = 0;

  void calcTotalCubs() {
    totalCubs = 0;
    basketProducts.forEach((element) {
      totalCubs +=element.quantity!;
    });
    update();


    // Manually trigger update after clearing the list
  }

}
