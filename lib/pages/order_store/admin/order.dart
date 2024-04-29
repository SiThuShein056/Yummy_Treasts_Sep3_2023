import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:magical_food/pages/customer_role/primary_screen/poduct_detail/product_detail_ob.dart';

class Orders {
  Future<DocumentReference> createcustomer(
    String email,
    String totalAmount,
    double lat,
    double log,
    String name,
    String phone,
    String date,
    String time,
    String description,
    String ordertype,
  ) async {
    DocumentReference doc =
        await FirebaseFirestore.instance.collection("customers").add(({
              "email": email,
              "totalAmt": totalAmount,
              "lat": lat,
              "log": log,
              "name": name,
              "phone": phone,
              "date": date,
              "time": time,
              "description": description,
              "ordertype": ordertype,
              "confirm": false,
              "user_id": FirebaseAuth.instance.currentUser!.uid,
              "record_time": DateFormat(
                    "EEEE , MMMM dd, y , ",
                  ).format(DateTime.now()).toString() +
                  DateFormat().add_jms().format(DateTime.now()).toString(),
            }));
    return doc;
  }

  createOrder(int qty, ProductDetailOb pob, String id) {
    FirebaseFirestore.instance.collection("orders").add(({
          "name": pob.name,
          "imageUrl": pob.image,
          "price": pob.price,
          "customer_id": id,
          "qty": qty
        }));
  }

  updateConfirm(String id) {
    FirebaseFirestore.instance.collection("customers").doc(id).update({
      'confirm': true,
    });
  }

  deleteOrder(String id) async {
    QuerySnapshot<Map<String, dynamic>> orders = await FirebaseFirestore
        .instance
        .collection("ordres")
        .where("customer_id", isEqualTo: id)
        .get();
    orders.docs.forEach((element) {
      FirebaseFirestore.instance.collection("orders").doc(element.id).delete();
    });

    FirebaseFirestore.instance.collection("customers").doc(id).delete();
  }

  Stream<QuerySnapshot> getDeliOrderedCustomer() async* {
    Stream<QuerySnapshot> customers = await FirebaseFirestore.instance
        .collection("customers")
        .where("ordertype", isEqualTo: "deliOrder")
        .snapshots();
    yield* customers;
  }

  Stream<QuerySnapshot> getShopOrderedCustomer() async* {
    Stream<QuerySnapshot> customers = await FirebaseFirestore.instance
        .collection("customers")
        .where("ordertype", isEqualTo: "shopOrder")
        .snapshots();
    yield* customers;
  }

  Stream<QuerySnapshot> getcurrentCustomerData() async* {
    Stream<QuerySnapshot> customers = await FirebaseFirestore.instance
        .collection("customers")
        .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
    yield* customers;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getOrder(String id) async {
    QuerySnapshot<Map<String, dynamic>> orders = await FirebaseFirestore
        .instance
        .collection("orders")
        .where("customer_id", isEqualTo: id)
        .get();
    return orders;
  }
}
