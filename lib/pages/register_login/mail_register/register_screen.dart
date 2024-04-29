// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'dart:math';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'register_otp.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _mailControler = TextEditingController();

  TextEditingController _passWordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _controllerPhone = TextEditingController();

  final auth = FirebaseAuth.instance;
  EmailOTP myauth = EmailOTP();

  bool check = false;

  int groupValue = 0;

  String imageUrl = '';
  final picker = ImagePicker();

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
                key: _formKey,
                child: Column(children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: selectImage,
                    child: Container(
                        clipBehavior: Clip.antiAlias,
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(),
                        ),
                        child: imageUrl.isEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.person),
                                  Text(
                                    "Upload profile",
                                    style: TextStyle(color: Colors.grey),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              )
                            : Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                              )),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    style: TextStyle(color: Colors.grey),
                    controller: _nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "need to fill";
                      }
                      return null;
                    },
                    // cursorRadius: Radius.circular(10),
                    // cursorWidth: 20,
                    // cursorHeight: 20,
                    // cursorColor: Color.fromARGB(255, 118, 30, 233),
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      prefixIcon: Icon(
                        Icons.people,
                        color: Colors.grey,
                      ),
                      hintText: 'Name',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    style: TextStyle(color: Colors.grey),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "need to fill";
                      }
                      return null;
                    },
                    controller: _mailControler,
                    cursorRadius: Radius.circular(10),
                    keyboardType: TextInputType.emailAddress,
                    // cursorWidth: 20,
                    // cursorHeight: 20,
                    // cursorColor: Color.fromARGB(255, 118, 30, 233),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding: EdgeInsets.all(10),
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "need to fill";
                      }
                      return null;
                    },
                    obscureText: !check,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      // suffixIcon: IconButton(
                      //     onPressed: () {
                      //       final data =
                      //           ClipboardData(text: _passWordController.text);
                      //       Clipboard.setData(data);

                      //       ScaffoldMessenger.of(context).showSnackBar(
                      //           SnackBar(content: Text("${data.text}")));
                      //     },
                      //     icon: Icon(Icons.copy)),
                      suffixIcon: check
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  check = false;
                                });
                              },
                              icon: Icon(
                                Icons.visibility,
                                color: Colors.grey,
                              ))
                          : IconButton(
                              onPressed: () {
                                setState(() {
                                  check = true;
                                });
                              },
                              icon: Icon(
                                Icons.visibility_off,
                                color: Colors.grey,
                              )),
                      prefixIcon: Icon(
                        Icons.key,
                        color: Colors.grey,
                      ),
                      hintText: 'Password',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    style: TextStyle(color: Colors.grey),
                    maxLength: 11,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _controllerPhone,
                    cursorRadius: Radius.circular(10),
                    cursorWidth: 10,
                    cursorHeight: 10,
                    cursorColor: Color.fromARGB(255, 147, 230, 147),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "need to fill";
                      }
                      if (!value.startsWith('097') &&
                          !value.startsWith('099') &&
                          !value.startsWith('096') &&
                          !value.startsWith('098') &&
                          !value.startsWith('094') &&
                          !value.startsWith('092')) {
                        return "invalid operator";
                      }
                      if (value.contains("+") ||
                          value.contains("-") ||
                          value.contains("*")) {
                        return "invalid number";
                      }
                      if (value.length != 11) {
                        return "invalid length";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding: EdgeInsets.all(15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Colors.grey,
                      ),
                      hintText: 'Phone number',
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      buildButton(),
                    ],
                  ),
                  SizedBox(height: 50),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      child: Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Center(
                            child: Text(
                          "Register",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                      ),
                      onTap: () async {
                        if (imageUrl.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Select image")));
                          return;
                        }
                        bool isValidate = _formKey.currentState!.validate();
                        if (isValidate) {
                          myauth.setConfig(
                              appEmail: "hhtz12450@gmail.com",
                              appName: "EmailOTP",
                              userEmail: _mailControler.text,
                              otpLength: 6,
                              otpType: OTPType.digitsOnly);
                          if (await myauth.sendOTP() == true) {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return RegisterOtpScreen(
                                myauth: myauth,
                                mail: _mailControler.text,
                                imageUrl: imageUrl,
                                password: _passWordController.text,
                                name: _nameController.text,
                                phone: _controllerPhone.text,
                              );
                            }));
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Otp has been sent")));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Otp sent fail")));
                          }
                        }
                      },
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextButton buildButton() {
    // final backgroundColor = MaterialStateColor.resolveWith((state) =>
    //     state.contains(MaterialState.pressed) ? Colors.yellow : Colors.green);
    return TextButton(
        //  style: TextButton.styleFrom(backgroundColor: backgroundColor),
        onPressed: () {
          _passWordController.text = generatePassword();
        },
        child: Text("Suggess Password"));
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

  selectImage() async {
    ImagePicker imagepicker = ImagePicker();
    XFile? file = await imagepicker.pickImage(source: ImageSource.gallery);

    if (file == null) return;
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    /*step 2: upload to firebase store*/
    //install firebase_storage
    //import the library

    //get a reference to storage root
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');

    //create a reference for the image to be stored
    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

    //Handle error / success
    try {
      //store the file
      await referenceImageToUpload.putFile(File(file.path));
      //success get the download url
      referenceImageToUpload.getDownloadURL().then((value) {
        imageUrl = value;
        setState(() {});
      });
    } catch (e) {
      //some error occur
    }
  }
}
