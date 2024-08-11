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
     sharedPreferences!.setString('phoneNumber', user.phoneNumber ?? "");
    sharedPreferences!.setString('password', user.password ?? "");
    sharedPreferences!.setString('userType', user.userType ?? "");
    sharedPreferences!.setInt('availableCups', user.availableCups ?? 0);
    sharedPreferences!.setBool('isVerified', user.isVerified ?? false);
    sharedPreferences!.setBool('isGuest', false);
  }

  Future<void> setAvailableCups({required int availableCups}) async {
    sharedPreferences!.setInt('availableCups', availableCups ?? 0);
  }

  UserData user() {
    UserData user = new UserData(
        id:  sharedPreferences!.getString('id')!,
        userType:  sharedPreferences!.getString('userType')!,
      isVerified:  sharedPreferences!.getBool('isVerified')!,
        name:  sharedPreferences!.getString('name')!,
        email:  sharedPreferences!.getString('email')!,
        password:  sharedPreferences!.getString('password')!,
        phoneNumber:  sharedPreferences!.getString('phoneNumber')!,
        availableCups: sharedPreferences!.getInt('availableCups')!,
    );

    return user;
  }

  Future<void> updateLoggedIn() async {
    print( sharedPreferences!.getString('token'));
    await  sharedPreferences!.setString('token', '');
    await  sharedPreferences!.setString('id', '');
    handleClearPrefs();
    print( sharedPreferences!.getString('token'));
  }

  String get id =>  sharedPreferences!.getString('id') ?? '';
  String get phoneNumber =>  sharedPreferences!.getString('phoneNumber') ?? '';
  String get email =>  sharedPreferences!.getString('email') ?? '';
  String get userType =>  sharedPreferences!.getString('userType') ?? '';
  String get name =>  sharedPreferences!.getString('name') ?? '';
  int get availableCups =>  sharedPreferences!.getInt('availableCups') ?? 0;
  bool get isVerified =>  sharedPreferences!.getBool('isVerified') ?? false;
  bool get isGuest =>  sharedPreferences!.getBool('isGuest') ?? false;

  void handleClearPrefs() {
     sharedPreferences!.clear();
    print("true");
  }
}
