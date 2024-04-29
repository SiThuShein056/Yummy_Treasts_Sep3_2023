// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:magical_food/auth/auth.dart';
import 'package:magical_food/pages/customer_role/primary_screen/poduct_detail/product_detail_ob.dart';

import 'create_product.dart';
import 'edit_page.dart';

class EditProducts extends StatefulWidget {
  @override
  State<EditProducts> createState() => _EditProductsState();
}

class _EditProductsState extends State<EditProducts> {
  Stream<QuerySnapshot<Map<String, dynamic>>> categoryProducts =
      FirebaseFirestore.instance
          .collection("products")
          .where("category", isEqualTo: "7a2Ap5WbolfjWKNaXGrn")
          .snapshots();

  Stream<QuerySnapshot> productsList =
      FirebaseFirestore.instance.collection("products").snapshots();
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
                  Auth().deleteProduct(uid);
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
    Stream<QuerySnapshot> categoryList =
        FirebaseFirestore.instance.collection("categories").snapshots();

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Edit Products",
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
      // body: StreamBuilder<QuerySnapshot?>(
      //     stream: productsList,
      //     builder: (context, AsyncSnapshot<QuerySnapshot?> snapshot) {
      //       if (snapshot.hasData) {
      //         return ListView.builder(
      //             itemCount: snapshot.data!.docs.length,
      //             itemBuilder: ((context, index) {
      //               return Card(
      //                 child: Row(
      //                   children: [
      //                     Container(
      //                       width: 50,
      //                       height: 50,
      //                       child: ClipOval(
      //                         child: Image.network(
      //                           snapshot.data!.docs[index]["imageUrl"],
      //                           fit: BoxFit.cover,
      //                         ),
      //                       ),
      //                     ),
      //                     SizedBox(width: 20),
      //                     Column(
      //                       mainAxisAlignment: MainAxisAlignment.start,
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: [
      //                         Text(snapshot.data!.docs[index]["name"]),
      //                         Text(snapshot.data!.docs[index]["price"]
      //                             .toString()),
      //                         Text(snapshot.data!.docs[index]["discount"]),
      //                       ],
      //                     ),
      //                     Spacer(),
      //                     IconButton(
      //                         onPressed: () {
      //                           Navigator.of(context)
      //                               .push(MaterialPageRoute(builder: (context) {
      //                             return EditPage(
      //                                 id: snapshot.data!.docs[index].id);
      //                           }));
      //                         },
      //                         icon: Icon(Icons.edit)),
      //                     SizedBox(width: 20),
      //                     IconButton(
      //                         onPressed: () {
      //                           Auth()
      //                               .deleteItem(snapshot.data!.docs[index].id);
      //                         },
      //                         icon: Icon(Icons.delete))
      //                   ],
      //                 ),
      //               );
      //             }));
      //       } else if (snapshot.hasError) {
      //         return Center(child: Text("error"));
      //       } else {
      //         return Center(
      //           child: CircularProgressIndicator(),
      //         );
      //       }
      //     }),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot?>(
              stream: categoryList,
              builder: (context, AsyncSnapshot<QuerySnapshot?> snapshot) {
                return snapshot.data == null
                    ? CircularProgressIndicator()
                    : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 40,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    categoryProducts = FirebaseFirestore
                                        .instance
                                        .collection("products")
                                        .where("category",
                                            isEqualTo:
                                                snapshot.data!.docs[index].id)
                                        .snapshots();
                                  });
                                },
                                child: Card(
                                  shadowColor: Colors.grey,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Center(
                                      child: Text(
                                          snapshot.data!.docs[index]['name']),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
              }),
          SizedBox(height: 10),
          Expanded(
            child: StreamBuilder(
                stream: categoryProducts,
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  return snapshot.data == null
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        child: ClipOval(
                                          child: Image.network(
                                            snapshot.data!.docs[index]
                                                ["imageUrl"],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                          snapshot.data!.docs[index]["name"]),
                                    ),
                                    Spacer(),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return EditPage(
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
          ),
        ],
      ),
    );
  }
}
