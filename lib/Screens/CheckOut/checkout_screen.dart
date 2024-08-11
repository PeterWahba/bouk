import 'package:caffa/Models/Store.dart';
import 'package:caffa/Shared%20preferences/shared_preferences.dart';
import 'package:caffa/payment_service/payment_service.dart';
import 'package:caffa/utils/custom_themes.dart';
import 'package:caffa/utils/helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../SuccessOrdered/success_ordered_screen.dart';

class CheckOutScreen extends StatefulWidget {
  final int cups;
  final int oldAvailableCups;
  final double oldPurchasedPrice;
  final double price;
  final StoreData storeData;

  const CheckOutScreen(
      {super.key,
      required this.cups,
      required this.price,
      required this.storeData,
      required this.oldAvailableCups,
      required this.oldPurchasedPrice});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> with Helpers {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _cvcController = TextEditingController();
  String? _selectedMonth;
  String? _selectedYear;
  final _paymentService = PaymentService();
  bool _isLoading = false;

  List<String> months =
      List.generate(12, (index) => (index + 1).toString().padLeft(2, '0'));
  List<String> years =
      List.generate(10, (index) => (DateTime.now().year + index).toString());

  String getCurrentDate() {
    DateTime now = DateTime.now();
    return DateFormat('d MMM yyyy').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 45.h),
                    Row(
                      children: [
                        SizedBox(width: 38.w),
                        InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: SvgPicture.asset("assets/Frame 20.svg")),
                        SizedBox(width: 11.w),
                        Text(
                          "الدفع",
                          style: titilliumRegular.copyWith(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 42.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PaymentMethodCard(
                            assetPath: "assets/Rectangle 231.png",
                            selected: false,
                          ),
                          PaymentMethodCard(
                            assetPath: "assets/Rectangle 230.png",
                            selected: false,
                          ),
                          PaymentMethodCard(
                            text: "Card",
                            selected: true,
                          ),
                          PaymentMethodCard(
                            text: "PayPal",
                            selected: false,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 36.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        children: [
                          PaymentTextField(
                            controller: _nameController,
                            label: "الاسم على البطاقة",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'يرجى إدخال الاسم';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 11.h),
                          PaymentTextField(
                            controller: _numberController,
                            label: "رقم البطاقة",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'يرجى إدخال رقم البطاقة';
                              }
                              if (value.length != 16) {
                                return 'رقم البطاقة غير صحيح';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 11.h),
                          Row(
                            children: [
                              Flexible(
                                flex: 2,
                                child: DropdownButtonFormField<String>(
                                  value: _selectedMonth,
                                  hint: Text(
                                    "شهر الانتهاء",
                                    style: titilliumRegular.copyWith(
                                        fontSize: 15.sp),
                                  ),
                                  items: months.map((String month) {
                                    return DropdownMenuItem<String>(
                                      value: month,
                                      child: Text(month),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedMonth = value;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'يرجى اختيار شهر الانتهاء';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(18),
                                    labelText: "شهر الانتهاء",
                                    labelStyle: titilliumRegular.copyWith(
                                      color: Color(0XFF000000).withOpacity(.3),
                                      fontSize: 15.0,
                                    ),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Color(0XFFE3E3CE),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.grey.shade300,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Flexible(
                                flex: 2,
                                child: DropdownButtonFormField<String>(
                                  value: _selectedYear,
                                  hint: Text("سنة الانتهاء",style: titilliumRegular.copyWith(
                                  fontSize: 15.sp),),
                                  items: years.map((String year) {
                                    return DropdownMenuItem<String>(
                                      value: year,
                                      child: Text(year),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedYear = value;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'يرجى اختيار سنة الانتهاء';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(18),
                                    labelText: "سنة الانتهاء",
                                    labelStyle: titilliumRegular.copyWith(
                                      color: Color(0XFF000000).withOpacity(.3),
                                      fontSize: 15.0,
                                    ),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Color(0XFFE3E3CE),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.grey.shade300,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Flexible(
                                flex: 1,
                                child: PaymentTextField(
                                  controller: _cvcController,
                                  label: "CVV",
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'يرجى إدخال CVV';
                                    }
                                    if (value.length != 3) {
                                      return 'CVV غير صحيح';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.w),
                      child: Column(
                        children: [
                          OrderSummaryRow(
                              label: "المجموع الفرعي",
                              amount: "SAR ${widget.price}"),
                          OrderSummaryRow(label: "الضريبة", amount: "SAR 3.99"),
                          Divider(thickness: 1.h, color: Color(0XFFD9D9D9)),
                          OrderSummaryRow(
                            label: "المبلغ الإجمالي",
                            amount:
                                "SAR ${(widget.price + 3.9).toStringAsFixed(2)}",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 31.h),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            try {
                              setState(() {
                                _isLoading = true;
                              });
                              // تنفيذ عملية الدفع
                              final result =
                                  await _paymentService.createPayment(
                                amount: widget.price + 3.99,
                                currency: 'SAR',
                                description: 'Test Payment',
                                callbackUrl: 'https://your-callback-url.com',
                                sourceType: 'creditcard',
                                sourceName: _nameController.text,
                                sourceNumber: _numberController.text,
                                sourceCvc: _cvcController.text,
                                sourceMonth: _selectedMonth!,
                                sourceYear: _selectedYear!,
                              );

                              // تحقق من نجاح الدفع بناءً على نتيجة `result`
                              if (result.success) {
                                // عرض رسالة نجاح
                                Get.snackbar(
                                  'نجاح الدفع',
                                  'تمت عملية الدفع بنجاح.',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white,
                                );
                                _nameController.text = '';
                                _numberController.text = '';
                                _cvcController.text = '';
                                setState(() {
                                  _selectedMonth = null;
                                  _selectedYear = null;
                                });
                                // التبديل إلى شاشة النجاح
                                FirebaseFirestore.instance
                                    .runTransaction((transaction) async {
                                  DocumentSnapshot snapshot =
                                      await FirebaseFirestore.instance
                                          .collection('stores')
                                          .doc(widget.storeData.id)
                                          .collection('users')
                                          .doc(AppSettingsPreferences().id)
                                          .get();

                                  if (!snapshot.exists) {
                                    await FirebaseFirestore.instance
                                        .collection('stores')
                                        .doc(widget.storeData.id)
                                        .collection('clients')
                                        .doc(AppSettingsPreferences().id)
                                        .set({
                                      'name': AppSettingsPreferences().name,
                                      'id': AppSettingsPreferences().id,
                                      'availableCups': widget.cups +
                                          AppSettingsPreferences()
                                              .availableCups,
                                    });
                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(AppSettingsPreferences().id)
                                        .collection('stores')
                                        .doc(widget.storeData.id)
                                        .set({
                                      'name': AppSettingsPreferences().name,
                                      'id': AppSettingsPreferences().id,
                                      'availableCups': widget.cups +
                                          AppSettingsPreferences()
                                              .availableCups,
                                      'coffeeName': widget.storeData.name,
                                      'purchaseDate': getCurrentDate(),
                                      'price': widget.price +
                                          widget.oldPurchasedPrice +
                                          3.99,
                                    });
                                  } else {
                                    // int oldValue = snapshot.get(
                                    //     'availableCups');
                                    await FirebaseFirestore.instance
                                        .collection('stores')
                                        .doc(widget.storeData.id)
                                        .collection('clients')
                                        .doc(AppSettingsPreferences().id)
                                        .update({
                                      'availableCups': widget.cups +
                                          AppSettingsPreferences()
                                              .availableCups,
                                    });
                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(AppSettingsPreferences().id)
                                        .collection('stores')
                                        .doc(widget.storeData.id)
                                        .update({
                                      'availableCups': widget.cups +
                                          AppSettingsPreferences()
                                              .availableCups,
                                      'coffeeName': widget.storeData.name,
                                      'purchaseDate': getCurrentDate(),
                                      'price': widget.price +
                                          widget.oldPurchasedPrice +
                                          3.99,
                                    });
                                  }
                                }).then((onValue) {
                                  Get.to(() => SuccessOrderedScreen());
                                });
                              } else {
                                // عرض رسالة خطأ
                                Get.snackbar(
                                  'فشل الدفع',
                                  'حدث خطأ أثناء عملية الدفع. حاول مرة أخرى.',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                );
                              }
                            } catch (e) {
                              // التعامل مع أي أخطاء أخرى
                              Get.snackbar(
                                'خطأ',
                                'حدث خطأ غير متوقع: $e',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                            } finally {
                              setState(() {
                                _isLoading = false;
                              });
                            }
                          }
                        },
                        child: Text(
                          "إطلب الأن",
                          style: titilliumRegular.copyWith(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(318.w, 60.h),
                          backgroundColor: Color(0XFF2D005D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
                if (_isLoading)
                  Positioned.fill(
                    child: SpinKitFadingCircle(
                      color: Colors.blue,
                      size: 80.0,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PaymentMethodCard extends StatelessWidget {
  final String? assetPath;
  final String? text;
  final bool selected;

  const PaymentMethodCard(
      {Key? key, this.assetPath, this.text, required this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: 83.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        border: Border.all(
          color: selected ? Colors.transparent : Color(0XFFEFEFEF),
        ),
        color: selected ? Color(0XFF2D005D) : Colors.transparent,
      ),
      child: Center(
        child: assetPath != null
            ? Image.asset(assetPath!)
            : Text(
                text!,
                style: titilliumRegular.copyWith(
                  fontSize: 15.sp,
                  color: selected ? Colors.white : Colors.black.withOpacity(.4),
                ),
              ),
      ),
    );
  }
}

class PaymentTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final bool isObscure;
  final FormFieldValidator<String>? validator;

  const PaymentTextField({
    Key? key,
    required this.controller,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.isObscure = false,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isObscure,
      maxLines: 1,
      cursorHeight: 25.0,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(18),
        labelText: label,
        labelStyle: titilliumRegular.copyWith(
          color: Color(0XFF000000).withOpacity(.3),
          fontSize: 15.0,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            width: 1,
            color: Color(0XFFE3E3CE),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            width: 1,
            color: Colors.grey.shade300,
            style: BorderStyle.solid,
          ),
        ),
      ),
      validator: validator,
    );
  }
}

class OrderSummaryRow extends StatelessWidget {
  final String label;
  final String amount;
  final Color? labelColor;
  final Color? amountColor;

  const OrderSummaryRow({
    Key? key,
    required this.label,
    required this.amount,
    this.labelColor,
    this.amountColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: titilliumRegular.copyWith(
              fontSize: 16.0,
              color: labelColor ?? Colors.black,
            ),
          ),
          Text(
            amount,
            style: titilliumRegular.copyWith(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: amountColor ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
