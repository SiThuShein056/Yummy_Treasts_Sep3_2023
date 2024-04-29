import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:magical_food/pages/drawer/mainUi.dart';
import 'package:magical_food/pages/register_login/mail_register/login_screen.dart';
import 'package:magical_food/util/address_provider.dart';
import 'package:magical_food/util/shf.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkPermission();
    checkingLogin();
  }

  checkPermission() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    if (_locationData.latitude != null && _locationData.longitude != null) {
      // setState(() {
      //   UserLocation.lat = _locationData.latitude!;
      //   UserLocation.log = _locationData.longitude!;
      // });

      AddressProvider()
          .changeLatLog(_locationData.latitude!, _locationData.longitude!);
    }
  }

  checkingLogin() {
    Future.delayed(Duration(seconds: 3), () async {
      var checkLogin = await SharedPref.getData(key: "checkLogin");
      if (checkLogin == "true") {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) {
          return MainGmailUi();
        }), (route) => false);
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) {
          return LoginScreen();
        }), (route) => false);
      }
    });
  }

  LinearGradient linearGradient = LinearGradient(colors: [
    Color.fromARGB(255, 116, 230, 50),
    Color.fromRGBO(190, 231, 114, 1),
  ], begin: Alignment.topRight, end: Alignment.bottomLeft);
  LinearGradient textLinear = LinearGradient(colors: [
    Color.fromARGB(255, 41, 197, 10),
    Color.fromARGB(255, 221, 201, 22),
    Colors.white,
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  // gradient: linearGradient,
                  color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage("assets/images/logo1.jpeg"),
                    radius: 80,
                  ),
                  SizedBox(height: 5),
                  ShaderMask(
                    shaderCallback: (Rect rect) {
                      return textLinear.createShader(rect);
                    },
                    child: Text(
                      "Yummy Treats",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.green, //အမြဲ အဖြူ ရောင်ထားမှ ပေါ်တာ
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Text(
                  //   "Yummy Treast",
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 30,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
