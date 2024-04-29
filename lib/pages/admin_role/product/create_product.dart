import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:magical_food/auth/auth.dart';
import 'package:magical_food/pages/admin_role/category/categories.dart';

class CreateProduct extends StatefulWidget {
  const CreateProduct({super.key});

  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  int groupValue = 0;

  GlobalKey<FormState> _globalKey = GlobalKey();
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerPrice = TextEditingController();
  TextEditingController _controllerCategory = TextEditingController();
  TextEditingController _controllerDescription = TextEditingController();

  //to read and write firebasefirestore for CRUD project

  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create New Menu"),
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
              child: Form(
                key: _globalKey,
                child: Column(children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Center(
                          child: Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 2),
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: imageUrl.isEmpty
                                    ? Center(
                                        child: Text(
                                        "No Image",
                                        style: TextStyle(color: Colors.grey),
                                      ))
                                    : Image(
                                        image: NetworkImage(imageUrl),
                                        fit: BoxFit.cover,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return Center(
                                            child: CircularProgressIndicator(),
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
                          imageUpload();
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
                    keyboardType: TextInputType.number,
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
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return Categories();
                      })).then((value) {
                        if (value != null) {
                          _controllerCategory.text = value;
                        }
                      });
                    },
                    child: TextFormField(
                      style: TextStyle(color: Colors.grey),
                      readOnly: true,
                      enabled: false,
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
                          hintText: "Tap to select category"),
                    ),
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
                        hintText: "Enter the description"),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (imageUrl.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Select Image")));
                            return;
                          }

                          bool isValidate = _globalKey.currentState!.validate();
                          if (isValidate) {
                            print("Success");

                            Auth().createProduct(
                              _controllerName.text,
                              int.parse(_controllerPrice.text),
                              _controllerCategory.text,
                              imageUrl,
                              _controllerDescription.text,
                            );
                            setState(() {
                              _controllerName.text = "";
                              _controllerPrice.text = "";
                              _controllerCategory.text = "";

                              imageUrl = "";
                              _controllerDescription.text = "";
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Success")));
                          } else {
                            print("Fail");
                          }
                        },
                        child: Text("Add Product")),
                  ),
                ]),
              ),
            ),
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
