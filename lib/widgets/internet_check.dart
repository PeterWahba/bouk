import 'package:caffa/Screens/Splash/splash_screen.dart';
import 'package:caffa/widgets/offline_widget.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class InternetCheck extends StatefulWidget {
  @override
  _InternetCheckState createState() => _InternetCheckState();
}

class _InternetCheckState extends State<InternetCheck> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;

  @override
  void initState() {
    super.initState();
    // تحقق مرة عند بدء التطبيق
    checkConnectivity();
    // استمع لتغييرات حالة الاتصال
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _connectionStatus = result;
      });
    });
  }

  // تحقق من حالة الاتصال
  Future<void> checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _connectionStatus = connectivityResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    // عرض شاشة مخصصة إذا كانت حالة الاتصال غير متاحة
    if (_connectionStatus == ConnectivityResult.none) {
      print(_connectionStatus.toString());
      print("_connectionStatus.toString()");
      return OfflineWidget();
    } else {
      // قم بعرض شاشة المحتوى الرئيسية إذا كان هناك اتصال
      print("_connectionStatus.toString()");
      print(_connectionStatus.toString());
      return SplashScreen();
    }
  }
}

