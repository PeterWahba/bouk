import 'package:caffa/Models/Purchase.dart';
import 'package:caffa/Shared%20preferences/shared_preferences.dart';
import 'package:caffa/utils/custom_themes.dart';
import 'package:caffa/widgets/custom_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardScreen extends StatefulWidget {
  final bool isHomeScreen;
  const CardScreen({super.key, required this.isHomeScreen});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  Future<List<PurchaseModel>> _loadPurchasesData() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(AppSettingsPreferences().id)
          .collection('stores')
          .get();

      List<PurchaseModel> purchases = querySnapshot.docs.map((doc) {
        return PurchaseModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
      return purchases;
    } catch (error) {
      print('Firestore read error: $error');
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context: context, title: 'بطاقاتي', isHomeScreen: widget.isHomeScreen),
      body: FutureBuilder<List<PurchaseModel>>(
        future: _loadPurchasesData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<PurchaseModel> purchaseModel = snapshot.data!;
            return ListView.separated(
              itemBuilder: (context, index) => SummaryCard(purchaseModel: purchaseModel[index]),
              separatorBuilder: (context, index) => SizedBox(height: 10.h),
              itemCount: purchaseModel.length,
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}

class SummaryCard extends StatelessWidget {
  final PurchaseModel purchaseModel;

  const SummaryCard({Key? key, required this.purchaseModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        SizedBox(
          height: 30.h,
        ),
        Center(
          child: Container(
            width: 354.w,
            height: 229.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: Color(0XFFFAFAFA),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 24.w,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "رقم المستهلك",
                      style: titilliumRegular.copyWith(
                        fontSize: 12.sp,
                        color: Color(0XFF24373D),
                      ),
                    ),
                    Text(
                      AppSettingsPreferences().phoneNumber,
                      style: titilliumRegular.copyWith(
                        fontSize: 14.sp,
                        color: Color(0XFF24373D),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "تاريخ الفاتورة",
                      style: titilliumRegular.copyWith(
                        fontSize: 12.sp,
                        color: Color(0XFF24373D),
                      ),
                    ),
                    Text(
                      purchaseModel.purchaseDate ?? '',
                      style: titilliumRegular.copyWith(
                        fontSize: 14.sp,
                        color: Color(0XFF24373D),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "مبلغ مدفوع",
                      style: titilliumRegular.copyWith(
                        fontSize: 12.sp,
                        color: Color(0XFF24373D),
                      ),
                    ),
                    Text(
                      "SAR ${purchaseModel.price}",
                      style: titilliumRegular.copyWith(
                        fontSize: 14.sp,
                        color: Color(0XFF2D005D),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "إسم المقهى",
                      style: titilliumRegular.copyWith(
                        fontSize: 12.sp,
                        color: Color(0XFF24373D),
                      ),
                    ),
                    Text(
                      purchaseModel.coffeeName ?? '',
                      style: titilliumRegular.copyWith(
                        fontSize: 12.sp,
                        color: Color(0XFF2D005D),
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                Spacer(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset("assets/Rectangle 1714.png"),
                    Text(
                      'الأكواب المتبقية',
                      style: titilliumRegular.copyWith(
                        fontSize: 14.sp,
                        color: Color(0XFF2D005D),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "(${purchaseModel.availableCups}) كوب",
                      style: titilliumRegular.copyWith(
                        fontSize: 14.sp,
                        color: Color(0XFF2D005D),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 12.w,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
