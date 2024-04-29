import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:magical_food/auth/auth.dart';
import 'package:magical_food/util/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../customer_role/primary_screen/poduct_detail/product_detail_ob.dart';

class CreateDiscountProducts extends StatefulWidget {
  const CreateDiscountProducts({super.key});

  @override
  State<CreateDiscountProducts> createState() => _CreateDiscountProductsState();
}

class _CreateDiscountProductsState extends State<CreateDiscountProducts> {
  Stream<QuerySnapshot> categoryList =
      FirebaseFirestore.instance.collection("categories").snapshots();
  Future<QuerySnapshot<Map<String, dynamic>>> categoryProducts =
      FirebaseFirestore.instance
          .collection("products")
          .where("category", isEqualTo: "7a2Ap5WbolfjWKNaXGrn")
          .get();
  Stream<QuerySnapshot> productsList =
      FirebaseFirestore.instance.collection("products").snapshots();

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, ThemeProvider tp, child) {
      return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              "Select Product",
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
            )),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: StreamBuilder<QuerySnapshot?>(
                  stream: categoryList,
                  builder: (context, AsyncSnapshot<QuerySnapshot?> snapshot) {
                    return snapshot.data == null
                        ? CircularProgressIndicator()
                        : Container(
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
                                          .get();
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
                          );
                  }),
            ),
            SizedBox(height: 10),
            Expanded(
              child: FutureBuilder(
                  future: categoryProducts,
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    return snapshot.data == null
                        ? Center(child: CircularProgressIndicator())
                        : GridView.builder(
                            padding: EdgeInsets.all(10),
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: .7, crossAxisCount: 3),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return Card(
                                shadowColor: Colors.green,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Hero(
                                        transitionOnUserGestures: true,
                                        tag: snapshot.data!.docs[index]
                                            ['imageUrl'],
                                        child: Card(
                                          clipBehavior: Clip.antiAlias,
                                          child: Image.network(
                                            snapshot.data!.docs[index]
                                                ['imageUrl'],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(snapshot.data!.docs[index]['name']),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: IconButton(
                                          onPressed: () {
                                            ProductDetailOb pOb =
                                                ProductDetailOb(
                                                    snapshot.data!.docs[index]
                                                        ['description'],
                                                    snapshot
                                                        .data!.docs[index].id,
                                                    snapshot.data!.docs[index]
                                                        ['imageUrl'],
                                                    // snapshot.data!.docs[index]['location'],
                                                    snapshot.data!.docs[index]
                                                        ['name'],
                                                    snapshot.data!.docs[index]
                                                        ['price']);

                                            Auth().createDiscountProduct(
                                              snapshot.data!.docs[index]
                                                  ['name'],
                                              snapshot.data!.docs[index]
                                                  ['price'],
                                              snapshot.data!.docs[index]
                                                  ['category'],
                                              snapshot.data!.docs[index]
                                                  ['imageUrl'],
                                              snapshot.data!.docs[index]
                                                  ['description'],
                                            );

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    backgroundColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    content: Text(
                                                        "Create Success")));
                                          },
                                          icon: Icon(Icons
                                              .add_circle_outline_outlined)),
                                    )
                                  ],
                                ),
                              );
                            });
                  }),
            ),
          ],
        ),
      );
    });
  }
}
