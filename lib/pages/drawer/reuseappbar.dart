import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:magical_food/pages/customer_role/primary_screen/search_product/search_products.dart';
import 'package:magical_food/pages/order_store/admin/order.dart';
import 'package:magical_food/pages/order_store/customer/finish_order.dart';
import 'package:magical_food/pages/order_store/customer/record_order/record_ordered.dart';
import 'package:magical_food/util/theme_provider.dart';
import 'package:provider/provider.dart';

class ReuseAppbar extends StatefulWidget {
  int selectedIndex, index;
  Widget bodyWidget;
  String title;
  bool isBool;
  ReuseAppbar(
      {required this.title,
      required this.isBool,
      required this.selectedIndex,
      required this.index,
      required this.bodyWidget});
  @override
  State<ReuseAppbar> createState() => _ReuseAppbarState();
}

class _ReuseAppbarState extends State<ReuseAppbar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext, bool) => [
            Consumer<ThemeProvider>(
              builder: (context, ThemeProvider tp, child) {
                return SliverAppBar(
                  iconTheme: IconThemeData(color: Colors.black),
                  backgroundColor: tp.tm == ThemeMode.light
                      ? Color.fromARGB(248, 98, 187, 110).withOpacity(.9)
                      : Color.fromARGB(248, 210, 228, 145).withOpacity(.9),

                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  primary: false,
                  // ဘောင်ကျဉ်းတာ
                  title: Text(
                    widget.title,
                    style: TextStyle(color: Colors.black),
                  ),
                  centerTitle: widget.isBool,
                  actions: widget.index != 0
                      ? null
                      : [
                          !widget.isBool
                              ? IconButton(
                                  onPressed: () async {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return SearchProducts();
                                    }));
                                    // Navigator.of(context)
                                    //     .push(MaterialPageRoute(builder: (context) {
                                    //   return FinishOrdered();
                                    // }));
                                  },
                                  icon: Icon(Icons.search))
                              : Container()
                        ],
                  // automaticallyImplyLeading: true,
                );
              },
            )
          ],
          body: widget.bodyWidget,
        ));
  }
}
