// ignore_for_file: deprecated_member_use

import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:magical_food/pages/profile_screen/otp_screen.dart';
import 'package:magical_food/pages/register_login/mail_register/login_screen.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _mailControler = TextEditingController();
  final auth = FirebaseAuth.instance;
  EmailOTP myauth = EmailOTP();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Forgot Password?",
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Don\'t worry it occurs.Please enter the mail address linked with your account",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      controller: _mailControler,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon: Icon(
                          Icons.mail,
                          color: Colors.grey,
                        ),
                        hintText: 'EMail',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).primaryColor),
                        child: Center(
                            child: Text(
                          "Sent OTP",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                      ),
                      onTap: () async {
                        myauth.setConfig(
                            appEmail: "hhtz12450@gmail.com",
                            appName: "EmailOTP",
                            userEmail: _mailControler.text,
                            otpLength: 6,
                            otpType: OTPType.digitsOnly);
                        if (await myauth.sendOTP() == true) {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return OtpScreen(
                                myauth: myauth, mail: _mailControler.text);
                          }));
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Otp has been sent")));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Otp sent fail")));
                        }

                        // try {
                        //   await auth.sendPasswordResetEmail(
                        //       email: _mailControler.text);
                        //   ScaffoldMessenger.of(context)
                        //       .showSnackBar(SnackBar(content: Text("Success ")));
                        //   Navigator.of(context).pop();
                        // } on FirebaseAuthException catch (e) {
                        //   ScaffoldMessenger.of(context)
                        //       .showSnackBar(SnackBar(content: Text(e.message!)));
                        //   return print(e);
                        // }
                      },
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Remember Password "),
                        InkWell(
                          child: Text(
                            "Sign in",
                            style: TextStyle(color: Colors.red),
                          ),
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return LoginScreen();
                            }));
                          },
                        )
                      ],
                    )
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
