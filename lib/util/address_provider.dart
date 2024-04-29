import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

import 'locaton_service.dart';

class AddressProvider extends ChangeNotifier {
  String country = "";
  String city = "";
  String street = "";
  changeLatLog(double latitude, double longitude) {
    UserLocation.lat = latitude;
    UserLocation.log = longitude;

    notifyListeners();
  }

  getLocationAddress() async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(UserLocation.lat, UserLocation.log);

    changeAddress(placemark[0].country.toString(),
        placemark[0].locality.toString(), placemark[0].thoroughfare.toString());

    notifyListeners();
  }

  changeAddress(String co, String ci, String str) {
    country = co;
    city = ci;
    street = str;
    notifyListeners();
  }
}
