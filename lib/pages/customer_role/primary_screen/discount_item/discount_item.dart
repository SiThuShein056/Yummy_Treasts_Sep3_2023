import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:magical_food/auth/auth.dart';
import 'package:magical_food/pages/customer_role/primary_screen/poduct_detail/product_detail.dart';
import 'package:magical_food/util/shf.dart';
import 'package:magical_food/util/theme_provider.dart';
import 'package:provider/provider.dart';

import '../poduct_detail/product_detail_ob.dart';

class DiscountItems extends StatefulWidget {
  const DiscountItems({super.key});

  @override
  State<DiscountItems> createState() => _DiscountItemsState();
}

class _DiscountItemsState extends State<DiscountItems> {
  Stream<QuerySnapshot> refs =
      FirebaseFirestore.instance.collection("discountproducts").snapshots();

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme_provider = Provider.of(context, listen: false);
    theme_provider.checkDiscount();
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Discount Items",
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
            if (snapshot.hasData) {
              return GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 1,
                      crossAxisCount: 2),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        ProductDetailOb pOb = ProductDetailOb(
                            snapshot.data!.docs[index]['description'],
                            snapshot.data!.docs[index].id,
                            snapshot.data!.docs[index]['imageUrl'],
                            // snapshot.data!.docs[index]['location'],
                            snapshot.data!.docs[index]['name'],
                            snapshot.data!.docs[index]['price']);

                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ProductDetail(pOb);
                        }));
                      },
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Hero(
                                transitionOnUserGestures: true,
                                tag: snapshot.data!.docs[index]['imageUrl'],
                                child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    color: Colors.amber,
                                    child: Image.network(
                                      snapshot.data!.docs[index]['imageUrl'],
                                      fit: BoxFit.cover,
                                    )),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Text(snapshot.data!.docs[index]['name']),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      snapshot.data!.docs[index]['price']
                                              .toString() +
                                          " MMK",
                                      style: TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          decorationStyle:
                                              TextDecorationStyle.solid),
                                    ),
                                  ),
                                  Icon(Icons.trending_flat_outlined),
                                  Consumer(builder:
                                      (context, ThemeProvider tp, child) {
                                    return Expanded(
                                      child: Text((snapshot.data!.docs[index]
                                                      ['price'] -
                                                  (snapshot.data!.docs[index]
                                                          ['price'] *
                                                      tp.discount /
                                                      100))
                                              .toString() +
                                          " MMK"),
                                    );
                                  }),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Center(child: Text("error"));
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
