import 'package:caffa/basket_controller/basket_controller.dart';
import 'package:flutter/material.dart';


PreferredSizeWidget BasketAppBar({
  required BuildContext context,
  required String title,
  required bool isHomeScreen,
  required BasketController controller
}) =>
    AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      title: Text(title,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white)),
      centerTitle: true,
      backgroundColor: Color(0XFF2D005D),
      elevation: 0.0,
      automaticallyImplyLeading: true,
      leading:!isHomeScreen? IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back),
      ):SizedBox(),

      actions:controller.basketProducts.isNotEmpty? [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: IconButton(
            onPressed: () async{
              controller.deleteCartProducts(context);

            },
            icon: Icon(
              Icons.delete,
              color: Colors.red,
              size: 30,
            ),
          ),
        ),
      ]: [],
    );
