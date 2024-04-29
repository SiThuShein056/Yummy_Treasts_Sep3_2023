import 'package:flutter/material.dart';
import 'package:magical_food/pages/drawer/mainUi.dart';

class FinishOrdered extends StatefulWidget {
  const FinishOrdered({super.key});

  @override
  State<FinishOrdered> createState() => _FinishOrderedState();
}

class _FinishOrderedState extends State<FinishOrdered> {
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
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage("assets/images/logo1.jpeg"),
                  radius: 100,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) {
                        return MainGmailUi();
                      }), (route) => false);
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
