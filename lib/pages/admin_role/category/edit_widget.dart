import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:magical_food/auth/auth.dart';

class EditCategoryWidget extends StatefulWidget {
  String id;
  EditCategoryWidget({required this.id});
  @override
  State<EditCategoryWidget> createState() => _EditCategoryWidgetState();
}

class _EditCategoryWidgetState extends State<EditCategoryWidget> {
  GlobalKey<FormState> _globalKey = GlobalKey();

  TextEditingController _controllerName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Page"),
      ),
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
            top: 50,
            bottom: 0,
            left: 20,
            right: 20,
            child: SingleChildScrollView(
              child: FutureBuilder<DocumentSnapshot?>(
                  future: Auth().getCategory(widget.id),
                  builder:
                      (context, AsyncSnapshot<DocumentSnapshot?> snapshot) {
                    if (snapshot.hasData) {
                      Map<String, dynamic> post;
                      post = snapshot.data!.data() as Map<String, dynamic>;

                      _controllerName.text = post["name"];

                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Form(
                          key: _globalKey,
                          child: Column(children: [
                            TextFormField(
                              style: TextStyle(color: Colors.grey),
                              controller: _controllerName,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "need to fill";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  contentPadding: EdgeInsets.all(10),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: "Enter the name"),
                            ),
                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    bool isValidate =
                                        _globalKey.currentState!.validate();
                                    if (isValidate) {
                                      Auth().updateCategiry(
                                          _controllerName.text, widget.id);

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              backgroundColor: Theme.of(context)
                                                  .primaryColor,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              content: Text("Update Success")));

                                      Navigator.of(context).pop();
                                    } else {
                                      print("Fail");
                                    }
                                  },
                                  child: Text("Update")),
                            ),
                          ]),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("Error"),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
          )
        ],
      ),
      // body:
      // SingleChildScrollView(
      //   child: FutureBuilder<DocumentSnapshot?>(
      //       future: Auth().getCategory(widget.id),
      //       builder: (context, AsyncSnapshot<DocumentSnapshot?> snapshot) {
      //         if (snapshot.hasData) {
      //           Map<String, dynamic> post;
      //           post = snapshot.data!.data() as Map<String, dynamic>;

      //           _controllerName.text = post["name"];

      //           return Padding(
      //             padding: const EdgeInsets.all(10.0),
      //             child: Form(
      //               key: _globalKey,
      //               child: Column(children: [
      //                 TextFormField(
      //                   controller: _controllerName,
      //                   validator: (value) {
      //                     if (value!.isEmpty) {
      //                       return "need to fill";
      //                     }
      //                     return null;
      //                   },
      //                   decoration: InputDecoration(hintText: "Enter the name"),
      //                 ),
      //                 SizedBox(height: 10),
      //                 ElevatedButton(
      //                     onPressed: () async {
      //                       bool isValidate =
      //                           _globalKey.currentState!.validate();
      //                       if (isValidate) {
      //                         Auth().updateCategiry(
      //                             _controllerName.text, widget.id);

      //                         ScaffoldMessenger.of(context).showSnackBar(
      //                             SnackBar(
      //                                 backgroundColor:
      //                                     Theme.of(context).primaryColor,
      //                                 behavior: SnackBarBehavior.floating,
      //                                 content: Text("Update Success")));

      //                         Navigator.of(context).pop();
      //                       } else {
      //                         print("Fail");
      //                       }
      //                     },
      //                     child: Text("Update")),
      //               ]),
      //             ),
      //           );
      //         } else if (snapshot.hasError) {
      //           return Center(
      //             child: Text("Error"),
      //           );
      //         } else {
      //           return Center(
      //             child: CircularProgressIndicator(),
      //           );
      //         }
      //       }),
      // ),
    );
  }
}
