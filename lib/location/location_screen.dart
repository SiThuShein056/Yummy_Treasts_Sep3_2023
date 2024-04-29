import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:magical_food/util/locaton_service.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  Set<Marker> markers = {};
  Completer<GoogleMapController> _completer = Completer();
  String co = "";
  String local = "";
  String tf = "";
  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  checkPermission() {
    if (UserLocation.lat != 0 && UserLocation.log != 0) {
      markers.add(Marker(
          markerId: MarkerId("1"),
          position: LatLng(UserLocation.lat, UserLocation.log)));
    }
  }

  getLocationDetail() async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(UserLocation.lat, UserLocation.log);
    print(placemark[1].country);
    print(placemark[0].locality);
    print(placemark[0].thoroughfare);
    print(placemark[0].street);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UserLocation.lat != 0 || UserLocation.log != 0
          ? GoogleMap(
              markers: markers,
              mapType: MapType.hybrid,
              zoomControlsEnabled: false,
              initialCameraPosition: CameraPosition(
                // target: LatLng(20.14956, 94.93246),
                target: LatLng(UserLocation.lat, UserLocation.log),
                zoom: 15,
              ),
              onMapCreated: (controller) {
                _completer.complete(controller);
              },
              onTap: (argument) {
                print(argument.latitude.toString() +
                    "  " +
                    argument.longitude.toString());
                setState(() {
                  UserLocation.lat = argument.latitude;
                  UserLocation.log = argument.longitude;

                  markers.add(Marker(
                    markerId: MarkerId("1"),
                    position: LatLng(UserLocation.lat, UserLocation.log),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueRed),
                  ));
                });
              },
            )
          : Container(),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            getLocationDetail();
            Navigator.of(context).pop();
          },
          label: Text("Confirm")),
    );
  }
}
