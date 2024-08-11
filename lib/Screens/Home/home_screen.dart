import 'package:caffa/Models/Banner.dart';
import 'package:caffa/Models/Social.dart';
import 'package:caffa/Models/Store.dart';
import 'package:caffa/utils/custom_themes.dart';
import 'package:caffa/widgets/custom_image.dart';
import 'package:carousel_slider/carousel_slider.dart' as carousel;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Details/details_screen.dart';
import '../Location/location_screen.dart';
import 'widget/banner_shimmer.dart';
import 'widget/stores_shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<StoreData>> _futureStoreData;
  late Future<List<BannerModel>> _futureBannerData;
  late int availableCups = 0;
  var formKey = GlobalKey<FormState>();
  late TextEditingController _addressController; // Controller for address

  // final NotchBottomBarController _controller = NotchBottomBarController(index: 0);
  // final _pageController = PageController(initialPage: 0);0

  Future<List<StoreData>> _loadStores() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('stores').get();

      // تصفية المتاجر وعرض فقط التي تكون isActive=true
      List<StoreData> stores = querySnapshot.docs.map((doc) {
        return StoreData.fromMap(doc.data() as Map<String, dynamic>);
      }).where((store) => store.isActive == true).toList();

      print(stores);

      return stores;
    } catch (error) {
      // Handle Firestore read error here
      print('Firestore read error: $error');
      return [];
    }
  }


  Future<List<BannerModel>> _loadBannerData() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('banner').get();

      List<BannerModel> bannerImages = querySnapshot.docs.map((doc) {
        return BannerModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
      print(bannerImages);

      return bannerImages;
    } catch (error) {
      // Handle Firestore read error here
      print('Firestore read error: $error');
      return [];
    }
  }

  String _formatAddress(String address) {
    // تقسيم النص بناءً على الفاصلة
    List<String> parts = address.split('-');

    // التأكد من وجود ثلاثة أجزاء على الأقل (شارع، مدينة، دولة)
    if (parts.length >= 3) {
      // إزالة المسافات الزائدة من كل جزء
      String street = parts[0].trim();
      String city = parts[1].trim();
      String country = parts[2].trim();

      // دمج الأجزاء المطلوبة في نص واحد
      return '$street, $city, $country';
    } else {
      // إذا لم يكن العنوان يحتوي على الثلاثة أجزاء، فإرجاع النص الأصلي
      return address;
    }
  }


  Future<List<SocialModel>> _loadInfoData() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('socialUri').get();

      List<SocialModel> info = querySnapshot.docs.map((doc) {
        print(doc.id);
        switch (doc.id) {
          case 'instagram':
            setState(() {
              instagram =
                  SocialModel.fromMap(doc.data() as Map<String, dynamic>)
                      .uri
                      .toString();
            });
            // print(AppSettingsPreferences.sharedPreferences!.getString('instagram'));
            break;
          case 'facebook':
            setState(() {
              facebook = SocialModel.fromMap(doc.data() as Map<String, dynamic>)
                  .uri
                  .toString();
            });
            break;
          case 'whatsApp':
            setState(() {
              whatsApp = SocialModel.fromMap(doc.data() as Map<String, dynamic>)
                  .uri
                  .toString();
            });
            break;
          default:
            print('Value is unknown');
        }

        ;
        return SocialModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();

      print(info);
      return info;
    } catch (error) {
      // Handle Firestore read error here
      print('Firestore read error: $error');
      return [];
    }
  }
  Future<void> _getCurrentLocationAndAddress() async {
    try {
      // Check for location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      // Get the current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Get the address from the coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        String fullAddress =
            "${placemark.street}, ${placemark.locality}, ${placemark
            .administrativeArea}, ${placemark.country}";

        // Set the address in the TextField
        setState(() {
          _addressController.text = fullAddress;
        });
      }
    } catch (e) {
      print("Error fetching location: $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureStoreData = _loadStores();
    _futureBannerData = _loadBannerData();
    _loadInfoData();
    _addressController =
        TextEditingController();
    _getCurrentLocationAndAddress(); // Fetch address on page load

  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 250.h,
                  ),
                  Container(
                    height: 250.h,
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0XFF313131),
                          Color(0XFF131313),
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(() => LocationScreen());
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "موقعي:",
                                    style: titilliumRegular.copyWith(
                                      fontSize: 12.sp,
                                      color: Color(0XFFB7B7B7),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        _formatAddress(_addressController.text),
                                        style: titilliumRegular.copyWith(
                                          fontSize: 14.sp,
                                          color: Color(0XFFFFFFFF),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down_sharp,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Padding(
                            //   padding: EdgeInsets.only(right: 30.0.w),
                            //   child: IconButton(
                            //       icon: Icon(
                            //         Icons.logout_outlined,
                            //         color: Colors.red,
                            //         size: 30,
                            //       ),
                            //       onPressed: () => {
                            //         showDialog(
                            //             context: context,
                            //             builder: (_) => AlertDialog(
                            //               elevation: 24.0,
                            //               title: Text('هل أنت متأكد ؟',
                            //                   style: TextStyle(
                            //                       color: Colors.black)),
                            //               content: Text(
                            //                   'سوف تقوم بتسجيل الخروج من حسابكم',
                            //                   style: TextStyle(
                            //                       color: Colors.black)),
                            //               actions: [
                            //                 CupertinoDialogAction(
                            //                   child: Container(
                            //                     child: Text(
                            //                       'تسجيل الخروج',
                            //                       style: TextStyle(
                            //                           color: Colors.red),
                            //                     ),
                            //                   ),
                            //                   onPressed: () {
                            //                     FbAuthController()
                            //                         .signOut();
                            //                   },
                            //                 ),
                            //                 CupertinoDialogAction(
                            //                   child: Text('إلغاء'),
                            //                   onPressed: () {
                            //                     Navigator.pop(context);
                            //                   },
                            //                 ),
                            //               ],
                            //             ))
                            //       }),
                            // ),
                            // InkWell(
                            //     onTap: () {
                            //       Get.to(() => SettingsScreen());
                            //     },
                            //     child: Icon(
                            //       Icons.settings_outlined,
                            //       color: Colors.white,
                            //       size: 30,
                            //     )),
                          ],
                        ),
                        SizedBox(
                          height: 26.h,
                        ),
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          maxLines: 1,
                          cursorHeight: 25.h,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0XFF313131),
                            prefixIcon: Image.asset(
                              "assets/search-normal.png",
                              width: 24.w,
                              height: 24.h,
                              fit: BoxFit.scaleDown,
                            ),
                            suffixIcon: Container(
                              margin: EdgeInsets.only(left: 9.5.w),
                              decoration: BoxDecoration(
                                color: Color(0XFF2D005D),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  "assets/furnitur-icon.svg",
                                ),
                              ),
                              width: 46.5.w,
                              height: 40.5.h,
                            ),
                            contentPadding: const EdgeInsets.all(18),
                            counterText: "",
                            labelText: "إبحث عن العلامة التجارية",
                            labelStyle: titilliumRegular.copyWith(
                                color: Color(0XFF989898), fontSize: 14.sp),
                            floatingLabelBehavior: FloatingLabelBehavior.never,

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            // focusColor: Color(0XFF22A45D),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.grey.shade300,
                                  style: BorderStyle.solid),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Positioned(
                  //   bottom: 1.h,
                  //   right: 15.w,
                  //   child: Center(
                  //     child: Image.asset("assets/Frame 17.png"),
                  //   ),
                  // )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              FutureBuilder<List<BannerModel>>(
                future: _futureBannerData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: BannerShimmer(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    List<BannerModel> bannerImages = snapshot.data!;

                    return Column(
                      children: [
                        carousel.CarouselSlider(
                          items: bannerImages.map((banner) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: CustomImage(
                                image: banner.image!,
                                width: double.infinity,
                              ),
                            );
                          }).toList(),
                          options: carousel.CarouselOptions(
                            height: 220.h,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.8,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            enlargeFactor: 0.3,
                            scrollDirection: Axis.horizontal,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentIndex = index;
                              });
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: bannerImages.map((url) {
                            int index = bannerImages.indexOf(url);
                            return Container(
                              width: 8.0,
                              height: 8.0,
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 2.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentIndex == index
                                    ? Color(0XFF2D005D)
                                    : Color(0XFF2D005D).withOpacity(0.4),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.only(right: 29.w),
                child: Text(
                  "مقاهي قريبة مني",
                  style: titilliumRegular.copyWith(
                    fontSize: 20.w,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FutureBuilder(
                  future: _futureStoreData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return
                        Center(child: StoresShimmer()
                          // SpinKitFadingCircle(
                          //   color: Colors.blue,
                          //   size: 80.0,
                          // ),
                          );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      List<StoreData> stores = snapshot.data!;

                      if (stores.isNotEmpty) {
                        return ListView.builder(
                          padding: EdgeInsets.all(0),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                print(stores[index].toString());
                                Get.to(() => DetailsScreen(
                                      storeData: stores[index],
                                    ));
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: SizedBox(
                                  height: 220.h,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 23.w),
                                        child: Stack(
                                          children: [
                                            Container(
                                              height: 150.h,
                                              width: double.infinity,
                                              child: CustomImage(
                                                fit: BoxFit.cover,
                                                image: stores[index].image!,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 11.h, left: 11.w),
                                              child: Row(
                                                children: [
                                                  Spacer(),
                                                  // Container(
                                                  //   width: 232.w,
                                                  //   height: 29.h,
                                                  //   decoration: BoxDecoration(
                                                  //     color: Color(0XFF2D005D),
                                                  //     borderRadius:
                                                  //         BorderRadius.only(
                                                  //       topLeft:
                                                  //           Radius.circular(
                                                  //               10.r),
                                                  //       bottomLeft:
                                                  //           Radius.circular(
                                                  //               10.r),
                                                  //     ),
                                                  //   ),
                                                  //   padding: EdgeInsets.only(
                                                  //       right: 9.w, top: 4.h),
                                                  //   child: Text(
                                                  //     "احصل على أكواب القهوة بسعر رمزي",
                                                  //     style:
                                                  //         titilliumRegular.copyWith(
                                                  //       color: Colors.white,
                                                  //       fontSize: 13.sp,
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  // SizedBox(
                                                  //   width: 70.w,
                                                  // ),
                                                  Icon(
                                                    Icons.favorite_border,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: 29.w, left: 35.w),
                                        child: Row(
                                          children: [
                                            Text(
                                              stores[index].name.toString(),
                                              style: titilliumRegular.copyWith(
                                                color: Color(0XFF2D005D),
                                                fontSize: 18.w,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Spacer(),
                                            Text(
                                              "4.9",
                                              style: titilliumRegular.copyWith(
                                                fontSize: 15.w,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0XFFFFA800),
                                              ),
                                            ),
                                            Icon(
                                              Icons.star_rate_rounded,
                                              color: Color(0XFFFFA800),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 29.w),
                                        child: Text(
                                          "بعيدة عني ب 10 دقائق بالسيارة",
                                          style: titilliumRegular.copyWith(
                                              fontSize: 12.sp,
                                              color:
                                                  Colors.black.withOpacity(.7)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: stores.length,
                        );
                      } else {
                        return Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 15.w,
                            vertical: 15.h,
                          ),
                          height: 151.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0.r),
                            color: Color(0xffF8F8F7),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.5), // Shadow color
                                spreadRadius: 2, // How far the shadow spreads
                                blurRadius: 10, // Soften the shadow
                                offset: Offset(
                                    2, 2), // Offset in the X and Y direction
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.warning,
                                size: 80.r,
                                color: const Color.fromARGB(255, 201, 8, 8),
                              ),
                              SizedBox(
                                width: 15.w,
                              ),
                              Text(
                                "لا يوجد مقاهي",
                                style: GoogleFonts.tajawal(
                                  fontSize: 16.sp,
                                  color: const Color.fromARGB(255, 201, 8, 8),
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        );
                      }
                    }
                  }),
              SizedBox(
                height: 100.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
