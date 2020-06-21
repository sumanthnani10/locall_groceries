import 'package:flutter/material.dart';
import 'package:locallgroceries/order_container.dart';

import 'item_list.dart';
import 'products.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).push(createRoute(Products()));
            print('dfvbnjkiu');
          },
          child: Icon(
            Icons.menu,
            color: Colors.black,
            size: 32,
          ),
        ),
        title: Text(
          'Orders',
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 8,
            ),
            Row(
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
            OrderContainer(
                onTap: () {
                  Navigator.of(context).push(createRoute(ItemList()));
                },
                splashColor: Colors.orange,
                color: Color(0xffffaf00),
                customerName: 'Sumanth',
                itemnumbers: 10,
                items: 'Small Fresh Fish,Handmade Granite Keyboard,Handmade')
          ],
        ),
      ),
    );
  }

  Route createRoute(dest) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => dest,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
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
