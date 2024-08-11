import 'dart:async';
import 'package:caffa/Screens/Auth/auth_screen.dart';
import 'package:caffa/Screens/Home/home_screen.dart';
import 'package:caffa/Screens/Home_store/home_store_screen.dart';
import 'package:caffa/Screens/SuperAdmin/suber_admin_screen.dart';
import 'package:caffa/Screens/dashboard/dashboard_screen.dart';
import 'package:caffa/Shared%20preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    _controller = VideoPlayerController.asset('assets/splash.mp4');
    _controller.initialize().then((_) {
      _controller.setLooping(false);
      Timer(const Duration(milliseconds: 1000), () {
        if (this.mounted) {
          setState(() {
            _controller.setVolume(0);
            // _controller.setPlaybackSpeed(2.0);
            _controller.play();
            _visible = true;
          });
        }
      });
    });

    Future.delayed(Duration(seconds: 4), () {
      // Get.off(() => AuthScreen(), transition: Transition.cupertino);
      if(AppSettingsPreferences().userType == 'superAdmin')
      {
        Get.offAll(() => SuperAdminScreen(), transition: Transition.cupertino);

      }
      else if (AppSettingsPreferences().id != '') {
        // Get.off(() => AuthScreen(), transition: Transition.cupertino);

        AppSettingsPreferences().userType == 'client'
            ? Get.offAll(() => DashBoardScreen(),
                transition: Transition.cupertino)
            : Get.offAll(() => HomeStoreScreen(),
                transition: Transition.cupertino);
      } else if (AppSettingsPreferences().isGuest) {
        Get.offAll(() => DashBoardScreen(), transition: Transition.cupertino);
      } else
        Get.off(() => AuthScreen(), transition: Transition.cupertino);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            AnimatedOpacity(
              opacity: _visible ? 1 : 1,
              duration: const Duration(milliseconds: 3000),
              child: VideoPlayer(_controller),
            ),
          ],
        ),
      ),
    );
  }
}
