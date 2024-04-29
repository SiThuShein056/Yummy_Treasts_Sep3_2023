import 'package:flutter/material.dart';
import 'package:magical_food/auth/auth.dart';

class CreateCategory extends StatefulWidget {
  const CreateCategory({super.key});

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _globalKey = GlobalKey();
    TextEditingController _controllerName = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Create Category"),
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
                child: Form(
                    key: _globalKey,
                    child: Column(
                      children: [
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
                              onPressed: () {
                                bool isValidate =
                                    _globalKey.currentState!.validate();
                                if (isValidate) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor:
                                              Theme.of(context).primaryColor,
                                          behavior: SnackBarBehavior.floating,
                                          content: Text("Success")));

                                  Auth().createCategory(_controllerName.text);
                                  Navigator.of(context).pop();
                                } else {
                                  print("Fail");
                                }
                              },
                              child: Text("Create Category")),
                        ),
                      ],
                    )),
              ))
        ],
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(20.0),
      //   child:
      // Form(
      //       key: _globalKey,
      //       child: Column(
      //         children: [
      //           TextFormField(
      //             controller: _controllerName,
      //             validator: (value) {
      //               if (value!.isEmpty) {
      //                 return "need to fill";
      //               }
      //               return null;
      //             },
      //             decoration: InputDecoration(hintText: "Enter the name"),
      //           ),
      //           SizedBox(height: 10),
      //           ElevatedButton(
      //               onPressed: () {
      //                 bool isValidate = _globalKey.currentState!.validate();
      //                 if (isValidate) {
      //                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //                       backgroundColor: Theme.of(context).primaryColor,
      //                       behavior: SnackBarBehavior.floating,
      //                       content: Text("Success")));

      //                   Auth().createCategory(_controllerName.text);
      //                   Navigator.of(context).pop();
      //                 } else {
      //                   print("Fail");
      //                 }
      //               },
      //               child: Text("Create Category")),
      //         ],
      //       )),
      // ),
    );
  }
}
