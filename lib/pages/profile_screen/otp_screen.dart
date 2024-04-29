// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:magical_food/pages/profile_screen/success_pw.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatelessWidget {
  EmailOTP myauth;
  String mail;
  OtpScreen({required this.myauth, required this.mail});
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;

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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        "Enter the verification code we just sent on your email address",
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
                      SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            if (await myauth.verifyOTP(otp: code.toString()) ==
                                true) {
                              try {
                                await auth.sendPasswordResetEmail(email: mail);

                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Success ")));

                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return FinishPasswordChange();
                                }));
                              } on FirebaseAuthException catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(e.message!)));
                                return print(e);
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Invalid OTP")));
                            }
                          },
                          child: Text("Verify OTP")),
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Otp extends StatelessWidget {
  final TextEditingController otpController;
  Otp({required this.otpController});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: TextFormField(
        controller: otpController,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (e) {
          if (e.length == 1) {
            FocusScope.of(context).nextFocus();
          }

          // if (e.isEmpty) {
          //   Focus.of(context).previousFocus();
          // }
        },
        decoration: InputDecoration(
            hintText: '0',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
      ),
    );
  }
}
