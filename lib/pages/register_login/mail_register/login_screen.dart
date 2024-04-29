// ignore_for_file: deprecated_member_use
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:magical_food/auth/auth.dart';
import 'package:magical_food/pages/drawer/mainUi.dart';
import 'package:magical_food/pages/profile_screen/forgot_password.dart';
import 'package:magical_food/util/theme_provider.dart';

import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _mailControler = TextEditingController();

  TextEditingController _passWordController = TextEditingController();
  bool check = false;
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
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Glad to see you",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 9, 191, 24),
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(height: 20),
                      TextFormField(
                        style: TextStyle(color: Colors.grey),
                        controller: _mailControler,
                        keyboardType: TextInputType.emailAddress,
                        // maxLength: 8,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.grey),
                          contentPadding: EdgeInsets.all(15),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          prefixIcon: Icon(
                            Icons.mail,
                            color: Colors.grey,
                          ),
                          hintText: 'EMail',
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        style: TextStyle(color: Colors.grey),
                        controller: _passWordController,
                        // cursorRadius: Radius.circular(10),
                        // cursorWidth: 20,
                        // cursorHeight: 20,
                        obscureText: !check,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.grey),
                          contentPadding: EdgeInsets.all(15),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          prefixIcon: Icon(
                            Icons.key,
                            color: Colors.grey,
                          ),
                          // suffixIcon: TextButton(
                          //     onPressed: () {
                          //       Navigator.of(context)
                          //           .push(MaterialPageRoute(builder: (context) {
                          //         return ForgotPassword();
                          //       }));
                          //     },
                          //     child: Padding(
                          //       padding: const EdgeInsets.all(8.0),
                          //       child: Text(
                          //         "FORGOT",
                          //         style: TextStyle(color: Colors.red),
                          //       ),
                          //     )),
                          suffixIcon: check
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      check = false;
                                    });
                                  },
                                  icon: Icon(Icons.visibility))
                              : IconButton(
                                  onPressed: () {
                                    setState(() {
                                      check = true;
                                    });
                                  },
                                  icon: Icon(Icons.visibility_off)),

                          hintText: 'Password',
                        ),
                      ),
                      SizedBox(height: 5),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return ForgotPassword();
                              }));
                            },
                            child: Text("Forgot Password")),
                      ),
                      InkWell(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              // gradient: LinearGradient(colors: [
                              //   Color.fromARGB(255, 85, 233, 80),
                              //   Color.fromARGB(255, 236, 240, 180)
                              // ], begin: Alignment.topRight, end: Alignment.bottomLeft),
                              color: Theme.of(context).primaryColor,
                            ),
                            child: Center(
                                child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                          onTap: () async {
                            Map<String, dynamic> status = await Auth().login(
                                _mailControler.text,
                                _passWordController.text,
                                context);

                            if (status["status"]) {
                              ThemeProvider().login();
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) {
                                return MainGmailUi();
                              }));
                              // myauth.setConfig(
                              //     appEmail: "hhtz12450@gmail.com",
                              //     appName: "EmailOTP",
                              //     userEmail: _mailControler.text,
                              //     otpLength: 4,
                              //     otpType: OTPType.digitsOnly);
                              // if (await myauth.sendOTP() == true) {
                              //   Navigator.of(context)
                              //       .push(MaterialPageRoute(builder: (context) {
                              //     return OtpScreen(myauth: myauth);
                              //   }));
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //       SnackBar(content: Text("Otp has been sent")));
                              // } else {
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //       SnackBar(content: Text("Otp sent fail")));
                              // }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Something Fail")));
                            }
                          }),
                      SizedBox(
                        height: 200,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          InkWell(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(color: Colors.red),
                            ),
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return RegisterScreen();
                              }));
                            },
                          )
                        ],
                      )
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
