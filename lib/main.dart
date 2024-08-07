import 'package:caffa/widgets/internet_check.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'Shared preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await AppSettingsPreferences.init();
  await Firebase.initializeApp(
      // options: const FirebaseOptions(
      //     apiKey: "AIzaSyDwqUgEB_TZH4W1rPh57GnKCSfyL3KBsps",
      //     authDomain: "caffa-1c965.firebaseapp.com",
      //     projectId: "caffa-1c965",
      //     storageBucket: "caffa-1c965.appspot.com",
      //     messagingSenderId: "319946119347",
      //     appId: "1:319946119347:web:429bb5781c6b590e3f78c6",
      //     measurementId: "G-6TRBSKF1BG")
  );
  runApp(MyApp());}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 852),
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          locale: Locale("ar"),
          builder: DevicePreview.appBuilder,
          home:InternetCheck(),
          themeMode: ThemeMode.light,
          title: 'Bock App',
        );
      },
    );
  }
}
