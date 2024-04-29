import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:magical_food/pages/customer_role/primary_screen/special_food/special_food.dart';
import 'package:magical_food/pages/order_store/customer/all_products.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'category_list.dart';
import 'poduct_detail/product_detail.dart';
import 'poduct_detail/product_detail_ob.dart';

class PrimaryWidget extends StatefulWidget {
  const PrimaryWidget({super.key});

  @override
  State<PrimaryWidget> createState() => _PrimaryWidgetState();
}

class _PrimaryWidgetState extends State<PrimaryWidget> {
  Stream<QuerySnapshot> refs =
      FirebaseFirestore.instance.collection("speciallist").snapshots();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            "Today Special Menus",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),

        StreamBuilder<QuerySnapshot?>(
            stream: refs,
            builder: (context, AsyncSnapshot<QuerySnapshot?> snapshot) {
              return snapshot.data == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : snapshot.data!.docs.length == 0
                      ? Container(
                          height: 100,
                          color: Colors.white,
                          child: Center(
                              child: Text(
                            "Today is not Special List",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          )),
                        )
                      : CarouselSlider(
                          items: snapshot.data!.docs.map((e) {
                            return InkWell(
                              onTap: () {
                                ProductDetailOb pOb = ProductDetailOb(
                                    e['description'],
                                    e.id,
                                    e['imageUrl'],
                                    // snapshot.data!.docs[index]['location'],
                                    e['name'],
                                    e['price']);

                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return ProductDetail(pOb);
                                }));
                              },
                              child: Card(
                                shadowColor: Colors.grey,
                                clipBehavior: Clip.antiAlias,
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              e["imageUrl"],
                                            ),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          options: CarouselOptions(
                              autoPlay: true, viewportFraction: 1),
                        );
            }),
        // Card(
        //   shadowColor: Colors.grey,
        //   child: CarouselSlider(
        //     items:
        //      //   Card(
        //     //     shadowColor: Colors.grey,
        //     //     clipBehavior: Clip.antiAlias,
        //     //     child: Container(
        //     //       width: MediaQuery.of(context).size.width,
        //     //       height: 100,
        //     //       decoration: BoxDecoration(
        //     //           image: DecorationImage(
        //     //               image: AssetImage(
        //     //                 "assets/images/vegetable1.jpg",
        //     //               ),
        //     //               fit: BoxFit.cover)),
        //     //     ),
        //     //   )
        //     ,
        //     // items: [
        //     //   Card(
        //     //     shadowColor: Colors.grey,
        //     //     clipBehavior: Clip.antiAlias,
        //     //     child: Container(
        //     //       width: MediaQuery.of(context).size.width,
        //     //       height: 100,
        //     //       decoration: BoxDecoration(
        //     //           image: DecorationImage(
        //     //               image: AssetImage(
        //     //                 "assets/images/vegetable1.jpg",
        //     //               ),
        //     //               fit: BoxFit.cover)),
        //     //     ),
        //     //   ),
        //     //   Card(
        //     //     shadowColor: Colors.grey,
        //     //     clipBehavior: Clip.antiAlias,
        //     //     child: Container(
        //     //       width: MediaQuery.of(context).size.width,
        //     //       height: 100,
        //     //       decoration: BoxDecoration(
        //     //           image: DecorationImage(
        //     //               image: AssetImage(
        //     //                 "assets/images/vegetable2.jpg",
        //     //               ),
        //     //               fit: BoxFit.cover)),
        //     //     ),
        //     //   ),
        //     // ],
        //     options: CarouselOptions(autoPlay: true, viewportFraction: 1),
        //   ),
        // ),
        Align(
          alignment: Alignment.bottomRight,
          child: TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return SpecialFood();
                }));
              },
              child: Text(
                "Show all",
                style: TextStyle(color: Colors.white),
              )),
        ),
        Divider(
          color: Colors.white,
        ),
        SizedBox(height: 10),
        CategoryList(),
      ],
    );
  }
}
