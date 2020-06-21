import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  String product_name;
  int product_price, product_quantity, product_cut_price;

  ProductItem(
    this.product_name,
    this.product_price,
    this.product_quantity,
    this.product_cut_price,
  );

  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        cardKey.currentState.toggleCard();
      },
      child: FlipCard(
        key: cardKey,
        front: Container(
          child: Padding(
            padding: EdgeInsets.only(bottom: 2),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Hero(
                    tag: product_name,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: AspectRatio(
                        aspectRatio: 3 / 2,
                        child: Image(
                          image: NetworkImage(
                              'https://media.istockphoto.com/photos/raw-white-rice-in-brown-bowl-and-and-ear-of-rice-or-unmilled-rice-on-picture-id974779604?k=6&m=974779604&s=612x612&w=0&h=YFtU6jUvvpI8NX2W3rxIwB_-G9sW0JJLM6WHbyeEvWI='),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      product_name,
                      style: TextStyle(fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Rs.${product_price}/${product_quantity} kg',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          '${((product_cut_price - product_price) / product_cut_price * 100).round()}%',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.green,
                              fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          'Rs.${product_cut_price}',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.red,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.black),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  /*Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Text(
                          snap['Keeper-Details']['Keeper-Name'],
                          style: GoogleFonts.poppins(
                              fontSize: 16, fontWeight: FontWeight.w200),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: RaisedButton.icon(
                        splashColor: Colors.green,
                        animationDuration: Duration(seconds: 1),
                        color: Colors.greenAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        onPressed: () {},
                        icon: Icon(
                          Icons.edit,
                          size: 16,
                        ),
                        label: Text(
                          'Edit',
                          style: TextStyle(fontSize: 16),
                        )),
                  )
                    ],
                  ),*/
                ],
              ),
            ),
          ),
        ),
        back: Container(
          padding: EdgeInsets.all(4),
          decoration:
              BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Flexible(
                child: InkWell(
                  onTap: () {
                    print('Remove');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8))),
                    child: Text('Remove',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    alignment: Alignment.center,
                  ),
                ),
              ),
              Flexible(
                child: InkWell(
                  onTap: () {
                    print('Edit');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8))),
                    alignment: Alignment.center,
                    child: Text(
                      'Modify',
                      style: TextStyle(fontWeight: FontWeight.w600),
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
