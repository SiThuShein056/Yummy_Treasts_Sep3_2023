import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:magical_food/util/locaton_service.dart';

class ShopLocation extends StatefulWidget {
  double lat;
  double log;

  ShopLocation({required this.lat, required this.log});

  @override
  State<ShopLocation> createState() => _ShopLocationState();
}

class _ShopLocationState extends State<ShopLocation> {
  Set<Marker> markers = {};
  Completer<GoogleMapController> _completer = Completer();
  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  checkPermission() {
    if (widget.lat != 0 && widget.log != 0) {
      markers.add(Marker(
          markerId: MarkerId("1"), position: LatLng(widget.lat, widget.log)));
    }
  }

  getLocationDetail() async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(widget.lat, widget.log);
    print(placemark[1].country);
    print(placemark[0].locality);
    print(placemark[0].thoroughfare);
    print(placemark[0].street);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shop Location",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
      ),
      body: UserLocation.lat != 0 || UserLocation.log != 0
          ? GoogleMap(
              markers: markers,
              mapType: MapType.hybrid,
              zoomControlsEnabled: false,
              initialCameraPosition: CameraPosition(
                // target: LatLng(20.14956, 94.93246),
                target: LatLng(widget.lat, widget.log),
                zoom: 15,
              ),
              onMapCreated: (controller) {
                _completer.complete(controller);
              },
              // onTap: (argument) {
              //   setState(() {
              //     UserLocation.lat = argument.latitude;
              //     UserLocation.log = argument.longitude;

              //     markers.add(Marker(
              //       markerId: MarkerId("1"),
              //       position: LatLng(UserLocation.lat, UserLocation.log),
              //       icon: BitmapDescriptor.defaultMarkerWithHue(
              //           BitmapDescriptor.hueRed),
              //     ));
              //   });
              // },
            )
          : Container(),
      // floatingActionButton: FloatingActionButton.extended(
      //     onPressed: () {
      //       // getLocationDetail();
      //       Navigator.of(context).pop();
      //     },
      //     label: Text("Confirm")),
    );
  }
}
