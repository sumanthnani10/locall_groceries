import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:locallgroceries/containers/product_item.dart';
import 'package:locallgroceries/screens/add_product.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  List<String> categories = [
    'All',
    'Dry Fruits and Masala',
    'Dals & Pulses',
    'Rice & Rice Products',
    'Atta & Flour',
    'Salt & Sugar',
    'Snacks and Food',
    'Soaps and Shampoo',
    'Cleaners',
    'Hair Oils',
    'Body Sprays',
    'Chocolates',
    'Personal Hygiene',
    'Agarbathhi',
    'Others',
  ];

  List<dynamic> products = new List<dynamic>();
  List<dynamic> visproducts = new List<dynamic>();
  String search = '';

  ScrollController scrollController = new ScrollController();

  TextEditingController search_controller = new TextEditingController();

  double bheight = 72;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(bheight),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: TextField(
                    controller: search_controller,
                    maxLines: 1,
                    textInputAction: TextInputAction.search,
                    onChanged: (s) {
                      setState(() {
                        search = s;
                      });
                    },
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.black)),
                        labelStyle: TextStyle(color: Colors.black),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        labelText: 'Search',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.black)),
                        fillColor: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(categories.length, (index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color:
                                  index == 0 ? Colors.black : Colors.black12),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            categories[index],
                            style: TextStyle(
                                color:
                                    index == 0 ? Colors.white : Colors.black),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 32,
            ),
          ),
          title: Text(
            'Products',
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  StreamBuilder(
                    stream: Firestore.instance
                        .collection('locations')
                        .document('isnapur')
                        .collection('groceries')
                        .orderBy('name')
                        .snapshots(),
                    builder: (context, snap) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return LinearProgressIndicator();
                      } else {
                        if (snap.data.documents.length != 0) {
                          products = snap.data.documents;
                          visproducts = products;
                          visproducts = visproducts.where((e) {
                            if (e['name']
                                .toString()
                                .toLowerCase()
                                .contains(search.toLowerCase()))
                              return true;
                            else
                              return false;
                          }).toList();
                          return LayoutBuilder(
                            builder: (context, constraints) {
                              if (constraints.maxWidth <= 600) {
                                return GridView.count(
                                  physics: BouncingScrollPhysics(),
                                  crossAxisCount: 2,
                                  shrinkWrap: true,
                                  childAspectRatio: 0.825,
                                  children: List.generate(visproducts.length,
                                      (index) {
                                    return ProductItem(
                                      snap: visproducts[index],
                                    );
                                  }),
                                );
                              } else {
                                return GridView.count(
                                  physics: BouncingScrollPhysics(),
                                  crossAxisCount: 3,
                                  shrinkWrap: true,
                                  childAspectRatio: 0.825,
                                  children: List.generate(visproducts.length,
                                      (index) {
                                    return ProductItem(
                                      snap: visproducts[index],
                                    );
                                  }),
                                );
                              }
                            },
                          );
                        } else {
                          return Center(
                              child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 32),
                            child: Text('No Products'),
                          ));
                        }
                      }
                    },
                  ),
                ],
              ),
            )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(createRoute(AddProduct()));
          },
          splashColor: Colors.green,
          backgroundColor: Colors.white,
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Route createRoute(dest) {
    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) => dest,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0, 1);
        var end = Offset.zero;
        var curve = Curves.fastOutSlowIn;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
