import 'package:flutter/material.dart';
import 'package:magical_food/util/shf.dart';

class OrderNotiProvider extends ChangeNotifier {
  int noti = 0;

  getData() {
    SharedPref.getData(key: "notiamt").then((value) {
      if (value != null) {
        noti = int.parse(value);
      }
      notifyListeners();
    });
  }

  addNoti() {
    noti++;
    notifyListeners();
    print(noti);
    SharedPref.setData(key: "notiamt", value: noti.toString());
  }

  resetNoti() {
    noti = 0;
    notifyListeners();
    SharedPref.setData(key: "notiamt", value: noti.toString());
  }
}
