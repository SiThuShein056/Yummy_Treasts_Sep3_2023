import 'package:flutter/cupertino.dart';

import '../order_store_ob.dart';

class OrderProvider extends ChangeNotifier {
  List<OrderStoreOb> list = [];
  dynamic totalAmount = 0;

  deleteOrder(OrderStoreOb orderStoreOb) {
    list.removeWhere((element) {
      if (element.pOb!.id == orderStoreOb.pOb!.id) {
        totalAmount -= element.counter! * element.pOb!.price!;
        //this.list.remove(element);
      }
      return element.pOb!.id == orderStoreOb.pOb!.id;
    });
    list.removeWhere((element) => element.pOb!.id == orderStoreOb.pOb!.id);

    notifyListeners();
  }

  add(OrderStoreOb oOb) {
    list.add(oOb);
    totalAmount += oOb.counter! * oOb.pOb!.price!;
    notifyListeners();
  }

  int getLenght() {
    return this.list.length;
  }

  List<OrderStoreOb> getList() {
    return this.list;
  }

  bool hasData(OrderStoreOb orderStoreOb) {
    bool hasData = false;

    list.forEach((element) {
      if (element.pOb!.id == orderStoreOb.pOb!.id) {
        hasData = true;
      }
    });
    return hasData;
  }

  int getCounter(OrderStoreOb orderStoreOb) {
    int counter = 0;
    list.forEach((element) {
      if (element.pOb!.id == orderStoreOb.pOb!.id) {
        counter = element.counter!;
      }
    });
    return counter;
  }

  updateCount(OrderStoreOb orderStoreOb, int count) {
    list.forEach((element) {
      if (element.pOb!.id == orderStoreOb.pOb!.id) {
        totalAmount -= element.counter! * element.pOb!.price!;

        element.counter = count; //to change update qty
        totalAmount += orderStoreOb.pOb!.price! * count;
      }
    });
    notifyListeners();
  }

  delete() {
    list.clear();
    totalAmount = 0;
    notifyListeners();
  }
}
