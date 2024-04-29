// ignore_for_file: must_be_immutable, deprecated_member_use
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:magical_food/auth/auth.dart';
import 'package:magical_food/pages/drawer/mainUi.dart';
import 'package:magical_food/util/theme_provider.dart';
import 'package:pinput/pinput.dart';

import 'phone.dart';

class PhoneOtp extends StatefulWidget {
  String mail, name, password, imageUrl, ph;

  PhoneOtp(
      {super.key,
      required this.ph,
      required this.imageUrl,
      required this.mail,
      required this.name,
      required this.password});

  @override
  State<PhoneOtp> createState() => _PhoneOtpState();
}

class _PhoneOtpState extends State<PhoneOtp> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    var code = "";
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
              child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "OTP Verification",
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Enter the verification code we just sent on your phone number",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 50),

                      Pinput(
                        length: 6,
                        showCursor: true,
                        onChanged: (value) {
                          code = value;
                        },
                      ),
                      //  Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     Otp(otpController: _otp1Controller),
                      //     SizedBox(width: 10),
                      //     Otp(otpController: _otp2Controller),
                      //     SizedBox(width: 10),
                      //     Otp(otpController: _otp3Controller),
                      //     SizedBox(width: 10),
                      //     Otp(otpController: _otp4Controller),
                      //   ],
                      // ),
                      SizedBox(
                        height: 30,
                      ),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                              onPressed: () async {
                                // if (await widget.myauth.verifyOTP(
                                //         otp: _otp1Controller.text +
                                //             _otp2Controller.text +
                                //             _otp3Controller.text +
                                //             _otp4Controller.text) ==
                                //     true) {
                                //   // ThemeProvider().login();
                                //   // Navigator.of(context)
                                //   //     .push(MaterialPageRoute(builder: (context) {
                                //   //   return MainGmailUi();
                                //   // }));

                                //   try {
                                //     await auth.sendPasswordResetEmail(
                                //         email: widget.mail);
                                //     ScaffoldMessenger.of(context).showSnackBar(
                                //         SnackBar(content: Text("Success ")));
                                //     Navigator.of(context).pop();
                                //   } on FirebaseAuthException catch (e) {
                                //     ScaffoldMessenger.of(context).showSnackBar(
                                //         SnackBar(content: Text(e.message!)));
                                //     return print(e);
                                //   }
                                //   ScaffoldMessenger.of(context)
                                //       .showSnackBar(SnackBar(content: Text("Success")));
                                //   Navigator.of(context).pop();
                                // } else {
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //       SnackBar(content: Text("Invalid OTP")));
                                // }

                                try {
                                  PhoneAuthCredential credential =
                                      PhoneAuthProvider.credential(
                                          verificationId: Phone.verify,
                                          smsCode: code);
                                  print(credential.toString());
                                  Auth().register(
                                      widget.mail,
                                      widget.password,
                                      context,
                                      widget.imageUrl,
                                      widget.name,
                                      widget.ph);
                                  ThemeProvider().login();

                                  // await auth.signInWithCredential(credential);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("success")));

                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(builder: (context) {
                                    return MainGmailUi();
                                  }), (route) => false);
                                } on FirebaseAuthException catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        e.message.toString(),
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Text("Verify OTP"))),
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
