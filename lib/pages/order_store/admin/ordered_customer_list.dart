import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:magical_food/auth/auth.dart';
import 'package:magical_food/pages/order_store/admin/deli_ordered/deli_cust.dart';
import 'package:magical_food/pages/order_store/admin/shop_ordered/shop_cust.dart';

class OrderedCustomerList extends StatefulWidget {
  OrderedCustomerList({Key? key}) : super(key: key);

  @override
  State<OrderedCustomerList> createState() => _OrderedCustomerListState();
}

class _OrderedCustomerListState extends State<OrderedCustomerList>
    with SingleTickerProviderStateMixin {
  TabController? _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        // body: Stack(
        //   children: [
        //     Positioned(
        //         top: 30,
        //         child: Row(
        // children: [
        //   IconButton(
        //       onPressed: () {
        //         Navigator.of(context).pop();
        //       },
        //       icon: Icon(
        //         Icons.arrow_back_ios,
        //         size: 20,
        //         color: Colors.white,
        //       )),
        //   Text(
        //     "Customer List",
        //     style: TextStyle(
        //       fontSize: 20,
        //       // fontWeight: FontWeight.bold,
        //       color: Colors.white,
        //     ),
        //   ),
        // ],
        // )),
        // Positioned.fill(
        //   top: 60,
        //   bottom: 10,
        //   left: 10,
        //   right: 10,
        //   child: StreamBuilder<QuerySnapshot>(
        //       stream: Orders().getCustomer(),
        //       builder: (context, AsyncSnapshot<QuerySnapshot> sanapshot) {
        //         return sanapshot.data == null
        //             ? Center(child: CircularProgressIndicator())
        //             : sanapshot.data!.docs.length == 0
        //                 ? Center(
        //                     child: Text(
        //                     "No Orders",
        //                     textAlign: TextAlign.center,
        //                     style: TextStyle(
        //                         fontWeight: FontWeight.bold, fontSize: 20),
        //                   ))
        //                 : SingleChildScrollView(
        //                     child: ListView.builder(
        //                         shrinkWrap: true,
        //                         itemCount: sanapshot.data!.docs.length,
        //                         itemBuilder: (context, indext) {
        //                           return Card(
        //                             elevation: 2,
        //                             shadowColor:
        //                                 Theme.of(context).primaryColor,
        //                             child: Container(
        //                               margin: EdgeInsets.all(10),
        //                               width: 200,
        //                               height: 100,
        //                               child: Column(
        //                                 crossAxisAlignment:
        //                                     CrossAxisAlignment.start,
        //                                 children: [
        //                                   Expanded(
        //                                     child: Text(
        //                                       sanapshot.data!.docs[indext]
        //                                           ['name'],
        //                                       style: TextStyle(
        //                                         color: Theme.of(context)
        //                                             .primaryColor,
        //                                         fontSize: 20,
        //                                       ),
        //                                     ),
        //                                   ),
        //                                   Expanded(
        //                                     child: Text(
        //                                       sanapshot.data!
        //                                           .docs[indext]['phone']
        //                                           .toString(),
        //                                       style: TextStyle(
        //                                         color: Theme.of(context)
        //                                             .primaryColor,
        //                                         fontSize: 15,
        //                                       ),
        //                                     ),
        //                                   ),
        //                                   Divider(
        //                                     color: Theme.of(context)
        //                                         .primaryColor,
        //                                   ),
        //                                   Expanded(
        //                                     child: Row(
        //                                       mainAxisAlignment:
        //                                           MainAxisAlignment
        //                                               .spaceAround,
        //                                       children: [
        //                                         IconButton(
        //                                           onPressed: () {
        //                                             Navigator.of(context).push(
        //                                                 MaterialPageRoute(
        //                                                     builder:
        //                                                         (context) {
        //                                               return OrderedLocation(
        //                                                 name: sanapshot
        //                                                         .data!.docs[
        //                                                     indext]['name'],
        //                                                 lat: sanapshot
        //                                                         .data!.docs[
        //                                                     indext]['lat'],
        //                                                 log: sanapshot
        //                                                         .data!.docs[
        //                                                     indext]['log'],
        //                                               );
        //                                             }));
        //                                           },
        //                                           icon: Icon(
        //                                               Icons.location_on),
        //                                         ),
        //                                         IconButton(
        //                                             onPressed: () {
        //                                               Navigator.push(
        //                                                   context,
        //                                                   MaterialPageRoute(
        //                                                       builder:
        //                                                           (context) {
        //                                                 return ShowOrder(
        //                                                   sanapshot
        //                                                       .data!
        //                                                       .docs[indext]
        //                                                       .id,
        //                                                   sanapshot.data!
        //                                                               .docs[
        //                                                           indext]
        //                                                       ['totalAmt'],
        //                                                 );
        //                                               }));
        //                                             },
        //                                             icon: Icon(
        //                                               Icons.remove_red_eye,
        //                                               color: Colors.green,
        //                                             )),
        //                                         IconButton(
        //                                             onPressed: () {
        //                                               Orders().deleteOrder(
        //                                                   sanapshot
        //                                                       .data!
        //                                                       .docs[indext]
        //                                                       .id);
        //                                             },
        //                                             icon: Icon(
        //                                               Icons.delete,
        //                                               color: Colors.red,
        //                                             )),
        //                                       ],
        //                                     ),
        //                                   ),
        //                                 ],
        //                               ),
        //                             ),
        //                           );
        //                         }),
        //                   );
        //       }),
        // ),
        // ],
        // )
        appBar: AppBar(
          elevation: 1,
          backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
          title: Text(
            "Ordered Customers",
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
          bottom: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              controller: _controller,
              tabs: [
                Tab(
                  text: "Delivery Order",
                  icon: Icon(Icons.delivery_dining_outlined),
                ),
                Tab(
                  text: "Shop Order",
                  icon: Icon(Icons.shop),
                )
              ]),
        ),
        body: TabBarView(
            controller: _controller,
            children: [DeliOrderedCustomer(), ShopOrderedCustomer()]));
  }
}


