import 'package:flutter/material.dart';
import 'package:magical_food/pages/admin_role/category/create_category.dart';
import 'package:magical_food/pages/admin_role/discount/create_discount.dart';
import 'package:magical_food/pages/admin_role/discount/edit_discount.dart';
import 'package:magical_food/pages/admin_role/special_list/create_special_list.dart';
import 'package:magical_food/pages/order_store/admin/ordered_customer_list.dart';
import 'package:magical_food/pages/order_store/customer/order_provider/orde0r_noti_provider.dart';
import 'package:magical_food/util/theme_provider.dart';
import 'package:provider/provider.dart';

import 'category/edit_category.dart';
import 'product/create_product.dart';
import 'product/edit_products.dart';
import 'special_list/edit_special_list.dart';

class AdminRole extends StatefulWidget {
  const AdminRole({super.key});

  @override
  State<AdminRole> createState() => _AdminRoleState();
}

class _AdminRoleState extends State<AdminRole>
    with SingleTickerProviderStateMixin {
  TabController? _controller;

  var _discountController = TextEditingController();
  void changeDiscount(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Enter Discount Percentage"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _discountController,
                  decoration: InputDecoration(),
                  keyboardType: TextInputType.number,
                )
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("cancel")),
              Consumer<ThemeProvider>(
                  builder: (context, ThemeProvider tp, child) {
                return TextButton(
                    onPressed: () {
                      if (_discountController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Enter Discount Percentage")));
                        return;
                      } else if (int.parse(_discountController.text) < 0 ||
                          int.parse(_discountController.text) > 100) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Enter Discount allowed limit")));
                        return;
                      } else {
                        tp.changeDiscount(int.parse(_discountController.text));
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text("Success")));
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                          return CreateDiscountProducts();
                        }));
                      }
                    },
                    child: Text("ok"));
              }),
            ],
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 7, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    OrderNotiProvider onp = Provider.of(context, listen: false);
    onp.getData();
    return Scaffold(
        appBar: AppBar(
          title: Text("Admin Pannel"),
          elevation: 1,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              // color: Colors.white,
            ),
          ),
        ),
        body: Stack(
          // fit: StackFit.loose,
          // overflow:Overflow.visible,

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
              top: 15,
              left: 10,
              right: 10,
              child: InkWell(
                onTap: () {
                  onp.resetNoti();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return OrderedCustomerList();
                  }));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Ordered Customer",
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Icon(
                          Icons.card_giftcard_outlined,
                          size: 80,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 150,
              left: 10,
              right: 10,
              bottom: 0,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 150,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return CreateProduct();
                              }));
                            },
                            icon: Icon(
                              Icons.edit_calendar_outlined,
                              size: 50,
                            ),
                            label: Text("Create New Menus"),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              backgroundColor: Theme.of(context).primaryColor,
                              shadowColor: Colors.greenAccent,
                              elevation: 12,
                            ),
                          ),
                        ),
                        Container(
                          width: 150,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return EditProducts();
                              }));
                            },
                            icon: Icon(
                              Icons.edit_calendar_outlined,
                              size: 50,
                            ),
                            label: Text("Edit Menus"),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              backgroundColor: Theme.of(context).primaryColor,
                              shadowColor: Colors.greenAccent,
                              elevation: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 150,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return CreateCategory();
                              }));
                            },
                            icon: Icon(
                              Icons.category_outlined,
                              size: 50,
                            ),
                            label: Text("Create New Category"),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              backgroundColor: Theme.of(context).primaryColor,
                              shadowColor: Colors.greenAccent,
                              elevation: 12,
                            ),
                          ),
                        ),
                        Container(
                          width: 150,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return EditCategories();
                              }));
                            },
                            icon: Icon(
                              Icons.category_outlined,
                              size: 50,
                            ),
                            label: Text("Edit Category"),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              backgroundColor: Theme.of(context).primaryColor,
                              shadowColor: Colors.greenAccent,
                              elevation: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 150,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return CreateSpecialFood();
                              }));
                            },
                            icon: Icon(
                              Icons.star_border_rounded,
                              size: 50,
                            ),
                            label: Text("Create Today Special"),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              backgroundColor: Theme.of(context).primaryColor,
                              shadowColor: Colors.greenAccent,
                              elevation: 12,
                            ),
                          ),
                        ),
                        Container(
                          width: 150,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return EditSpecialFood();
                              }));
                            },
                            icon: Icon(
                              Icons.star_border_rounded,
                              size: 50,
                            ),
                            label: Text("Edit Today Special"),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              backgroundColor: Theme.of(context).primaryColor,
                              shadowColor: Colors.greenAccent,
                              elevation: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 150,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              changeDiscount(context);
                            },
                            icon: Icon(
                              Icons.discount_rounded,
                              size: 50,
                            ),
                            label: Text("Create Discount"),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              backgroundColor: Theme.of(context).primaryColor,
                              shadowColor: Colors.greenAccent,
                              elevation: 12,
                            ),
                          ),
                        ),
                        Container(
                          width: 150,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return EditDiscountFood();
                              }));
                            },
                            icon: Icon(
                              Icons.discount_rounded,
                              size: 50,
                            ),
                            label: Text("Edit Discount"),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              backgroundColor: Theme.of(context).primaryColor,
                              shadowColor: Colors.greenAccent,
                              elevation: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        )

        // body: Stack(
        //   children: [
        //     Positioned.fill(
        //       child: Container(
        //         width: double.infinity,
        //         height: double.infinity,
        //         decoration: BoxDecoration(
        //           image: DecorationImage(
        //               image: AssetImage("assets/images/bg1.jpg"),
        //               fit: BoxFit.cover),
        //         ),
        //         child: TabBarView(
        //           controller: _controller,
        //           children: [
        //             Align(
        //               alignment: Alignment.bottomRight,
        //               child: Padding(
        //                 padding: const EdgeInsets.all(20.0),
        //                 child: IconButton(
        //                   iconSize: 70,
        //                   color: Colors.white,
        //                   onPressed: () {
        //                     Navigator.of(context)
        //                         .push(MaterialPageRoute(builder: (context) {
        //                       return CreateProduct();
        //                     }));
        //                   },
        //                   icon: Icon(Icons.add_circle),
        //                 ),
        //               ),
        //             ),
        //             Align(
        //               alignment: Alignment.bottomRight,
        //               child: Padding(
        //                 padding: const EdgeInsets.all(20.0),
        //                 child: IconButton(
        //                   iconSize: 70,
        //                   color: Colors.white,
        //                   onPressed: () {
        //                     Navigator.of(context)
        //                         .push(MaterialPageRoute(builder: (context) {
        //                       return EditProducts();
        //                     }));
        //                   },
        //                   icon: Icon(Icons.edit),
        //                 ),
        //               ),
        //             ),
        //             Align(
        //               alignment: Alignment.bottomRight,
        //               child: Padding(
        //                 padding: const EdgeInsets.all(20.0),
        //                 child: IconButton(
        //                   iconSize: 70,
        //                   color: Colors.white,
        //                   onPressed: () {
        //                     Navigator.of(context)
        //                         .push(MaterialPageRoute(builder: (context) {
        //                       return CreateCategory();
        //                     }));
        //                   },
        //                   icon: Icon(Icons.add_circle),
        //                 ),
        //               ),
        //             ),
        //             Align(
        //               alignment: Alignment.bottomRight,
        //               child: Padding(
        //                 padding: const EdgeInsets.all(20.0),
        //                 child: IconButton(
        //                   iconSize: 70,
        //                   color: Colors.white,
        //                   onPressed: () {
        //                     Navigator.of(context)
        //                         .push(MaterialPageRoute(builder: (context) {
        //                       return EditCategories();
        //                     }));
        //                   },
        //                   icon: Icon(Icons.edit),
        //                 ),
        //               ),
        //             ),
        //             Align(
        //               alignment: Alignment.bottomRight,
        //               child: Padding(
        //                 padding: const EdgeInsets.all(20.0),
        //                 child: IconButton(
        //                   iconSize: 70,
        //                   color: Colors.white,
        //                   onPressed: () {
        //                     Navigator.of(context)
        //                         .push(MaterialPageRoute(builder: (context) {
        //                       return CreateSpecialFood();
        //                     }));
        //                   },
        //                   icon: Icon(Icons.add_circle),
        //                 ),
        //               ),
        //             ),
        //             Align(
        //               alignment: Alignment.bottomRight,
        //               child: Padding(
        //                 padding: const EdgeInsets.all(20.0),
        //                 child: IconButton(
        //                   iconSize: 70,
        //                   color: Colors.white,
        //                   onPressed: () {
        //                     Navigator.of(context)
        //                         .push(MaterialPageRoute(builder: (context) {
        //                       return EditSpecialFood();
        //                     }));
        //                   },
        //                   icon: Icon(Icons.edit),
        //                 ),
        //               ),
        //             ),
        //             Align(
        //               alignment: Alignment.bottomRight,
        //               child: Padding(
        //                 padding: const EdgeInsets.all(20.0),
        //                 child: IconButton(
        //                   iconSize: 70,
        //                   color: Colors.white,
        //                   onPressed: () {
        //                     Navigator.of(context)
        //                         .push(MaterialPageRoute(builder: (context) {
        //                       return OrderedCustomerList();
        //                     }));
        //                   },
        //                   icon: Icon(Icons.shopping_bag_outlined),
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //     Positioned(
        //       top: 0,
        //       left: 0,
        //       right: 0,
        //       child: Container(
        //         height: 150,
        //         child: AppBar(
        //           elevation: 0,
        //           backgroundColor: Colors.black12,
        //           title: Text(
        //             "Welcome Admin",
        //             style: TextStyle(color: Colors.white),
        //           ),
        //           leading: IconButton(
        //             onPressed: () {
        //               Navigator.of(context).pop();
        //             },
        //             icon: Icon(
        //               Icons.arrow_back_ios,
        //               color: Colors.white,
        //             ),
        //           ),
        //           // ignore: prefer_const_literals_to_create_immutables
        //           bottom: TabBar(
        //               indicatorColor: Colors.indigo,
        //               indicatorSize: TabBarIndicatorSize.label,
        //               isScrollable: true,
        //               controller: _controller,
        //               // ignore: prefer_const_literals_to_create_immutables
        //               tabs: [
        //                 Tab(
        //                   child: Text("Create Products"),
        //                 ),
        //                 Tab(
        //                   child: Text("Edit Products"),
        //                 ),
        //                 Tab(
        //                   child: Text("Create Category"),
        //                 ),
        //                 Tab(
        //                   child: Text("Edit Category"),
        //                 ),
        //                 Tab(
        //                   child: Text("Create Special List"),
        //                 ),
        //                 Tab(
        //                   child: Text("Edit Special List"),
        //                 ),
        //                 Tab(
        //                   child: Text("Ordered Customer"),
        //                 )
        //               ]),
        //         ),
        //       ),
        //     )
        //   ],
        // ),
        );
  }
}
