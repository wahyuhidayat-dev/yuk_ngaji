// ignore_for_file: file_names

import 'package:shared_preferences/shared_preferences.dart';

class Session {
  static late SharedPreferences prefs;

  static addToString(String value, String index) async {
    // print("value $value index $index");
    prefs = await SharedPreferences.getInstance();
    prefs.setString(index, value);
  }

  static addToInt(int value, String index) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt(index, value);
  }

  static addToBool(bool value, String index) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool(index, value);
  }

  static addToDouble(double value, String index) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setDouble(index, value);
  }

  static Future<String?> getStringVal(String index) async {
    prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString(index);
    // == null ? null : prefs.getString(index);
    //print('session nih yee pas gw get ${prefs.getString(index)}');
    return stringValue;
  }

  static Future<int?> getIntVal(String index) async {
    prefs = await SharedPreferences.getInstance();
    //Return String
    int? stringValue = prefs.getInt(index);
    // == null ? null : prefs.getInt(index);
    return stringValue;
  }

  static Future<bool?> getBoolVal(String index) async {
    prefs = await SharedPreferences.getInstance();
    //Return String
    bool? stringValue = prefs.getBool(index);
    // == null ? null : prefs.getBool(index);
    return stringValue;
  }

  static Future<double?> getDoubleVal(String index) async {
    prefs = await SharedPreferences.getInstance();
    //Return String
    double? stringValue = prefs.getDouble(index);
    //== null ? null : prefs.getDouble(index);
    return stringValue;
  }

  static removeSession(String index) async {
    prefs = await SharedPreferences.getInstance();
    prefs.remove("stringValue");
  }

  static void clear() async {
    prefs = await SharedPreferences.getInstance();
    prefs.clear();
    // ignore: deprecated_member_use
    prefs.commit();
  }
}
