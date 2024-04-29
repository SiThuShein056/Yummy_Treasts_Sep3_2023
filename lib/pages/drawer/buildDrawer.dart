// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:magical_food/auth/auth.dart';
import 'package:magical_food/pages/about_screen/about_screen.dart';
import 'package:magical_food/pages/admin_role/admin_role.dart';
import 'package:magical_food/pages/order_store/customer/order_provider/orde0r_noti_provider.dart';
import 'package:magical_food/pages/profile_screen/profile_screen.dart';
import 'package:magical_food/pages/settingpage/setting_page.dart';
import 'package:provider/provider.dart';

class BuildDrawer extends StatefulWidget {
  int selectedIndex;
  Function fun;

  BuildDrawer({required this.fun, required this.selectedIndex});
  @override
  State<BuildDrawer> createState() => _BuildDrawerState();
}

class _BuildDrawerState extends State<BuildDrawer> {
  bool role = false;

  @override
  void initState() {
    super.initState();
    checkRole();
  }

  checkRole() async {
    QuerySnapshot<Map<String, dynamic>> roles = await FirebaseFirestore.instance
        .collection("role")
        .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (roles.docs[0]['role'] == "admin") {
      setState(() {
        role = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    OrderNotiProvider onp = Provider.of(context, listen: false);
    onp.getData();

    return Drawer(
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder<QuerySnapshot?>(
            stream: Auth().getProfileData(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot?> snapshot) {
              if (snapshot.hasData) {
                return UserAccountsDrawerHeader(
                  arrowColor: Colors.red,
                  currentAccountPicture: CircleAvatar(
                    backgroundImage:
                        NetworkImage(snapshot.data!.docs[0]["imageUrl"]),
                  ),
                  // otherAccountsPictures: [
                  //   CircleAvatar(
                  //     backgroundImage: AssetImage(
                  //       "images/image2.jpg",
                  //     ),
                  //   ),
                  //   CircleAvatar(
                  //     backgroundImage: AssetImage(
                  //       "images/image3.jpg",
                  //     ),
                  //   ),
                  //   CircleAvatar(
                  //     backgroundImage: AssetImage(
                  //       "images/image4.jpg",
                  //     ),
                  //   ),
                  //   CircleAvatar(
                  //     backgroundImage: AssetImage(
                  //       "images/image5.jpg",
                  //     ),
                  //   ),
                  //   CircleAvatar(
                  //     backgroundImage: AssetImage(
                  //       "images/image6.jpg",
                  //     ),
                  //   ),
                  // ],
                  accountName: Text(
                    snapshot.data!.docs[0]["name"],
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  accountEmail: Text(
                    FirebaseAuth.instance.currentUser!.email.toString(),
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        opacity: 0.7,
                        image: AssetImage("assets/images/logo1.jpeg"),
                        fit: BoxFit.cover),
                    color: Theme.of(context).primaryColor.withOpacity(.5),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("Error");
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20, bottom: 10),
            child: Text(
              "Magical Food",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 20,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Divider(
          //   color: Colors.grey,
          // ),
          // ReuseDrawerBody(
          //   col: Colors.green,
          //   func: widget.fun,
          //   icon: Icons.all_inbox,
          //   title: "All inboxes",
          //   trail: '',
          //   number: 0,
          //   selectedIndex: widget.selectedIndex,
          // ),
          Divider(
            color: Colors.grey,
          ),
          ReuseDrawerBody(
            col: Colors.blue,
            func: widget.fun,
            icon: Icons.first_page_outlined,
            title: "Primary",
            trail: '',
            number: 0,
            selectedIndex: widget.selectedIndex,
          ),
          ReuseDrawerBody(
            col: Colors.amber,
            func: widget.fun,
            icon: Icons.photo_library_outlined,
            title: "Profile",
            trail: '',
            number: 1,
            selectedIndex: widget.selectedIndex,
          ),

          role
              ? Consumer(builder: (context, OrderNotiProvider od, child) {
                  return ReuseDrawerBody(
                    col: Theme.of(context).primaryColor,
                    func: widget.fun,
                    icon: Icons.admin_panel_settings,
                    title: "Admin Pannel",
                    trail: od.noti != 0 ? od.noti.toString() : "",
                    number: 2,
                    selectedIndex: widget.selectedIndex,
                  );
                })
              : Container(),

          // Padding(
          //   padding: const EdgeInsets.only(left: 15.0, top: 8, bottom: 8),
          //   child: Text(
          //     "All label",
          //     style: TextStyle(
          //       color: Colors.grey,
          //       fontSize: 15,
          //       letterSpacing: 2,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),

          // Padding(
          //   padding: const EdgeInsets.only(left: 15.0, top: 8, bottom: 8),
          //   child: Text(
          //     "Google apps",
          //     style: TextStyle(
          //       color: Colors.grey,
          //       fontSize: 15,
          //       letterSpacing: 2,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),

          ReuseDrawerBody(
            col: Colors.green,
            func: widget.fun,
            icon: Icons.settings_rounded,
            title: "Setting",
            trail: '',
            number: 16,
            selectedIndex: widget.selectedIndex,
          ),
          ReuseDrawerBody(
            col: Colors.green,
            func: widget.fun,
            icon: Icons.help_rounded,
            title: "About",
            trail: '',
            number: 17,
            selectedIndex: widget.selectedIndex,
          ),
          // ReuseDrawerBody(
          //   col: Colors.blue,
          //   func: widget.fun,
          //   icon: Icons.login_outlined,
          //   title: "Logout",
          //   trail: '',
          //   number: 7,
          //   selectedIndex: widget.selectedIndex,
          // ),
        ],
      ),
    );
  }
}

class ReuseDrawerBody extends StatefulWidget {
  IconData icon;
  Color col;
  String title, trail;
  int number, selectedIndex;
  Function func;
  ReuseDrawerBody(
      {required this.func,
      required this.col,
      required this.icon,
      required this.title,
      required this.trail,
      required this.number,
      required this.selectedIndex});
  @override
  State<ReuseDrawerBody> createState() => _ReuseDrawerBodyState();
}

class _ReuseDrawerBodyState extends State<ReuseDrawerBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ListTile(
        // selectedTileColor: Theme.of(context).primaryColor.withOpacity(.3),
        // selectedColor: widget.number == widget.selectedIndex
        //     ? Color.fromARGB(255, 150, 214, 247).withOpacity(.8)
        //     : Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30))),
        selected: widget.number == widget.selectedIndex,
        selectedColor: Theme.of(context).primaryColor,
        leading: Icon(widget.icon),
        title: Text(widget.title),
        trailing: widget.trail.isEmpty
            ? Text(widget.trail)
            : Container(
                width: 50,
                height: 20,
                decoration: BoxDecoration(
                    color: widget.col, borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text(widget.trail),
                ),
              ),
        onTap: () {
          Navigator.of(context).pop();
          // widget.number == 7 ? ThemeProvider().logout() : null;
          widget.number == 1
              ? Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                  return ProfileScreen();
                }))
              : widget.number == 17
                  ? Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                      return AboutScreen();
                    }))
                  : widget.number == 2
                      ? Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                          return AdminRole();
                        }))
                      // : widget.number == 17
                      //     ? Navigator.of(context)
                      //         .push(MaterialPageRoute(builder: (context) {
                      //         return AdminPannel();
                      //       }))
                      // : widget.number == 7
                      //     ? Navigator.of(context).pushAndRemoveUntil(
                      //         MaterialPageRoute(builder: (context) {
                      //         return SplashScreen();
                      //       }), (route) => false)
                      : widget.number == 16
                          ? Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                              return SettingPage();
                            }))
                          : widget.func(widget.number, widget.title);
          print(widget.title.toString() + widget.number.toString());
        },
      ),
    );
  }
}
