import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:magical_food/pages/customer_role/primary_screen/primary_widget.dart';
import 'package:magical_food/pages/order_store/customer/record_order/record_ordered.dart';
import '../customer_role/primary_screen/primary_screen.dart';
import 'buildDrawer.dart';
import 'reuseappbar.dart';

class MainGmailUi extends StatefulWidget {
  @override
  State<MainGmailUi> createState() => _MainGmailUiState();
}

class _MainGmailUiState extends State<MainGmailUi> {
  int selectedIndex = 0;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody: true,
      // extendBodyBehindAppBar: true,
      // drawerScrimColor: Colors.amber, //drawer ရဲ့ဘေးကကျန်နေတဲ့ပိုငိးရဲ့အရောင်
      backgroundColor: Theme.of(context).primaryColor,
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.direction == ScrollDirection.forward) {
            // setState(() {
            //   isvisible = true;
            //   _width = 120;
            // });
          } else if (notification.direction == ScrollDirection.reverse) {
            // setState(() {
            //   isvisible = false;
            //   _width = 60;
            // });
          }
          return true;
        },
        child: ReuseAppbar(
            isBool: false,
            title: index == 0 ? "Magical Food" : "Order Record",
            selectedIndex: selectedIndex,
            index: index,
            bodyWidget: index == 0
                ? PrimaryScreen(
                    selectedIndex: selectedIndex,
                  )
                : RecordOrdered()),
      ),
      drawer: BuildDrawer(
        selectedIndex: selectedIndex,
        fun: (int num, String titletext) {
          setState(() {
            selectedIndex = num;
            index = 0;
          });
        },
      ),

      bottomNavigationBar: BottomAppBar(
        elevation: 10,
        // color: Colors.white,
        // notchMargin: 8,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            height: 45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    setState(() {
                      index = 0;
                    });

                    print(index);
                  },
                  child: Container(
                    width: 70,
                    height: 30,
                    decoration: BoxDecoration(
                        color: index == 0
                            // ? Color.fromARGB(255, 150, 214, 247).withOpacity(.9)
                            ? Theme.of(context).primaryColor.withOpacity(.8)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Icon(
                        Icons.home,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    setState(() {
                      index = 1;
                    });
                    print(index);
                  },
                  child: Container(
                    width: 70,
                    height: 30,
                    decoration: BoxDecoration(
                        color: index == 1
                            // ? Color.fromARGB(255, 150, 214, 247).withOpacity(.8)
                            ? Theme.of(context).primaryColor.withOpacity(.8)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20)),
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
