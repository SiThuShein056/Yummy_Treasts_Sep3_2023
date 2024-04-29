import 'package:flutter/material.dart';
import 'package:magical_food/pages/drawer/mainUi.dart';
import 'package:magical_food/pages/order_store/admin/order.dart';
import 'package:magical_food/pages/order_store/admin/success.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

import 'ordered_customer_list.dart';

class SendSMS extends StatefulWidget {
  SendSMS({super.key, required this.phone, required this.id});
  String phone;
  String id;
  @override
  State<SendSMS> createState() => _SendSMSState();
}

class _SendSMSState extends State<SendSMS> {
  var _ID = "";
  Future<void> sendSMS(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
      queryParameters: <String, dynamic>{
        'body': Uri.decodeComponent(
            "Your order is confirmed.Please wait a few minutes.Order ID : ${_ID}"),
      },
    );
    await launchUrl(launchUri);
  }

  void sendMessage(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Send SMS to the customer",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            content: Text(
              "To close , tap the any remaining screen",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            actions: [
              TextButton.icon(
                  onPressed: () {
                    setState(() {
                      const uuid = Uuid();
                      _ID = uuid.v4();
                    });
                    sendSMS(widget.phone);

                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return Success(id: widget.id);
                    }));
                  },
                  icon: Icon(Icons.sms),
                  label: Text("SMS")),
            ],
          );
        });
  }

  void deleteProcess(context, uid) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Delete?",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            content: Text(
              "Are you sure to delete ?",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel")),
              ElevatedButton(
                onPressed: () {
                  Orders().deleteOrder(uid);
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Success")));
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) {
                    return MainGmailUi();
                  }), (route) => false);
                },
                child: Text("Ok"),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
        title: Text(
          "SMS Code",
          style: TextStyle(color: Colors.white),
        ),
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        //   icon: Icon(
        //     Icons.arrow_back_ios,
        //     color: Colors.white,
        //   ),
        // ),
      ),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      sendMessage(context);
                    },
                    child: Text("Send SMS")),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    deleteProcess(context, widget.id);
                  },
                  child: Text("Delete Order"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
