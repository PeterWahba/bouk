import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:caffa/Screens/Cards/cards_screen.dart';
import 'package:caffa/Screens/GuestMode/guest_screen.dart';
import 'package:caffa/Screens/Home/home_screen.dart';
import 'package:caffa/Screens/profile/profile_screen.dart';
import 'package:caffa/Shared%20preferences/shared_preferences.dart';
import 'package:caffa/utils/network_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  DashBoardScreenState createState() => DashBoardScreenState();
}

class DashBoardScreenState extends State<DashBoardScreen> {
  int _pageIndex = 0;
  late List _screens;

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  final PageStorageBucket bucket = PageStorageBucket();
  final NotchBottomBarController _controller =
      NotchBottomBarController(index: 0);

  @override
  void initState() {
    super.initState();

    _screens = [
      HomeScreen(),
      AppSettingsPreferences().isGuest?
      GuestScreen(isHomeScreen: true, appBarHeader: 'بطاقاتي'  ,):
      CardScreen(isHomeScreen: true,),
      // BasketScreen(
      //   isHomeScreen: true,
      //   storeData: StoreData(
      //       id: '',
      //       userType: '',
      //       isVerified: null,
      //       availableCups: null,
      //       phoneNumber: '',
      //       name: '',
      //       image: '',
      //       email: '',
      //       password: ''),
      // ),
      ProfileScreen()
    ];

    NetworkInfo.checkConnectivity(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      extendBody: true,
      body: PageStorage(bucket: bucket, child: _screens[_pageIndex]),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        child: AnimatedNotchBottomBar(
          notchBottomBarController: _controller,
          color: Color(0XFF2D005D),
          shadowElevation: 4,
          bottomBarWidth: 500,
          showShadow: true,
          durationInMilliSeconds: 300,
          elevation: 1,
          bottomBarItems: [
            const BottomBarItem(
              inActiveItem: Icon(
                Icons.home_filled,
                color: Colors.white,
              ),
              activeItem: Icon(
                Icons.home_filled,
                color: Color(0XFF2D005D),
              ),
              // itemLabel: 'الرئيسية',
            ),
            BottomBarItem(
              inActiveItem: SvgPicture.asset(
                'assets/wallet.svg',
                color: Colors.white,
              ),
              activeItem: SvgPicture.asset(
                'assets/wallet.svg',
                color: Color(0XFF2D005D),
              ),
              // itemLabel: 'سلة المشتريات',
            ),
            const BottomBarItem(
              inActiveItem: Icon(
                Icons.person,
                color: Colors.white,
              ),
              activeItem: Icon(
                Icons.person,
                color: Color(0XFF2D005D),
              ),
              // itemLabel: 'حسابي',
            ),
          ],
          onTap: (int value) {
            _setPage(value);
          },
          kIconSize: 24.sp,
          kBottomRadius: 20.sp,
        ),
      ),
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageIndex = pageIndex;
    });
  }
}
