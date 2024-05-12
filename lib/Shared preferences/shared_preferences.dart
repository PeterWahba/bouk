import 'package:shared_preferences/shared_preferences.dart';

import '../Models/User.dart';

  class AppSettingsPreferences {
  AppSettingsPreferences._internal();

  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
  static final AppSettingsPreferences _instance =
      AppSettingsPreferences._internal();

  factory AppSettingsPreferences() {
    return _instance;
  }

  Future<void> intiPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> saveOnBoardingScreenState({required String state}) async {
    await  sharedPreferences!.setString('state', state);
  }

  String get state =>  sharedPreferences!.getString('state') ?? "0";

  /******************************************************/

  Future<void> saveUser({required UserData user}) async {
    sharedPreferences!.setString('id', user.id ?? "");
     sharedPreferences!.setString('name', user.name ?? "");
     sharedPreferences!.setString('email', user.email ?? "");
     sharedPreferences!.setString('phone', user.phone ?? "");
     sharedPreferences!.setString('password', user.password ?? "");
  }

  UserData user() {
    UserData user = new UserData(
        id:  sharedPreferences!.getString('id')!,
        name:  sharedPreferences!.getString('name')!,
        email:  sharedPreferences!.getString('email')!,
        password:  sharedPreferences!.getString('password')!,
        phone:  sharedPreferences!.getString('phone')!);

    return user;
  }

  Future<void> updateLoggedIn() async {
    print( sharedPreferences!.getString('token'));
    await  sharedPreferences!.setString('token', '');
    await  sharedPreferences!.setString('id', '');
    print( sharedPreferences!.getString('token'));
  }

  String get id =>  sharedPreferences!.getString('id') ?? '';
  String get email =>  sharedPreferences!.getString('email') ?? '';

  void handleClearPrefs() {
     sharedPreferences!.clear();
    print("true");
  }
}
