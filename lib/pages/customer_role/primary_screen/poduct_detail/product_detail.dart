// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:magical_food/location/location_screen.dart';
import 'package:magical_food/pages/order_store/customer/order_store_ob.dart';
import 'package:magical_food/pages/order_store/customer/order_view.dart';
import 'package:magical_food/pages/order_store/customer/provider/order_provider.dart';
import 'package:magical_food/util/address_provider.dart';
import 'package:magical_food/util/locaton_service.dart';
import 'package:provider/provider.dart';

import 'product_detail_ob.dart';

class ProductDetail extends StatefulWidget {
  ProductDetailOb pOb;
  ProductDetail(this.pOb);
  @override
  State<ProductDetail> createState() => _ProductListState();
}

class _ProductListState extends State<ProductDetail> {
  var ScaffoldKey = GlobalKey<ScaffoldState>();

  int counter = 0;
  int updateCounter = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
      key: ScaffoldKey,
      body: Stack(children: [
        Positioned(
          top: 40,
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
                "Product Detail",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
            ],
          ),
        ),
        Positioned(
          top: 280,
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.pOb.name.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Spacer(),
                        Container(
                          height: 30,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25)),
                          child: Center(
                            child: Text(
                              widget.pOb.price.toString() + " MMK",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "About the food",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    Text(
                      widget.pOb.description.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            if (counter != 0) {
                              setState(() {
                                counter--;
                              });
                            }

                            if (updateCounter +
                                    orderProvider.getCounter(
                                        OrderStoreOb(counter, widget.pOb)) !=
                                0) {
                              setState(() {
                                updateCounter--;
                              });
                            }
                          },
                          icon: Icon(Icons.remove_circle),
                          color: Colors.white,
                        ),
                        orderProvider.hasData(OrderStoreOb(counter, widget.pOb))
                            ? Text(
                                "${updateCounter + orderProvider.getCounter(OrderStoreOb(counter, widget.pOb))}",
                                style: TextStyle(color: Colors.amber),
                              )
                            : Text(
                                counter.toString(),
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              counter++;
                            });
                            if (orderProvider
                                .hasData(OrderStoreOb(counter, widget.pOb))) {
                              setState(() {
                                updateCounter++;
                              });
                            }
                          },
                          icon: Icon(Icons.add_circle),
                          color: Colors.white,
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return OrderView();
                            }));
                          },
                          child: Container(
                            height: 30,
                            width: 80,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30)),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.shopping_cart,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    orderProvider.getLenght().toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.only(left: 50, right: 50),
                      child: InkWell(
                        onTap: () {
                          OrderStoreOb oOs = OrderStoreOb(counter, widget.pOb);

                          if (orderProvider
                              .hasData(OrderStoreOb(counter, widget.pOb))) {
                            orderProvider.updateCount(
                                OrderStoreOb(counter, widget.pOb),
                                updateCounter +
                                    orderProvider.getCounter(
                                        OrderStoreOb(counter, widget.pOb)));
                            setState(() {
                              updateCounter = 0;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.white,
                                duration: Duration(seconds: 2),
                                content: Text(
                                  " Order Success ",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                )));
                          } else if (counter != 0) {
                            orderProvider.add(oOs);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                duration: Duration(seconds: 1),
                                content: Text("Success")));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.white,
                                duration: Duration(seconds: 2),
                                content: Text(
                                  "Please select Order amount ",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                )));
                          }
                          ;
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.shopping_basket,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Add to cart ",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ]),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Align(
            alignment: Alignment.topCenter,
            child: Hero(
              transitionOnUserGestures: true,
              tag: widget.pOb.image.toString(),
              child: Container(
                clipBehavior: Clip.antiAlias,
                width: 200,
                height: 200,
                decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).primaryColor,
                      blurRadius: 20,
                      offset: Offset(6, 6))
                ]),
                child: Image.network(
                  widget.pOb.image.toString(),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
