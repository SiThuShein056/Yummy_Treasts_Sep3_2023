import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:magical_food/util/address_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

class Lunch_ex extends StatefulWidget {
  const Lunch_ex({super.key});

  @override
  State<Lunch_ex> createState() => _Lunch_exState();
}

class _Lunch_exState extends State<Lunch_ex> {
  var _phoneNo = TextEditingController();
  var _ID = TextEditingController();
  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
      queryParameters: <String, dynamic>{
        'body': Uri.decodeComponent(
            "Your order is confirmed.Please wait a few minutes.Order ID : ${_ID.text}"),
      },
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: CustomScrollView(
      //   scrollDirection: Axis.vertical,
      //   slivers: [
      //     SliverAppBar(
      //       backgroundColor: Colors.transparent,
      //       elevation: 1,
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
      //         title: Text("Admin Pannel"),
      //         centerTitle: true,
      //         background: Image.asset(
      //           "assets/images/bg5.jpg",
      //           fit: BoxFit.cover,
      //         ),
      //         stretchModes: [
      //           StretchMode.zoomBackground,
      //           StretchMode.fadeTitle,
      //         ],
      //       ),
      //     ),
      //     SliverFillRemaining(
      //         hasScrollBody: false, //dar so nay yar ah kone ma u tk bu
      //         child: Container(
      //           decoration: BoxDecoration(
      //             image: DecorationImage(
      //                 image: AssetImage("assets/images/bg2.jpg"),
      //                 fit: BoxFit.cover),
      //           ),
      //           child: ClipRRect(
      //             borderRadius: BorderRadius.circular(10),
      //             child: BackdropFilter(
      //               filter: ImageFilter.blur(
      //                 sigmaX: 10,
      //                 sigmaY: 10,
      //               ),
      //               child: Container(
      //                 padding: EdgeInsets.all(20),
      //                 color: Colors.white.withOpacity(.3),
      //                 height: MediaQuery.of(context).size.height * 0.7,
      //                 width: MediaQuery.of(context).size.width,
      //                 child: Column(
      //                   children: [
      //                     Row(
      //                       children: [
      //                         Expanded(
      //                           child: Column(
      //                             crossAxisAlignment: CrossAxisAlignment.start,
      //                             // ignore: prefer_const_literals_to_create_immutables
      //                             children: [
      //                               Text(
      //                                 "KOKO",
      //                                 style: TextStyle(
      //                                     fontSize: 20,
      //                                     color: Colors.black,
      //                                     fontWeight: FontWeight.bold),
      //                               ),
      //                               SizedBox(height: 15),
      //                               Text(
      //                                 "You need to ask for storage permission to save an image to the gallery. You can handle the storage permission using flutter_permission_handler. In Android version 10, Open the manifest file and add this line to your application tagYou need to ask for storage permission to save an image to the gallery. You can handle the storage permission using flutter_permission_handler. In Android version 10, Open the manifest file and add this line to your application tag",
      //                                 style: TextStyle(
      //                                     color: Colors.black, fontSize: 15),
      //                                 maxLines: 4,
      //                               )
      //                             ],
      //                           ),
      //                         ),
      //                         Expanded(
      //                           child: Column(
      //                             children: [
      //                               Image.asset("assets/images/bg1.jpg"),
      //                             ],
      //                           ),
      //                         )
      //                       ],
      //                     ),
      //                     Spacer(),
      //                     Align(
      //                       alignment: Alignment.bottomRight,
      //                       child: ElevatedButton.icon(
      //                           onPressed: () {
      //                             showModalBottomSheet(
      //                                 shape: RoundedRectangleBorder(
      //                                     borderRadius:
      //                                         BorderRadius.circular(20)),
      //                                 context: context,
      //                                 builder: (context) {
      //                                   return ListView(
      //                                     children: [
      //                                       Card(
      //                                         elevation: 1,
      //                                         child: ListTile(
      //                                           title: Text('Music'),
      //                                           leading: Icon(Icons.music_note),
      //                                           onTap: () {
      //                                             Navigator.of(context).pop();
      //                                             print('Tapped Music button');
      //                                           },
      //                                         ),
      //                                       ),
      //                                       Card(
      //                                         elevation: 1,
      //                                         child: ListTile(
      //                                           title: Text('Music'),
      //                                           leading: Icon(Icons.music_note),
      //                                           onTap: () {
      //                                             Navigator.of(context).pop();
      //                                           },
      //                                         ),
      //                                       ),
      //                                       Card(
      //                                         elevation: 1,
      //                                         child: ListTile(
      //                                           title: Text('Music'),
      //                                           leading: Icon(Icons.music_note),
      //                                           onTap: () {
      //                                             Navigator.of(context).pop();
      //                                             print('Tapped Music button');
      //                                           },
      //                                         ),
      //                                       ),
      //                                       Card(
      //                                         elevation: 1,
      //                                         child: ListTile(
      //                                           title: Text('Music'),
      //                                           leading: Icon(Icons.music_note),
      //                                           onTap: () {
      //                                             Navigator.of(context).pop();
      //                                             print('Tapped Music button');
      //                                           },
      //                                         ),
      //                                       ),
      //                                       Card(
      //                                         elevation: 1,
      //                                         child: ListTile(
      //                                           title: Text('Music'),
      //                                           leading: Icon(Icons.music_note),
      //                                           onTap: () {
      //                                             Navigator.of(context).pop();
      //                                             print('Tapped Music button');
      //                                           },
      //                                         ),
      //                                       ),
      //                                       Card(
      //                                         elevation: 1,
      //                                         child: ListTile(
      //                                           title: Text('Music'),
      //                                           leading: Icon(Icons.music_note),
      //                                           onTap: () {
      //                                             Navigator.of(context).pop();
      //                                             print('Tapped Music button');
      //                                           },
      //                                         ),
      //                                       ),
      //                                       ListTile(
      //                                         title: Text('Video'),
      //                                         leading: Icon(Icons
      //                                             .video_collection_rounded),
      //                                         onTap: () {
      //                                           Navigator.of(context).pop();
      //                                           print('Tapped Video button');
      //                                         },
      //                                       ),
      //                                       ListTile(
      //                                         title: Text('Movie'),
      //                                         leading: Icon(Icons.movie),
      //                                         onTap: () {
      //                                           Navigator.of(context).pop();
      //                                           print('Tapped Movie button');
      //                                         },
      //                                       ),
      //                                     ],
      //                                   );
      //                                 });
      //                           },
      //                           icon: Icon(Icons.admin_panel_settings),
      //                           label: Text(
      //                             "Select Function",
      //                             style: TextStyle(fontWeight: FontWeight.bold),
      //                           )),
      //                     )
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           ),
      //         )),
      //   ],
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 80.0),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: _phoneNo,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(contentPadding: EdgeInsets.all(10)),
              ),
              TextField(
                controller: _ID,
                enabled: false,
                readOnly: true,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(contentPadding: EdgeInsets.all(10)),
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      const uuid = Uuid();
                      _ID.text = uuid.v4();
                    });
                    makePhoneCall(_phoneNo.text);
                  },
                  child: Text("Sms")),
              ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      context: context,
                      builder: (context) {
                        return ListView(
                          children: [
                            Card(
                              elevation: 1,
                              child: ListTile(
                                title: Text('Music'),
                                leading: Icon(Icons.music_note),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  print('Tapped Music button');
                                },
                              ),
                            ),
                            Card(
                              elevation: 1,
                              child: ListTile(
                                title: Text('Music'),
                                leading: Icon(Icons.music_note),
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            Card(
                              elevation: 1,
                              child: ListTile(
                                title: Text('Music'),
                                leading: Icon(Icons.music_note),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  print('Tapped Music button');
                                },
                              ),
                            ),
                            Card(
                              elevation: 1,
                              child: ListTile(
                                title: Text('Music'),
                                leading: Icon(Icons.music_note),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  print('Tapped Music button');
                                },
                              ),
                            ),
                            Card(
                              elevation: 1,
                              child: ListTile(
                                title: Text('Music'),
                                leading: Icon(Icons.music_note),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  print('Tapped Music button');
                                },
                              ),
                            ),
                            Card(
                              elevation: 1,
                              child: ListTile(
                                title: Text('Music'),
                                leading: Icon(Icons.music_note),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  print('Tapped Music button');
                                },
                              ),
                            ),
                            ListTile(
                              title: Text('Video'),
                              leading: Icon(Icons.video_collection_rounded),
                              onTap: () {
                                Navigator.of(context).pop();
                                print('Tapped Video button');
                              },
                            ),
                            ListTile(
                              title: Text('Movie'),
                              leading: Icon(Icons.movie),
                              onTap: () {
                                Navigator.of(context).pop();
                                print('Tapped Movie button');
                              },
                            ),
                          ],
                        );
                      });
                },
                child: Text('Cupertino Button Sheet'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
