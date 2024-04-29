import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:magical_food/pages/register_login/mail_register/login_screen.dart';
import 'package:magical_food/util/theme_provider.dart';

class Auth {
  register(String email, String password, BuildContext context, String imageUrl,
      String name, String ph) async {
    // Map<String, dynamic> status = {"status": false};
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      //add role in the database
      FirebaseFirestore.instance.collection("role").add({
        "role": "",
        "user_id": user.user!.uid,
        "imageUrl": imageUrl,
        "name": name,
        "phone": ph,
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Success")));
      ThemeProvider().login;
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) {
        return LoginScreen();
      }), (route) => false);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message!)));
    }

    // return status;
  }

  Future<Map<String, dynamic>> login(
      String email, String password, BuildContext context) async {
    Map<String, dynamic> status = {"status": false};
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      status['status'] = true;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message!),
        ),
      );
    }

    return status;
  }

  createCategory(String name) {
    FirebaseFirestore.instance.collection("categories").add({
      'name': name,
    });
  }

  createProduct(
      String name, num price, String category, String imageUrl, String desc) {
    FirebaseFirestore.instance.collection("products").add({
      'name': name,
      'imageUrl': imageUrl,
      'category': category,
      'price': price,
      'description': desc,
    });
  }

  Future<DocumentSnapshot> getProduct(String id) async {
    DocumentSnapshot item =
        await FirebaseFirestore.instance.collection("products").doc(id).get();
    return item;
  }

  Stream<QuerySnapshot> getProfileData() {
    Stream<QuerySnapshot> refs = FirebaseFirestore.instance
        .collection("role")
        .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();

    return refs;
  }

  Future<DocumentSnapshot> getCategory(String id) async {
    DocumentSnapshot item =
        await FirebaseFirestore.instance.collection("categories").doc(id).get();
    return item;
  }

  Future<DocumentSnapshot> getSpecialFood(String id) async {
    DocumentSnapshot item = await FirebaseFirestore.instance
        .collection("speciallist")
        .doc(id)
        .get();
    return item;
  }

  updateCategiry(String name, String id) {
    FirebaseFirestore.instance.collection("categories").doc(id).update({
      'name': name,
    });
  }

  deleteCategory(String id) {
    FirebaseFirestore.instance.collection("categories").doc(id).delete();
  }

  updateProduct(String name, num price, String category, String imageUrl,
      String id, String desc) {
    FirebaseFirestore.instance.collection("products").doc(id).update({
      'name': name,
      'price': price,
      'category': category,
      'imageUrl': imageUrl,
      'description': desc,
    });
  }

  updateProductImg(String imageUrl, String id) {
    FirebaseFirestore.instance.collection("products").doc(id).update({
      'imageUrl': imageUrl,
    });
  }

  updateSPImg(String imageUrl, String id) {
    FirebaseFirestore.instance.collection("speciallist").doc(id).update({
      'imageUrl': imageUrl,
    });
  }

  deleteProduct(String id) {
    FirebaseFirestore.instance.collection("products").doc(id).delete();
  }

  createSpecialList(String name, num price, String imageUrl, String desc) {
    FirebaseFirestore.instance.collection("speciallist").add({
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'description': desc,
    });
  }

  updateSpecialFood(
      String name, num price, String imageUrl, String id, String desc) {
    FirebaseFirestore.instance.collection("speciallist").doc(id).update({
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'description': desc,
    });
  }

  deleteSpecialFood(String id) {
    FirebaseFirestore.instance.collection("speciallist").doc(id).delete();
  }

  deleteDiscountFood(String id) {
    FirebaseFirestore.instance.collection("discountproducts").doc(id).delete();
  }

  updateProfileImage(String imageUrl, String id) async {
    QuerySnapshot ref = await FirebaseFirestore.instance
        .collection("role")
        .where("user_id", isEqualTo: id)
        .get();
    ref.docs.forEach(
      (element) {
        FirebaseFirestore.instance.collection("role").doc(element.id).update({
          "imageUrl": imageUrl,
        });
      },
    );
  }

  updateProfileName(String name, String id) async {
    QuerySnapshot ref = await FirebaseFirestore.instance
        .collection("role")
        .where("user_id", isEqualTo: id)
        .get();
    ref.docs.forEach(
      (element) {
        FirebaseFirestore.instance.collection("role").doc(element.id).update({
          "name": name,
        });
      },
    );
  }

  updateProfilePhone(String ph, String id) async {
    QuerySnapshot ref = await FirebaseFirestore.instance
        .collection("role")
        .where("user_id", isEqualTo: id)
        .get();
    ref.docs.forEach(
      (element) {
        FirebaseFirestore.instance.collection("role").doc(element.id).update({
          "phone": ph,
        });
      },
    );
  }

  createDiscountProduct(
      String name, num price, String category, String imageUrl, String desc) {
    FirebaseFirestore.instance.collection("discountproducts").add({
      'name': name,
      'imageUrl': imageUrl,
      'category': category,
      'price': price,
      'description': desc,
    });
  }

  Future<DocumentSnapshot> getDiscountProduct(String id) async {
    DocumentSnapshot item = await FirebaseFirestore.instance
        .collection("discountproducts")
        .doc(id)
        .get();
    return item;
  }
}
