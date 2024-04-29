import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:magical_food/pages/order_store/admin/order.dart';
import 'package:magical_food/pages/order_store/customer/record_order/record_order_detail.dart';

class RecordOrdered extends StatefulWidget {
  const RecordOrdered({super.key});

  @override
  State<RecordOrdered> createState() => _RecirdOrderedState();
}

class _RecirdOrderedState extends State<RecordOrdered> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Orders().getcurrentCustomerData(),
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
                  : ListView.builder(
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
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        sanapshot.data!.docs[indext]['phone']
                                            .toString(),
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    TextButton.icon(
                                        onPressed: null,
                                        icon: !sanapshot.data!.docs[indext]
                                                ["confirm"]
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
                                        label: !sanapshot.data!.docs[indext]
                                                ["confirm"]
                                            ? Text(
                                                "Pending",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              )
                                            : Text("Confirm",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor)))
                                  ],
                                ),
                                Text(
                                  "Record time",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  sanapshot.data!.docs[indext]["record_time"],
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                SizedBox(height: 30),
                                Text(
                                  "Order time",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: Text(
                                        sanapshot.data!.docs[indext]["date"] +
                                            "," +
                                            sanapshot.data!.docs[indext]
                                                ["time"],
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      )),
                                      IconButton(
                                          onPressed: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return RecordOrderDetail(
                                                  sanapshot
                                                      .data!.docs[indext].id,
                                                  sanapshot.data!.docs[indext]
                                                      ['totalAmt'],
                                                  sanapshot.data!.docs[indext]
                                                      ['phone'],
                                                  sanapshot.data!.docs[indext]
                                                      ['description']);
                                            }));
                                          },
                                          icon: Icon(
                                            Icons.remove_red_eye,
                                            color: Colors.green,
                                          )),
                                      // IconButton(
                                      //     onPressed: () {},
                                      //     icon: Icon(
                                      //       Icons.delete,
                                      //       color: Colors.red,
                                      //     )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
        });
  }
}
