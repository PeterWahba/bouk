import 'package:caffa/Shared%20preferences/shared_preferences.dart';
import 'package:caffa/basket_controller/basket_controller.dart';
import 'package:caffa/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class alertDialog extends StatelessWidget with Helpers {
  final BasketController controller = Get.put(BasketController());

  alertDialog(
      {required this.imageSrc,
      required this.text,
      Key? key,
      required this.isQRCode})
      : super(key: key);
  final String imageSrc;
  final String text;
  final bool isQRCode;

  @override
  Widget build(BuildContext context) {
    String data
    ='{"id":"${AppSettingsPreferences().id.toString()}", "orderCups":"${controller.totalCubs.toString()}", "availableCups":"${AppSettingsPreferences().availableCups}"}';

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      elevation: 50.0,
      content: Container(
        height: mediaQueryHeight(context) * .32,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: mediaQueryWidth(context) * .4,
              height: mediaQueryHeight(context) * .2,
              child: isQRCode
                  ? PrettyQrView.data(
                      data: data,
                    )
                  : Lottie.asset(imageSrc, fit: BoxFit.cover),
            ),
            SizedBox(height: mediaQueryHeight(context) / 100),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
