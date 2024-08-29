import 'package:caffa/Models/Store.dart';
import 'package:caffa/utils/custom_themes.dart';
import 'package:caffa/widgets/custom_appbar.dart';
import 'package:caffa/widgets/custom_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class NonActiveStoresScreen extends StatefulWidget {
  const NonActiveStoresScreen({super.key});

  @override
  State<NonActiveStoresScreen> createState() => _NonActiveStoresScreenState();
}

class _NonActiveStoresScreenState extends State<NonActiveStoresScreen> {
  late Future<List<StoreData>> _futureStoreData;

  Future<List<StoreData>> _loadStores() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('stores').get();

      List<StoreData> stores = querySnapshot.docs.map((doc) {
        return StoreData.fromMap(doc.data() as Map<String, dynamic>);
      }).where((store) => store.isActive == false).toList();

      print(stores);

      return stores;
    } catch (error) {
      print('Firestore read error: $error');
      return [];
    }
  }

  Future<void> _activateStore(String storeId) async {
    try {
      await FirebaseFirestore.instance.collection('stores').doc(storeId)
          .update({'isActive': true});
      setState(() {
        _futureStoreData = _loadStores();
      });
    } catch (error) {
      print('Error activating store: $error');
    }
  }


  @override
  void initState() {
    super.initState();
    _futureStoreData = _loadStores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context: context, title: 'المقاهي غير النشطة', isHomeScreen: false),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 10.h),
          child: FutureBuilder(
              future: _futureStoreData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitFadingCircle(
                      color: Colors.blue,
                      size: 80.0,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<StoreData> stores = snapshot.data!;

                  if (stores.isNotEmpty) {
                    return ListView.separated(
                      separatorBuilder: (ctx,i)=>Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width:double.infinity,
                          height: 1,
                          color: Colors.grey.withOpacity(.5),
                        ),
                      ),
                      padding: EdgeInsets.all(0),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: stores.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: Key(stores[index].id.toString()),
                          direction: DismissDirection.endToStart, // يمين إلى يسار
                          confirmDismiss: (direction) async {
                            return await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("تأكيد التفعيل"),
                                  content:
                                  Text("هل أنت متأكد أنك تريد تفعيل هذا المقهى؟"),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: Text("لا"),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                      child: Text("نعم"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          onDismissed: (direction) {
                            _activateStore(stores[index].id!);
                          },
                          background: Container(
                            color: Colors.green,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text('تفعيل',style: titilliumRegular.copyWith
                              (
                              color: Colors.white,
                              fontSize: 18.sp
                            ),),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: SizedBox(
                              height: 220.h,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 150.h,
                                    width: double.infinity,
                                    child: CustomImage(
                                      fit: BoxFit.cover,
                                      image: stores[index].image!,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Padding(
                                    padding: EdgeInsets.only(right: 29.w, left: 35.w),
                                    child: Row(
                                      children: [
                                        Text(
                                          stores[index].name.toString(),
                                          style: titilliumRegular.copyWith(
                                            color: Color(0XFF2D005D),
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          "4.9",
                                          style: titilliumRegular.copyWith(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0XFFFFA800),
                                          ),
                                        ),
                                        Icon(Icons.star_rate_rounded, color: Color(0XFFFFA800),size: 20,),
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: 5.h),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                      height: 151.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0.r),
                        color: Color(0xffF8F8F7),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 10,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.warning, size: 80.r, color: const Color.fromARGB(255, 201, 8, 8)),
                          SizedBox(width: 15.w),
                          Text(
                            "لا يوجد مقاهي",
                            style: GoogleFonts.tajawal(
                              fontSize: 16.sp,
                              color: const Color.fromARGB(255, 201, 8, 8),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }
              }),
        ),
      ),
    );
  }
}
