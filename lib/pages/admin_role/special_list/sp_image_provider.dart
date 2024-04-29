import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:magical_food/auth/auth.dart';

class SPImageProvider with ChangeNotifier {
  String imageUrl = "";
  TextEditingController _nameController = TextEditingController();

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
        Auth().updateSPImg(imageUrl, id);
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
        Auth().updateSPImg(imageUrl, id);
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
}
