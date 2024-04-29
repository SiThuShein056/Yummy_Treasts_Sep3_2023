import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'create_category.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> refs =
        FirebaseFirestore.instance.collection("categories").snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Text("Categories Screen"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return CreateCategory();
              }));
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot?>(
          stream: refs,
          builder: (context, AsyncSnapshot<QuerySnapshot?> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pop(snapshot.data!.docs[index].id);
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(
                              snapshot.data!.docs[index]['name'].toString()),
                        ),
                      ),
                    );
                  }));
            } else if (snapshot.hasError) {
              return Center(child: Text("error"));
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
