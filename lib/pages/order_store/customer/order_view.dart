import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:magical_food/pages/order_store/admin/order.dart';
import 'package:magical_food/pages/order_store/customer/deli_form/deli_form.dart';
import 'package:magical_food/pages/order_store/customer/shop_form/shop_form.dart';
import 'package:magical_food/util/locaton_service.dart';
import 'package:provider/provider.dart';

import 'order_view_ob.dart';
import 'provider/order_provider.dart';

class OrderView extends StatefulWidget {
  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  @override
  Widget build(BuildContext context) {
    var orderProvider = Provider.of<OrderProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              child: Image.asset(
                "assets/images/bg4.jpg",
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
              top: 30,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 30,
                        color: Theme.of(context).primaryColor,
                      )),
                  Text(
                    "Order List",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )),
          Positioned(
              top: 70,
              bottom: 10,
              left: 0,
              right: 0,
              child: orderProvider.totalAmount == 0
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
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.grey),
                        ),
                      ],
                    )
                  : SingleChildScrollView(
                      child: Column(children: [
                        ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: orderProvider.getLenght(),
                            itemBuilder: (context, index) {
                              OrderViewOb orderViewOb = OrderViewOb(
                                orderProvider.getList()[index].counter,
                                orderProvider.getList()[index].pOb!.description,
                                orderProvider.getList()[index].pOb!.id,
                                orderProvider.getList()[index].pOb!.image,
                                // orderProvider.getList()[index].pOb!.location,
                                orderProvider.getList()[index].pOb!.name,
                                orderProvider
                                    .getList()[index]
                                    .pOb!
                                    .price!
                                    .toInt(),
                              );
                              return Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 10, left: 8, right: 8),
                                child: Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 5,
                                        offset: Offset(2, 2),
                                        color: Theme.of(context).primaryColor,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  orderViewOb.image.toString()),
                                              radius: 40,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(orderViewOb.name
                                                        .toString()),
                                                    SizedBox(height: 10),
                                                    Text(orderViewOb.price
                                                            .toString() +
                                                        " MMK"),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Quty"),
                                                    SizedBox(height: 10),
                                                    Text(orderViewOb.counter
                                                        .toString()),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Amount"),
                                                    SizedBox(height: 10),
                                                    Text((orderViewOb.counter! *
                                                            orderViewOb.price!
                                                                .toInt())
                                                        .toString()),
                                                  ],
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        orderProvider.deleteOrder(
                                                            orderProvider
                                                                    .getList()[
                                                                index]);
                                                      });
                                                    },
                                                    icon: Icon(
                                                        Icons.remove_circle))
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //       blurRadius: 5, color: Colors.black)
                                  // ],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          "Total Amount : ",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          orderProvider.totalAmount.toString() +
                                              " MMK",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () async {
                              // var user = FirebaseAuth.instance.currentUser;
                              // if (user != null) {
                              //   DocumentReference doc = await Orders()
                              //       .createcustomer(
                              //           user.email!,
                              //           orderProvider.totalAmount.toString(),
                              //           UserLocation.lat,
                              //           UserLocation.log);
                              //   orderProvider.getList().forEach((element) {
                              //     Orders().createOrder(
                              //         element.counter!, element.pOb!, doc.id);
                              //   });
                              // }
                              // orderProvider.delete();
                              selectOrderType(context);
                            },
                            child: Container(
                              height: 50,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context).primaryColor,
                                      blurRadius: 2)
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  "Select Order Type",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        )
                      ]),
                    ))
        ],
      ),
    );
  }
}

void selectOrderType(context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Choose your Order type",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          content: Text(
            "To close , tap the any remaining screen",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) {
                    return ShopForm();
                  }));
                },
                child: Text("ShopOrder")),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return DeliForm();
                }));
              },
              child: Text("DeliOrder"),
            )
          ],
        );
      });
}
