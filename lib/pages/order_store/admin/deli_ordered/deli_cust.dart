import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:magical_food/pages/order_store/admin/order.dart';
import 'package:magical_food/pages/order_store/admin/show_order.dart';

import 'ordered_location.dart';

class DeliOrderedCustomer extends StatefulWidget {
  @override
  State<DeliOrderedCustomer> createState() => _DeliOrderedCustomerState();
}

class _DeliOrderedCustomerState extends State<DeliOrderedCustomer> {
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
                  Navigator.of(context).pop();
                },
                child: Text("Ok"),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Orders().getDeliOrderedCustomer(),
        builder: (context, AsyncSnapshot<QuerySnapshot> sanapshot) {
          return sanapshot.data == null
              ? Center(child: CircularProgressIndicator())
              : sanapshot.data!.docs.length == 0
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage:
                              AssetImage("assets/images/noorder1.jpeg"),
                          radius: 80,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "No Orders",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: sanapshot.data!.docs.length,
                          itemBuilder: (context, indext) {
                            return Card(
                              elevation: 2,
                              shadowColor: Theme.of(context).primaryColor,
                              child: Container(
                                margin: EdgeInsets.all(10),
                                width: MediaQuery.of(context).size.width,
                                height: 200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        sanapshot.data!.docs[indext]['name'],
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        sanapshot.data!.docs[indext]["phone"],
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Record time",
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      sanapshot.data!.docs[indext]
                                          ["record_time"],
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "Order time",
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                            sanapshot.data!.docs[indext]
                                                    ["date"] +
                                                "," +
                                                sanapshot.data!.docs[indext]
                                                    ["time"],
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          )),
                                          TextButton.icon(
                                              onPressed: null,
                                              icon: !sanapshot.data!
                                                      .docs[indext]["confirm"]
                                                  ? Icon(
                                                      Icons.sync,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    )
                                                  : Icon(
                                                      Icons.done,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                              label: !sanapshot.data!
                                                      .docs[indext]["confirm"]
                                                  ? Text(
                                                      "Pending",
                                                      style: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor),
                                                    )
                                                  : Text("Confirm",
                                                      style: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor)))
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return OrderedLocation(
                                                  name: sanapshot.data!
                                                      .docs[indext]['name'],
                                                  lat: sanapshot.data!
                                                      .docs[indext]['lat'],
                                                  log: sanapshot.data!
                                                      .docs[indext]['log'],
                                                );
                                              }));
                                            },
                                            icon: Icon(Icons.location_on),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return ShowOrder(
                                                    sanapshot
                                                        .data!.docs[indext].id,
                                                    sanapshot.data!.docs[indext]
                                                        ['totalAmt'],
                                                    sanapshot.data!.docs[indext]
                                                        ["phone"],
                                                    sanapshot.data!.docs[indext]
                                                        ['description'],
                                                  );
                                                }));
                                              },
                                              icon: Icon(
                                                Icons.remove_red_eye,
                                                color: Colors.green,
                                              )),
                                          IconButton(
                                              onPressed: () {
                                                deleteProcess(
                                                    context,
                                                    sanapshot
                                                        .data!.docs[indext].id);
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              )),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            );
                          }),
                    );
        });
  }
}
