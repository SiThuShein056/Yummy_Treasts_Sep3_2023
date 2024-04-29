import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangeMail extends StatefulWidget {
  const ChangeMail({super.key});

  @override
  State<ChangeMail> createState() => _ChangeMailState();
}

class _ChangeMailState extends State<ChangeMail> {
  var _pass = TextEditingController();
  var _nweMail = TextEditingController();

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Change Mail",
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
                      controller: _pass,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          hintText: "Enter old password",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      controller: _nweMail,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          hintText: "Enter new mail",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                          onPressed: () async {
                            await changeMail(
                              FirebaseAuth.instance.currentUser!.email,
                              _pass.text,
                              _nweMail.text,
                            );
                          },
                          child: Text("Change Mail")),
                    )
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
  changeMail(email, pass, newMail) async {
    var cred = EmailAuthProvider.credential(email: email, password: pass);
    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      currentUser!.updateEmail(newMail);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Success",
          ),
        ),
      );
      // Navigator.of(context).pop();
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
}
