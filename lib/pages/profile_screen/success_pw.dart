import 'package:flutter/material.dart';
import 'package:magical_food/pages/profile_screen/profile_screen.dart';

class FinishPasswordChange extends StatefulWidget {
  const FinishPasswordChange({super.key});

  @override
  State<FinishPasswordChange> createState() => _FinishPasswordChangeState();
}

class _FinishPasswordChangeState extends State<FinishPasswordChange> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage("assets/images/confirm2.jpeg"),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "We just sent a link to your mail to change password",
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("Success")));
                    },
                    child: Text("Done"))
              ],
            ),
          )
        ],
      ),
    );
  }
}
