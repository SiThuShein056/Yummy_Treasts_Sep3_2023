import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:magical_food/auth/auth.dart';
import 'package:magical_food/pages/customer_role/primary_screen/discount_item/discount_item.dart';
import 'package:magical_food/pages/order_store/customer/all_products.dart';
import 'poduct_detail/product_detail.dart';
import 'poduct_detail/product_detail_ob.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  Future<QuerySnapshot<Map<String, dynamic>>> categoryProducts =
      FirebaseFirestore.instance
          .collection("products")
          .where("category", isEqualTo: "7a2Ap5WbolfjWKNaXGrn")
          .get();
  Stream<QuerySnapshot> productsList =
      FirebaseFirestore.instance.collection("products").snapshots();

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> categoryList =
        FirebaseFirestore.instance.collection("categories").snapshots();

    return Column(
      children: [
        StreamBuilder<QuerySnapshot?>(
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
                                categoryProducts = FirebaseFirestore.instance
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
                                  child:
                                      Text(snapshot.data!.docs[index]['name']),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
            }),
        SizedBox(height: 10),
        SingleChildScrollView(
          child: FutureBuilder(
              future: categoryProducts,
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                return snapshot.data == null
                    ? CircularProgressIndicator()
                    : Container(
                        height: 150,
                        child: GridView.builder(
                            padding: EdgeInsets.all(10),
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 1, crossAxisCount: 1),
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

                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return ProductDetail(pOb);
                                  }));
                                },
                                child: Hero(
                                  transitionOnUserGestures: true,
                                  tag: snapshot.data!.docs[index]['imageUrl'],
                                  child: Card(
                                    shadowColor: Colors.green,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Card(
                                            clipBehavior: Clip.antiAlias,
                                            child: Image.network(
                                              snapshot.data!.docs[index]
                                                  ['imageUrl'],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                            snapshot.data!.docs[index]['name']),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }));
              }),
        ),

        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return AllProducts();
                }));
              },
              child: Text(
                "All Products",
                style: TextStyle(color: Colors.white),
              )),
        ),

        Divider(
          color: Colors.white,
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return DiscountItems();
            }));
          },
          child: Card(
            elevation: 2,
            color: Colors.white,
            // clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        image: AssetImage("assets/images/discount2.jpeg"),
                        fit: BoxFit.cover)),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        // SingleChildScrollView(
        //   child: StreamBuilder(
        //       stream: productsList,
        //       builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //         return snapshot.data == null
        //             ? CircularProgressIndicator()
        //             : Container(
        //                 height: 250,
        //                 child: GridView.builder(
        //                     shrinkWrap: true,
        //                     scrollDirection: Axis.horizontal,
        //                     gridDelegate:
        //                         SliverGridDelegateWithFixedCrossAxisCount(
        //                             crossAxisSpacing: 5,
        //                             mainAxisSpacing: 5,
        //                             childAspectRatio: 0.8,
        //                             crossAxisCount: 2),
        //                     itemCount: snapshot.data!.docs.length,
        //                     itemBuilder: (context, index) {
        //                       return InkWell(
        //                         onTap: () {
        //                           ProductDetailOb pOb = ProductDetailOb(
        //                               snapshot.data!.docs[index]['description'],
        //                               snapshot.data!.docs[index].id,
        //                               snapshot.data!.docs[index]['imageUrl'],
        //                               // snapshot.data!.docs[index]['location'],
        //                               snapshot.data!.docs[index]['name'],
        //                               snapshot.data!.docs[index]['price']);

        //                           Navigator.of(context).push(
        //                               MaterialPageRoute(builder: (context) {
        //                             return ProductDetail(pOb);
        //                           }));
        //                         },
        //                         child: Card(
        //                           child: Column(
        //                             crossAxisAlignment:
        //                                 CrossAxisAlignment.stretch,
        //                             mainAxisAlignment: MainAxisAlignment.center,
        //                             children: [
        //                               Expanded(
        //                                 child: Hero(
        //                                   transitionOnUserGestures: true,
        //                                   tag: snapshot.data!.docs[index]
        //                                       ['imageUrl'],
        //                                   child: Card(
        //                                       clipBehavior: Clip.antiAlias,
        //                                       color: Colors.amber,
        //                                       child: Image.network(
        //                                         snapshot.data!.docs[index]
        //                                             ['imageUrl'],
        //                                         fit: BoxFit.cover,
        //                                       )),
        //                                 ),
        //                               ),
        //                               Padding(
        //                                 padding: const EdgeInsets.all(8.0),
        //                                 child: Row(
        //                                   children: [
        //                                     Expanded(
        //                                       child: Text(snapshot
        //                                           .data!.docs[index]['name']),
        //                                     ),
        //                                     Text(snapshot
        //                                             .data!.docs[index]['price']
        //                                             .toString() +
        //                                         " MMK")
        //                                   ],
        //                                 ),
        //                               )
        //                             ],
        //                           ),
        //                         ),
        //                       );
        //                     }),
        //               );
        //       }),
        // ),
      ],
    );
  }
}
