// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:magical_food/auth/auth.dart';
import 'package:magical_food/pages/admin_role/special_list/sp_image_provider.dart';
import 'package:provider/provider.dart';

class EditSpWidget extends StatefulWidget {
  String id;
  EditSpWidget({required this.id});
  @override
  State<EditSpWidget> createState() => _EditPageState();
}

class _EditPageState extends State<EditSpWidget> {
  GlobalKey<FormState> _globalKey = GlobalKey();

  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerPrice = TextEditingController();
  TextEditingController _controllerDescription = TextEditingController();

  String imageUrl = "";

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> post;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Special Food"),
        centerTitle: true,
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
            top: 30,
            bottom: 0,
            left: 20,
            right: 20,
            child: SingleChildScrollView(
                child: Consumer(builder: (context, SPImageProvider sp, child) {
              return FutureBuilder<DocumentSnapshot?>(
                  future: Auth().getSpecialFood(widget.id),
                  builder:
                      (context, AsyncSnapshot<DocumentSnapshot?> snapshot) {
                    if (snapshot.hasData) {
                      post = snapshot.data!.data() as Map<String, dynamic>;

                      _controllerName.text = post["name"];
                      _controllerPrice.text = post["price"].toString();

                      _controllerDescription.text = post["description"];

                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Form(
                          key: _globalKey,
                          child: Column(children: [
                            Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Center(
                                    child: Container(
                                      width: 130,
                                      height: 130,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Theme.of(context).cardColor,
                                            width: 2),
                                      ),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image(
                                            image:
                                                NetworkImage(post["imageUrl"]),
                                            fit: BoxFit.cover,
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null)
                                                return child;
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            },
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Container(
                                                child: Icon(
                                                  Icons.error_outline,
                                                  color: Colors.red,
                                                ),
                                              );
                                            },
                                          )),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    sp.pickeImage(context, widget.id);
                                  },
                                  child: CircleAvatar(
                                    radius: 14,
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 30),
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
                                  hintStyle: TextStyle(color: Colors.grey),
                                  contentPadding: EdgeInsets.all(10),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: "Enter the name"),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              style: TextStyle(color: Colors.grey),
                              controller: _controllerPrice,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "need to fill";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  hintStyle: TextStyle(color: Colors.grey),
                                  contentPadding: EdgeInsets.all(10),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: "Enter the price"),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              style: TextStyle(color: Colors.grey),
                              controller: _controllerDescription,
                              maxLines: null,
                              textInputAction: TextInputAction.newline,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "need to fill";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  hintStyle: TextStyle(color: Colors.grey),
                                  contentPadding: EdgeInsets.all(10),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: "Enter the description"),
                            ),
                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    bool isValidate =
                                        _globalKey.currentState!.validate();
                                    if (isValidate) {
                                      print("Success");
                                      imageUrl.isEmpty
                                          ? Auth().updateSpecialFood(
                                              _controllerName.text,
                                              int.parse(_controllerPrice.text),
                                              post["imageUrl"].toString(),
                                              widget.id,
                                              _controllerDescription.text,
                                            )
                                          : Auth().updateSpecialFood(
                                              _controllerName.text,
                                              int.parse(_controllerPrice.text),
                                              imageUrl,
                                              widget.id,
                                              _controllerDescription.text,
                                            );

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
                  });
            })),
          )
        ],
      ),
    );
  }
}
