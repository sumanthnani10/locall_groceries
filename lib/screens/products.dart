import 'package:flutter/material.dart';
import 'package:locallgroceries/containers/product_item.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          splashColor: Colors.green,
          backgroundColor: Colors.white,
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.black),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            'All',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 8),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.black12),
                          child: Text(
                            'Grains',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 8),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.black12),
                          child: Text(
                            'Oils',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 8),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.black12),
                          child: Text(
                            'Cookies',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 8),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.black12),
                          child: Text(
                            'Drinks',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 8),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.black12),
                          child: Text(
                            'Bread',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 8),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.black12),
                          child: Text(
                            'Fruits',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 8),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.black12),
                          child: Text(
                            'Vegetables',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 8),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.black12),
                          child: Text(
                            'Diary',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth <= 600) {
                        return GridView.count(
                          physics: BouncingScrollPhysics(),
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          childAspectRatio: 0.825,
                          children: List.generate(10, (index) {
                            return ProductItem(
                                'Rice ${index}',
                                (100 + index) % 29,
                                10 + index % 2,
                                ((100 + index) % 29) + 29);
                          }),
                        );
                      } else {
                        return GridView.count(
                          physics: BouncingScrollPhysics(),
                          crossAxisCount: 3,
                          shrinkWrap: true,
                          childAspectRatio: 0.825,
                          children: List.generate(10, (index) {
                            return ProductItem(
                                'Rice ${index}',
                                (100 + index) % 29,
                                10 + index % 2,
                                ((100 + index) % 29) + 29);
                          }),
                        );
                      }
                    },
                  ),
                ],
              ),
            )));
  }
}
