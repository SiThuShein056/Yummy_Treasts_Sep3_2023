// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:magical_food/auth/auth.dart';
import 'package:magical_food/pages/register_login/mail_register/login_screen.dart';
import 'package:magical_food/pages/register_login/phone_register/phone.dart';
import 'package:magical_food/util/theme_provider.dart';
import 'package:pinput/pinput.dart';

class RegisterOtpScreen extends StatefulWidget {
  EmailOTP myauth;
  String mail, name, password, imageUrl, phone;

  RegisterOtpScreen({
    required this.myauth,
    required this.mail,
    required this.imageUrl,
    required this.name,
    required this.password,
    required this.phone,
  });
  @override
  State<RegisterOtpScreen> createState() => _RegisterOtpScreenState();
}

class _RegisterOtpScreenState extends State<RegisterOtpScreen> {
  var code = "";
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                      Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                              onPressed: () async {
                                if (await widget.myauth
                                        .verifyOTP(otp: code.toString()) ==
                                    true) {
                                  // Navigator.of(context).push(
                                  //     MaterialPageRoute(builder: (context) {
                                  //   return Phone(
                                  //     mail: widget.mail,
                                  //     password: widget.password,
                                  //     imageUrl: widget.imageUrl,
                                  //     name: widget.name,
                                  //   );
                                  // }));

                                  Auth().register(
                                      widget.mail,
                                      widget.password,
                                      context,
                                      widget.imageUrl,
                                      widget.name,
                                      widget.phone);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Invalid OTP")));
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
