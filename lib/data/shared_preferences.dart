import 'dart:convert';

import 'package:ad_drive/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _USER_DATA = "user_data";

class SharedPreferencesRepository {
  late SharedPreferences _prefs;

  static final SharedPreferencesRepository _singleton = SharedPreferencesRepository._internal();

  factory SharedPreferencesRepository() {
    return _singleton;
  }

  SharedPreferencesRepository._internal();

  Future<UserData> init() async {
    _prefs = await SharedPreferences.getInstance();
    return getUserData();
  }

  Future addUserData(UserData userData) async {
    return _prefs.setString(_USER_DATA, jsonEncode(userData.toJson()));
  }

  UserData getUserData() {
    String json = _prefs.getString(_USER_DATA) ?? "";
    if (json.isEmpty) {
      return UserData(uid: "", city: "", username: "", phoneNumber: "");
    } else {
      return UserData.fromJson(jsonDecode(json));
    }
  }

  Future clearUserData() async {
    return _prefs.setStringList(_USER_DATA, []);
  }
}
