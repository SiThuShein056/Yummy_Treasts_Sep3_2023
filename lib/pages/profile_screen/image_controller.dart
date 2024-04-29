import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:magical_food/auth/auth.dart';

class ImageControllerProvider with ChangeNotifier {
  String imageUrl = "";
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  GlobalKey<FormState> _globalKey = GlobalKey();

  imageFromGallery(String id) async {
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
        notifyListeners();
        print("IMAGE URL : " + imageUrl);
        Auth().updateProfileImage(imageUrl, id);
      });
    } catch (e) {
      //some error occur
    }
  }

  imageFromCamera(String id) async {
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
        notifyListeners();
        print("IMAGE URL : " + imageUrl);
        Auth().updateProfileImage(imageUrl, id);
      });
    } catch (e) {
      //some error occur
    }
  }

  void pickeImage(context, String uid) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
                height: 120,
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {
                        imageFromCamera(uid);
                        Navigator.of(context).pop();
                      },
                      leading: Icon(
                        Icons.camera,
                        size: 20,
                      ),
                      title: Text("Camera"),
                    ),
                    ListTile(
                      onTap: () {
                        imageFromGallery(uid);
                        Navigator.of(context).pop();
                      },
                      leading: Icon(
                        Icons.image,
                        size: 20,
                      ),
                      title: Text("Image"),
                    )
                  ],
                )),
          );
        });
  }

  void changeName(context, String uid) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Enter Name"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(),
                )
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("cancel")),
              TextButton(
                  onPressed: () {
                    if (_nameController.text.isEmpty) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("Enter Name")));
                      return;
                    } else {
                      Auth().updateProfileName(_nameController.text,
                          FirebaseAuth.instance.currentUser!.uid);
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("Success")));
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text("ok"))
            ],
          );
        });
  }

  void changePhone(context, String uid) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Enter Phone"),
            content: Form(
              key: _globalKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "need to fill";
                      }
                      if (!value.startsWith('097') &&
                          !value.startsWith('099') &&
                          !value.startsWith('096') &&
                          !value.startsWith('098') &&
                          !value.startsWith('094') &&
                          !value.startsWith('092')) {
                        return "invalid operator";
                      }
                      if (value.contains("+") ||
                          value.contains("-") ||
                          value.contains("*")) {
                        return "invalid number";
                      }

                      if (value.length != 11) {
                        return "invalid length";
                      }
                      return null;
                    },
                    controller: _phoneController,
                    decoration: InputDecoration(),
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("cancel")),
              TextButton(
                  onPressed: () {
                    bool isValidate = _globalKey.currentState!.validate();

                    if (isValidate) {
                      Auth().updateProfilePhone(_phoneController.text,
                          FirebaseAuth.instance.currentUser!.uid);
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("Success")));
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text("ok")),
            ],
          );
        });
  }
}
