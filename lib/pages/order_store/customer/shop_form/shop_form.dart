import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:magical_food/location/location_screen.dart';
import 'package:magical_food/pages/order_store/admin/order.dart';
import 'package:magical_food/pages/order_store/customer/finish_order.dart';
import 'package:magical_food/pages/order_store/customer/order_provider/orde0r_noti_provider.dart';
import 'package:magical_food/pages/order_store/customer/provider/order_provider.dart';
import 'package:magical_food/util/address_provider.dart';
import 'package:magical_food/util/locaton_service.dart';
import 'package:magical_food/util/shf.dart';
import 'package:provider/provider.dart';

import '../order_view_ob.dart';

class ShopForm extends StatefulWidget {
  const ShopForm({super.key});

  @override
  State<ShopForm> createState() => _ShopFormState();
}

class _ShopFormState extends State<ShopForm> {
  GlobalKey<FormState> _globalKey = GlobalKey();
  TextEditingController _controllerPhone = TextEditingController();
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerDescription = TextEditingController();
  String dateText = "ရက်စွဲရွေးရန်";
  String timeText = "အချိန်ရွေးရန်";
  int hour = 0;
  int minutes = 0;
  int day = 0;
  int month = 0;
  int year = 0;

  @override
  Widget build(BuildContext context) {
    var orderProvider = Provider.of<OrderProvider>(context);
    AddressProvider addressPro =
        Provider.of<AddressProvider>(context, listen: false);
    addressPro.getLocationAddress();
    OrderNotiProvider onp = Provider.of(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Shop Order Form",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Form(
        key: _globalKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              Container(
                height: 80,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: ScrollPhysics(),
                    itemCount: orderProvider.getLenght(),
                    itemBuilder: (context, index) {
                      OrderViewOb orderViewOb = OrderViewOb(
                        orderProvider.getList()[index].counter,
                        orderProvider.getList()[index].pOb!.description,
                        orderProvider.getList()[index].pOb!.id,
                        orderProvider.getList()[index].pOb!.image,
                        // orderProvider.getList()[index].pOb!.location,
                        orderProvider.getList()[index].pOb!.name,
                        orderProvider.getList()[index].pOb!.price!.toInt(),
                      );
                      return Container(
                        width: 50,
                        height: 80,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          orderViewOb.image.toString(),
                          fit: BoxFit.cover,
                        ),
                      );
                    }),
              ),
              SizedBox(height: 20),
              Card(
                shadowColor: Theme.of(context).primaryColor,
                child: ListTile(
                  leading: Icon(
                    Icons.money,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(
                    "စုစုပေါင်း ပမာဏ",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  trailing: Text(
                    orderProvider.totalAmount.toString() + " MMK",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                  child: ListTile(
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).primaryColor,
                ),
                onTap: () async {
                  await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2025, 12))
                      .then((value) {
                    if (value != null) {
                      print(DateFormat().add_yMMMMEEEEd().format(value));
                      String date = DateFormat().add_yMMMMEEEEd().format(value);
                      setState(() {
                        dateText = date;
                        year = value.year;
                        month = value.month;
                        day = value.day;
                      });
                    }
                  });
                },
                leading: Icon(
                  Icons.date_range_outlined,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text(
                  dateText,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )),
              SizedBox(height: 20),
              Card(
                  child: ListTile(
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).primaryColor,
                ),
                onTap: dateText == "ရက်စွဲရွေးရန်"
                    ? () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("ရက်စွဲကိုအရင်‌ရွေးပါ")));
                      }
                    : () async {
                        await showTimePicker(
                                context: context, initialTime: TimeOfDay.now())
                            .then((value) {
                          if (value != null) {
                            setState(() {
                              hour = value.hour;
                              minutes = value.minute;
                            });

                            if (year == DateTime.now().year &&
                                month == DateTime.now().month &&
                                day == DateTime.now().day &&
                                (hour < DateTime.now().hour ||
                                    minutes < DateTime.now().minute)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "အနည်းဆုံးတစ်နာရီ ကြိုတင်မှာယူရန်")));
                            } else {
                              timeText = value.format(context).toString();
                            }
                          }
                        });
                      },
                leading: Icon(
                  Icons.timer,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text(
                  timeText,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )),
              SizedBox(height: 20),
              TextFormField(
                controller: _controllerName,
                cursorRadius: Radius.circular(10),
                cursorWidth: 10,
                cursorHeight: 10,
                cursorColor: Color.fromARGB(255, 147, 230, 147),
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "need to fill";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(15),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                  prefixIcon: Icon(
                    Icons.person,
                    color: Theme.of(context).primaryColor,
                  ),
                  hintText: 'အမည်',
                  hintStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                maxLength: 11,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _controllerPhone,
                cursorRadius: Radius.circular(10),
                cursorWidth: 10,
                cursorHeight: 10,
                cursorColor: Color.fromARGB(255, 147, 230, 147),
                keyboardType: TextInputType.number,
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
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(15),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                  prefixIcon: Icon(
                    Icons.phone,
                    color: Theme.of(context).primaryColor,
                  ),
                  hintText: 'Order confirm လုပ်ဖို့ဆက်သွယ်ရန် phone',
                  hintStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
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
                  contentPadding: EdgeInsets.all(15),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                  prefixIcon: Icon(
                    Icons.description_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                  hintText: 'Address နှင့် order ရဲ့ အသေးစိတ်',
                  hintStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: (year == DateTime.now().year &&
                            month == DateTime.now().month &&
                            day == DateTime.now().day &&
                            (hour < DateTime.now().hour ||
                                minutes < DateTime.now().minute))
                        ? () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text("အနည်းဆုံးတစ်နာရီ ကြိုတင်မှာယူရန်")));
                          }
                        : () async {
                            bool isValidate =
                                _globalKey.currentState!.validate();
                            if (isValidate &&
                                dateText != "ရက်စွဲရွေးရန်" &&
                                timeText != "အချိန်ရွေးရန်") {
                              var user = FirebaseAuth.instance.currentUser;
                              if (user != null) {
                                DocumentReference doc =
                                    await Orders().createcustomer(
                                  user.email!,
                                  orderProvider.totalAmount.toString(),
                                  0,
                                  0,
                                  _controllerName.text,
                                  _controllerPhone.text,
                                  dateText,
                                  timeText,
                                  _controllerDescription.text,
                                  "shopOrder",
                                );
                                orderProvider.getList().forEach((element) {
                                  Orders().createOrder(
                                      element.counter!, element.pOb!, doc.id);
                                });
                              }
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.5),
                                  duration: Duration(seconds: 2),
                                  content: Text(
                                      "Success ,please wait phonecall from admin")));

                              orderProvider.delete();

                              onp.addNoti();

                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (context) {
                                return FinishOrdered();
                              }), (route) => false);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(.7),
                                      elevation: 0,
                                      duration: Duration(seconds: 1),
                                      content: Text("Do all action")));
                            }
                          },
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context).primaryColor,
                              blurRadius: 2)
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "Check Out",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
