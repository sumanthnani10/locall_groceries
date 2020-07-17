import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:locallgroceries/containers/order_container.dart';
import 'package:locallgroceries/screens/history.dart';
import 'package:locallgroceries/screens/profile.dart';
import 'package:locallgroceries/storage.dart';

import 'item_list.dart';
import 'products.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Color> colors = [
    Color(0xffffaf00),
    Color(0xfffff700),
    Color(0xff00fd5d)
  ];
  List<Color> splashColors = [Colors.orange, Colors.yellow, Colors.green];

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  getProducts() async {
    await Firestore.instance
        .collection('locations')
        .document('isnapur')
        .collection('groceries')
        .orderBy('name')
        .snapshots()
        .listen((event) {
      if (mounted) {
        setState(() {
          Storage.productsList = event.documents;
          Storage.products.clear();
          Storage.productsList.forEach((element) {
            Storage.products[element.documentID] = element;
          });
        });
      }
    });
    await Firestore.instance.collection('users').snapshots().listen((event) {
      if (mounted) {
        setState(() {
          Storage.customersList = event.documents;
          print(event.documents.length);
          Storage.customers.clear();
          Storage.customersList.forEach((element) {
            Storage.customers[element.documentID] = element;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          'Orders',
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(28),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Container(
                  width: 113,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Color(0xffffaf00),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          topLeft: Radius.circular(8))),
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    'New Order',
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  width: 113,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xfffff700),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    'Accepted Order',
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  width: 113,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Color(0xff00fd5d),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(8),
                          topRight: Radius.circular(8))),
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    'Packed Order',
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 16,
              ),
              StreamBuilder(
                stream: Firestore.instance
                    .collection('orders')
                    .where('details.type', isEqualTo: 'grocery')
                    .where('details.provider_id',
                    isEqualTo: 'isnapur_grocery_sairam')
                    .where('details.stage', whereIn: [
                  'Order Placed',
                  'Accepted',
                  'Packed'
                ]).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return LinearProgressIndicator();
                  } else {
                    if (!snapshot.hasData)
                      return Text('No Orders');
                    else {
                      snapshot.data.documents.sort((a, b) {
                        if (b['time']['order_placed']
                            .toDate()
                            .isBefore(a['time']['order_placed'].toDate()))
                          return -1;
                        else
                          return 1;
                      });
                      return ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(0),
                          itemBuilder: (_, index) {
                            var snap = snapshot.data.documents[index].data;
                            int c = 0;
                            switch (snap['details']['stage']) {
                              case 'Order Placed':
                                c = 0;
                                break;
                              case 'Accepted':
                                c = 1;
                                break;
                              case 'Packed':
                                c = 2;
                                break;
                            }
                            ;
                            String items = '';
                            snap['products'].forEach((e) {
                              items +=
                              '${Storage.products[e['product_id']]['name']},';
                            });
                            return OrderContainer(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(createRoute(ItemList(
                                    snap: snap,
                                  )));
                                },
                                splashColor: splashColors[c],
                                color: colors[c],
                                customerName:
                                '${Storage
                                    .customers['${snap['details']['customer_id']}']['first_name']} ${Storage
                                    .customers['${snap['details']['customer_id']}']['last_name']}',
                                itemnumbers: snap['length'],
                                items: items);
                          });
                      /*Column(
                        children: List.generate(snapshot.data.documents.length,
                            (index) {
                          var snap = snapshot.data.documents[index].data;
                          return OrderContainer(
                              onTap: () {
                                Navigator.of(context).push(createRoute(ItemList(
                                  snap: snap,
                                )));
                              },
                              splashColor: Colors.orange,
                              color: Color(0xffffaf00),
                              customerName: snap['details']['customer_id'],
                              itemnumbers: snap['length'],
                              items:
                                  'Small Fresh Fish,Handmade Granite Keyboard,Handmade');
                        }),
                      );*/
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.orange[200], Colors.orange[300]]),
                    //color: Colors.blue,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.photo,
                          size: 70,
                        ),
                      ),
                      Text("Sai Ram"),
                      Text("Kirana Shop"),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FlatButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.home),
                      label: Text(
                        'Home',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(context, createRoute(Products()));
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FlatButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.push(context, createRoute(Products()));
                      },
                      icon: Icon(Icons.shopping_basket),
                      label: Text(
                        'Products',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(context, createRoute(Profile()));
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FlatButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.push(context, createRoute(Profile()));
                      },
                      icon: Icon(Icons.account_circle),
                      label: Text(
                        'Profile',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(context, createRoute(History()));
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FlatButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.push(context, createRoute(History()));
                      },
                      icon: Icon(Icons.history),
                      label: Text(
                        'History',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                  ),
                ),
              ])),
    );
  }

  Route createRoute(dest) {
    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) => dest,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1, 0);
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
