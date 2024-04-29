import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'phone_otp.dart';

class Phone extends StatefulWidget {
  String mail, name, password, imageUrl;

  Phone(
      {super.key,
      required this.imageUrl,
      required this.mail,
      required this.name,
      required this.password});
  static String verify = "";
  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  var _phone = TextEditingController();
  var _coountryCode = TextEditingController();
  var phone = "";

  @override
  void initState() {
    // TODO: implement initState
    _coountryCode.text = "+95";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              child: Image.asset(
                "assets/images/bg4.jpg",
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            top: 100,
            bottom: 0,
            left: 20,
            right: 20,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage("assets/images/ms4.jpg"),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Phone Verification",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 9, 191, 24),
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "We need to register your phone before getting started !",
                    style: TextStyle(
                      color: Color.fromARGB(255, 9, 191, 24),
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    onChanged: (e) {
                      phone = e;
                    },
                    controller: _phone,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: "Enter valid phone"),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      var ph = _coountryCode.text + phone;
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: _coountryCode.text + phone,
                        verificationCompleted:
                            (PhoneAuthCredential phoneAuthCredential) {},
                        verificationFailed: (FirebaseAuthException e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(e.message.toString()),
                            duration: Duration(seconds: 10),
                          ));
                          print(e.message.toString());
                          return;
                        },
                        codeSent: (String verificationId, int? resentToken) {
                          Phone.verify = verificationId;
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                            return PhoneOtp(
                              ph: phone,
                              mail: widget.mail,
                              password: widget.password,
                              imageUrl: widget.imageUrl,
                              name: widget.name,
                            );
                          }));
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );
                    },
                    child: Text("Send Otp code"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
