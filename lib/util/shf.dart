import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static setData({required key, required value}) async {
    var shp = await SharedPreferences.getInstance();
    shp.setString(key, value);
  }

  static Future<String?> getData({required key}) async {
    var shp = await SharedPreferences.getInstance();
    return shp.getString(key);
  }
}
