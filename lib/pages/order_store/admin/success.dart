import 'package:flutter/material.dart';
import 'package:magical_food/pages/drawer/mainUi.dart';
import 'package:magical_food/pages/order_store/admin/order.dart';

class Success extends StatefulWidget {
  Success({super.key, required this.id});
  String id;
  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
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
            top: 70,
            bottom: 0,
            left: 20,
            right: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage("assets/images/logo1.jpeg"),
                  radius: 100,
                ),
                SizedBox(height: 20),
                Text(
                  "Success Confinging process",
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Orders().updateConfirm(widget.id);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Success")));
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) {
                      return MainGmailUi();
                    }), (route) => false);
                  },
                  child: Text("Done"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
