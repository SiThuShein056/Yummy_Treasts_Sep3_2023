import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import 'forgot_password.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  var _old = TextEditingController();
  var _new = TextEditingController();
  bool check = false;

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
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Change Password",
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Enter  your old password correctly",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 50),
                    TextFormField(
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      controller: _old,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          hintText: "old password",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 5,
                                  color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _new,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      obscureText: check,
                      decoration: InputDecoration(
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
                          contentPadding: EdgeInsets.all(10),
                          hintText: "new password",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        buildButton(),
                        Spacer(),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return ForgotPassword();
                              }));
                            },
                            child: Text("Forgot Password")),
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () async {
                          if (_new.text.length < 8) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "At least, your password must have 8 length")));

                            return;
                          }
                          await changePassword(
                              FirebaseAuth.instance.currentUser!.email,
                              _new.text,
                              _old.text);
                        },
                        child: Text("Change Password"))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  var currentUser = FirebaseAuth.instance.currentUser;
  changePassword(email, newpass, oldpass) async {
    var cred = EmailAuthProvider.credential(email: email, password: oldpass);
    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      currentUser!.updatePassword(newpass);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Success"),
        ),
      );
      Navigator.of(context).pop();
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.toString(),
          ),
        ),
      );
    });
  }

  ElevatedButton buildButton() {
    return ElevatedButton(
        onPressed: () {
          _new.text = generatePassword();
        },
        child: Text("Suggess Password"));
  }
}

String generatePassword({
  bool hasLetters = true,
  bool hasNumbers = true,
  bool hasSpecial = true,
}) {
  final length = 20;
  final lettersLowercase = 'abcdefghijklmnopqrstuvwxyz';
  final lettersUppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  final numbers = '0123456789';
  final special = '@#=+!\$%&>?(){}';

  String chars = '';
  if (hasLetters) chars += '$lettersLowercase$lettersUppercase';
  chars += '$numbers';
  chars += '$special';
  return List.generate(length, (index) {
    final indexRandom = Random().nextInt(chars.length);
    return chars[indexRandom];
  }).join('');
}
