// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:magical_food/auth/auth.dart';
import 'package:magical_food/pages/admin_role/special_list/edit_sp_widget.dart';
import 'package:magical_food/pages/customer_role/primary_screen/poduct_detail/product_detail_ob.dart';

class EditSpecialFood extends StatefulWidget {
  @override
  State<EditSpecialFood> createState() => _EditSpecialFoodState();
}

class _EditSpecialFoodState extends State<EditSpecialFood> {
  Stream<QuerySnapshot> refs =
      FirebaseFirestore.instance.collection("speciallist").snapshots();
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
                  Auth().deleteSpecialFood(uid);
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
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Edit Special Food",
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
      body: StreamBuilder<QuerySnapshot?>(
          stream: refs,
          builder: (context, AsyncSnapshot<QuerySnapshot?> snapshot) {
            return snapshot.data == null
                ? Center(child: CircularProgressIndicator())
                : snapshot.data!.docs.length == 0
                    ? Center(
                        child: Text("Not yet have Special Food"),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(10),
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          ProductDetailOb pOb = ProductDetailOb(
                              snapshot.data!.docs[index]['description'],
                              snapshot.data!.docs[index].id,
                              snapshot.data!.docs[index]['imageUrl'],
                              // snapshot.data!.docs[index]['location'],
                              snapshot.data!.docs[index]['name'],
                              snapshot.data!.docs[index]['price']);

                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    child: ClipOval(
                                      child: Image.network(
                                        snapshot.data!.docs[index]["imageUrl"],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(snapshot.data!.docs[index]["name"]),
                                      Text(snapshot.data!.docs[index]["price"]
                                          .toString()),
                                    ],
                                  ),
                                  Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return EditSpWidget(
                                              id: snapshot
                                                  .data!.docs[index].id);
                                        }));
                                      },
                                      icon: Icon(Icons.edit)),
                                  SizedBox(width: 20),
                                  IconButton(
                                      onPressed: () {
                                        deleteProcess(context,
                                            snapshot.data!.docs[index].id);
                                      },
                                      icon: Icon(Icons.delete))
                                ],
                              ),
                            ),
                          );
                        });
          }),
    );
  }
}
