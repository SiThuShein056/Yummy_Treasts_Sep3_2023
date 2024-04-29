import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:magical_food/location/location_screen.dart';
import 'package:magical_food/util/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../customer_role/primary_screen/poduct_detail/product_detail.dart';
import '../../customer_role/primary_screen/poduct_detail/product_detail_ob.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  // Stream<QuerySnapshot> refs =
  //     FirebaseFirestore.instance.collection("products").snapshots();
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
              "All Products",
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
                                    childAspectRatio: 1, crossAxisCount: 3),
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
                                    snapshot.data!.docs[index]['price'],
                                  );

                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return ProductDetail(pOb);
                                      },
                                    ),
                                  );
                                },
                                child: Card(
                                  shadowColor: Colors.green,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                      SizedBox(height: 5),
                                      Text(snapshot.data!.docs[index]['name']),
                                      SizedBox(height: 5),
                                    ],
                                  ),
                                ),
                              );
                            });
                  }),
            ),
          ],
        ),
        // body: CustomScrollView(
        //   scrollDirection: Axis.vertical,
        //   // ignore: prefer_const_literals_to_create_immutables
        //   slivers: [
        //     SliverAppBar(
        //       // collapsedHeight: 80,
        //       expandedHeight: 200,
        //       // title: Text("Sliver Ex"),
        //       pinned: true,
        //       // floating: true,
        //       // snap: true,
        //       stretch: true,
        //       //primary: false,
        //       flexibleSpace: FlexibleSpaceBar(
        //         //collapseMode: CollapseMode.parallax,
        //         title: Text(
        //           "Yummy Treast",
        //           style: TextStyle(color: Colors.green),
        //         ),
        //         centerTitle: true,
        //         background: Image.asset(
        //           "assets/images/logo1.jpeg",
        //           fit: BoxFit.cover,
        //         ),
        //         stretchModes: [
        //           StretchMode.zoomBackground,
        //           StretchMode.fadeTitle,
        //         ],
        //       ),
        //     ),
        //     SliverPadding(
        //       padding: EdgeInsets.all(10),
        //       sliver: SliverToBoxAdapter(
        //         child: StreamBuilder<QuerySnapshot?>(
        //             stream: categoryList,
        //             builder: (context, AsyncSnapshot<QuerySnapshot?> snapshot) {
        //               return snapshot.data == null
        //                   ? CircularProgressIndicator()
        //                   : Container(
        //                       height: 40,
        //                       child: ListView.builder(
        //                         scrollDirection: Axis.horizontal,
        //                         itemCount: snapshot.data!.docs.length,
        //                         itemBuilder: (context, index) {
        //                           return InkWell(
        //                             onTap: () {
        //                               setState(() {
        //                                 categoryProducts = FirebaseFirestore
        //                                     .instance
        //                                     .collection("products")
        //                                     .where("category",
        //                                         isEqualTo: snapshot
        //                                             .data!.docs[index].id)
        //                                     .get();
        //                               });
        //                             },
        //                             child: Card(
        //                               shadowColor: Colors.grey,
        //                               child: Padding(
        //                                 padding: const EdgeInsets.all(5.0),
        //                                 child: Center(
        //                                   child: Text(snapshot.data!.docs[index]
        //                                       ['name']),
        //                                 ),
        //                               ),
        //                             ),
        //                           );
        //                         },
        //                       ),
        //                     );
        //             }),
        //       ),
        //     ),

        //     //screen တစ်ခုလုံးနေရာယူတာ
        //     SliverFillRemaining(
        //       hasScrollBody: true, //false so nay yar ah kone ma u tk bu
        //       child: FutureBuilder(
        //           future: categoryProducts,
        //           builder: (context,
        //               AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
        //                   snapshot) {
        //             return snapshot.data == null
        //                 ? CircularProgressIndicator()
        //                 : Container(
        //                     height: 150,
        //                     child: GridView.builder(
        //                         padding: EdgeInsets.all(10),
        //                         scrollDirection: Axis.vertical,
        //                         gridDelegate:
        //                             SliverGridDelegateWithFixedCrossAxisCount(
        //                                 childAspectRatio: 1, crossAxisCount: 3),
        //                         itemCount: snapshot.data!.docs.length,
        //                         itemBuilder: (context, index) {
        //                           return InkWell(
        //                             onTap: () {
        //                               ProductDetailOb pOb = ProductDetailOb(
        //                                   snapshot.data!.docs[index]
        //                                       ['description'],
        //                                   snapshot.data!.docs[index].id,
        //                                   snapshot.data!.docs[index]
        //                                       ['imageUrl'],
        //                                   // snapshot.data!.docs[index]['location'],
        //                                   snapshot.data!.docs[index]['name'],
        //                                   snapshot.data!.docs[index]['price']);

        //                               Navigator.of(context).push(
        //                                   MaterialPageRoute(builder: (context) {
        //                                 return ProductDetail(pOb);
        //                               }));
        //                             },
        //                             child: Card(
        //                               shadowColor: Colors.green,
        //                               child: Column(
        //                                 children: [
        //                                   Expanded(
        //                                     child: Card(
        //                                       clipBehavior: Clip.antiAlias,
        //                                       child: Image.network(
        //                                         snapshot.data!.docs[index]
        //                                             ['imageUrl'],
        //                                         fit: BoxFit.cover,
        //                                       ),
        //                                     ),
        //                                   ),
        //                                   SizedBox(height: 5),
        //                                   Text(snapshot.data!.docs[index]
        //                                       ['name']),
        //                                   SizedBox(height: 10),
        //                                 ],
        //                               ),
        //                             ),
        //                           );
        //                         }));
        //           }),
        //     ),
        //   ],
        // ),
      );
    });
  }
}
