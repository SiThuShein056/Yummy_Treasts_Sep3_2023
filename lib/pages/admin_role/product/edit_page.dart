// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:magical_food/auth/auth.dart';
import 'package:magical_food/pages/admin_role/product/product_img_provider.dart';
import 'package:provider/provider.dart';

class EditPage extends StatefulWidget {
  String id;
  EditPage({required this.id});
  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  GlobalKey<FormState> _globalKey = GlobalKey();

  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerPrice = TextEditingController();
  TextEditingController _controllerCategory = TextEditingController();
  TextEditingController _controllerDescription = TextEditingController();

  String imageUrl = "";

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> post;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Products"),
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
            child: SingleChildScrollView(child: Consumer<ProductImageProvider>(
                builder: (context, ProductImageProvider ip, child) {
              return FutureBuilder<DocumentSnapshot?>(
                  future: Auth().getProduct(widget.id),
                  builder:
                      (context, AsyncSnapshot<DocumentSnapshot?> snapshot) {
                    if (snapshot.hasData) {
                      post = snapshot.data!.data() as Map<String, dynamic>;

                      _controllerName.text = post["name"];
                      _controllerPrice.text = post["price"].toString();
                      _controllerCategory.text = post["category"];
                      _controllerDescription.text = post["description"];

                      // imageUrl = post["imageUrl"];

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
                                    ip.pickeImage(context, widget.id);
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
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  contentPadding: EdgeInsets.all(10),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: "Enter the price"),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              style: TextStyle(color: Colors.grey),
                              enabled: false,
                              readOnly: true,
                              controller: _controllerCategory,
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
                                  hintText: "Select category"),
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
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  contentPadding: EdgeInsets.all(10),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: "Enter description"),
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
                                          ? Auth().updateProduct(
                                              _controllerName.text,
                                              int.parse(_controllerPrice.text),
                                              _controllerCategory.text,
                                              post["imageUrl"].toString(),
                                              widget.id,
                                              _controllerDescription.text,
                                            )
                                          : Auth().updateProduct(
                                              _controllerName.text,
                                              int.parse(_controllerPrice.text),
                                              _controllerCategory.text,
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

  imageUpload() async {
    /*
              *step 1. pick/capture an image (Image_picker)
              *step 2. upload the image to firebase storage
              *step 3. get the url of the upload imagge
              *step 4. store the image url inside the corresding
               document of the database
              *step 5. display the image on the list
              */

    /* step 1 */

    ImagePicker imagepicker = ImagePicker();
    XFile? file = await imagepicker.pickImage(source: ImageSource.gallery);

    if (file == null) return;
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    /*step 2: upload to firebase store*/
    //install firebase_storage
    //import the library

    //get a reference to storage root
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');

    //create a reference for the image to be stored
    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

    //Handle error / success
    try {
      //store the file
      await referenceImageToUpload.putFile(File(file.path));
      //success get the download url
      referenceImageToUpload.getDownloadURL().then((value) {
        imageUrl = value;
        setState(() {});
      });
    } catch (e) {
      //some error occur
    }
  }
}
