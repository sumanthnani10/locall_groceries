import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:locallgroceries/containers/order_container.dart';
import 'package:locallgroceries/screens/item_list.dart';
import 'package:locallgroceries/storage.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
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
          'History',
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
                  width: 169.5,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.cyanAccent,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          topLeft: Radius.circular(8))),
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    'Delivered',
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
                  width: 169.5,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.deepOrangeAccent,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(8),
                          topRight: Radius.circular(8))),
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    'Rejected',
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
                  'Delivered',
                  'Rejected',
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
                                splashColor:
                                snap['details']['stage'] == 'Delivered'
                                    ? Colors.cyan
                                    : Colors.deepOrange,
                                color: snap['details']['stage'] == 'Delivered'
                                    ? Colors.cyanAccent
                                    : Colors.deepOrangeAccent,
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
