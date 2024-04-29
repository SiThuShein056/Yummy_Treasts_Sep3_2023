import 'package:flutter/material.dart';
import 'package:magical_food/pages/order_store/customer/all_products.dart';
import 'package:magical_food/pages/profile_screen/profile_screen.dart';

import 'primary_widget.dart';

class PrimaryScreen extends StatefulWidget {
  int selectedIndex;
  PrimaryScreen({required this.selectedIndex});
  @override
  State<PrimaryScreen> createState() => _PrimaryScreenState();
}

class _PrimaryScreenState extends State<PrimaryScreen> {
  @override
  Widget build(BuildContext context) {
    // return PrimaryWidget();
    return Builder(builder: (context) {
      switch (widget.selectedIndex) {
        case 0:
          return PrimaryWidget();

        // case 1:
        //   return Container();
      }

      return Container();
    });
  }
}
