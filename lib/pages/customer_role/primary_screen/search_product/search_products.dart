import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:magical_food/pages/customer_role/primary_screen/poduct_detail/product_detail.dart';
import 'package:magical_food/pages/customer_role/primary_screen/poduct_detail/product_detail_ob.dart';

class SearchProducts extends StatefulWidget {
  const SearchProducts({super.key});

  @override
  State<SearchProducts> createState() => _SearchProductsState();
}

class _SearchProductsState extends State<SearchProducts> {
  List allResult = [];
  List resultList = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _searchController.addListener(_onSearchChanged);
    super.initState();
  }

  _onSearchChanged() {
    print(_searchController.text);
    searchResultList();
  }

  searchResultList() {
    var showResult = [];
    if (_searchController.text != "") {
      for (var clientSnapshot in allResult) {
        var name = clientSnapshot['name'].toString().toLowerCase();
        if (name.contains(_searchController.text.toLowerCase())) {
          showResult.add(clientSnapshot);
        } else {
          resultList = [];
        }
      }
    } else {
      showResult = List.from(allResult);
    }

    setState(() {
      resultList = showResult;
    });
  }

  getClientStream() async {
    var data = await FirebaseFirestore.instance
        .collection("products")
        .orderBy("name")
        .get();

    setState(() {
      allResult = data.docs;
    });
    searchResultList();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    getClientStream();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: CupertinoSearchTextField(
          controller: _searchController,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: resultList.length == 0
            ? Center(
                child: Text("Not found products"),
              )
            : ListView.builder(
                itemCount: resultList.length,
                itemBuilder: (context, indext) {
                  return Card(
                    color: Theme.of(context).primaryColor,
                    child: ListTile(
                      leading: Hero(
                        transitionOnUserGestures: true,
                        tag: resultList[indext]['imageUrl'],
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                            resultList[indext]['imageUrl'],
                          ),
                        ),
                      ),
                      title: Text(
                        resultList[indext]['name'],
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        resultList[indext]['price'].toString() + " MMK",
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.white,
                      ),
                      onTap: () {
                        ProductDetailOb pOb = ProductDetailOb(
                            resultList[indext]['description'],
                            resultList[indext].id,
                            resultList[indext]['imageUrl'],
                            // resultList[indext]['location'],
                            resultList[indext]['name'],
                            resultList[indext]['price']);

                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ProductDetail(pOb);
                        }));
                      },
                    ),
                  );
                }),
      ),
    );
  }
}
