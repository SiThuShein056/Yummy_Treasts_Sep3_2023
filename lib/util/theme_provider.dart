import 'package:flutter/material.dart';

import 'shf.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode tm = ThemeMode.light;
  int discount = 0;
  // String checkLogin = "";

  changeDiscount(int num) {
    discount = num;
    notifyListeners();
    SharedPref.setData(key: "discount", value: "${num}");
  }

  checkDiscount() {
    SharedPref.getData(key: "discount").then((value) {
      if (value != null) {
        discount = int.parse(value);
        notifyListeners();
        print(discount);
      }
    });
  }

  checkThemeData() {
    SharedPref.getData(key: "theme").then((value) {
      if (value != null) {
        if (value == "dark") {
          tm = ThemeMode.dark;
        } else {
          tm = ThemeMode.light;
        }
        notifyListeners();
      }
    });
  }

  login() {
    // checkLogin = "true";
    SharedPref.setData(key: "checkLogin", value: "true");
    notifyListeners();
  }

  logout() {
    // checkLogin = "false";
    SharedPref.setData(key: "checkLogin", value: "false");
    notifyListeners();
  }

  changeToSystem() {
    tm = ThemeMode.system;
    notifyListeners();
    SharedPref.setData(key: "theme", value: "system");
  }

  changeToDark() {
    tm = ThemeMode.dark;
    notifyListeners();
    SharedPref.setData(key: "theme", value: "dark");
  }

  changeToLight() {
    tm = ThemeMode.light;
    notifyListeners();
    SharedPref.setData(key: "theme", value: "light");
  }
}