// Card(
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child:
// Row(
//                                         children: [
//                                           Expanded(
//                                             child: Text(sanapshot
//                                                 .data!.docs[indext]['email']),
//                                           ),
//                                           IconButton(
//                                             onPressed: () {
//                                               Navigator.of(context).push(
//                                                   MaterialPageRoute(
//                                                       builder: (context) {
//                                                 return OrderedLocation(
//                                                   lat: sanapshot.data!
//                                                       .docs[indext]['lat'],
//                                                   log: sanapshot.data!
//                                                       .docs[indext]['log'],
//                                                 );
//                                               }));
//                                             },
//                                             icon: Icon(Icons.location_on),
//                                           ),
//                                           IconButton(
//                                               onPressed: () {
//                                                 Navigator.push(context,
//                                                     MaterialPageRoute(
//                                                         builder: (context) {
//                                                   return ShowOrder(
//                                                     sanapshot
//                                                         .data!.docs[indext].id,
//                                                     sanapshot.data!.docs[indext]
//                                                         ['totalAmt'],
//                                                   );
//                                                 }));
//                                               },
//                                               icon: Icon(
//                                                 Icons.remove_red_eye,
//                                                 color: Colors.green,
//                                               )),
//                                           SizedBox(
//                                             width: 10,
//                                           ),
//                                           IconButton(
//                                               onPressed: () {
//                                                 Orders().deleteOrder(sanapshot
//                                                     .data!.docs[indext].id);
//                                               },
//                                               icon: Icon(
//                                                 Icons.delete,
//                                                 color: Colors.red,
//                                               )),
//                                         ],
//                                       ),
//                                     ),
//                                   )