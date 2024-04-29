// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:magical_food/pages/order_store/admin/order.dart';
import 'package:magical_food/pages/order_store/admin/sms.dart';
import 'package:url_launcher/url_launcher.dart';

class RecordOrderDetail extends StatefulWidget {
  String id;
  String totalAmt;
  String phone, description;
  RecordOrderDetail(this.id, this.totalAmt, this.phone, this.description);
  @override
  State<RecordOrderDetail> createState() => _RecordOrderDetailState();
}

class _RecordOrderDetailState extends State<RecordOrderDetail> {
  TextEditingController _controllerDescription = TextEditingController();
  @override
  void initState() {
    _controllerDescription.text = widget.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          elevation: 1,
          backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
          title: Text(
            "Order List",
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        body: FutureBuilder(
            future: Orders().getOrder(widget.id),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              return snapshot.data == null
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 10, left: 8, right: 8),
                                child: Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 5, color: Colors.black)
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                      snapshot.data!.docs[index]
                                                          ["imageUrl"]),
                                                  radius: 40,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(snapshot.data!
                                                        .docs[index]["name"]
                                                        .toString()),
                                                    SizedBox(height: 10),
                                                    Text(snapshot
                                                            .data!
                                                            .docs[index]
                                                                ["price"]
                                                            .toString() +
                                                        " MMK"),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Quty"),
                                                    SizedBox(height: 10),
                                                    Text(snapshot.data!
                                                        .docs[index]["qty"]
                                                        .toString()),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Card(
                            child: TextFormField(
                              controller: _controllerDescription,
                              maxLines: null,
                              readOnly: true,
                              textInputAction: TextInputAction.newline,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(1))),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(color: Colors.black, blurRadius: 4)
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        "Total Amount : ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        widget.totalAmt + " MMK",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
            }));
  }
}
