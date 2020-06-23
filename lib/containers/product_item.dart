import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:locallgroceries/screens/modify_product.dart';

class ProductItem extends StatefulWidget {
  var snap;

  ProductItem({@required this.snap});

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  bool loading = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000) /*, value: 0.1*/);
    animation =
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 64, horizontal: 32),
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AspectRatio(
                  aspectRatio: 3 / 2,
                  child: Image(
                    image: NetworkImage(widget.snap['image']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  widget.snap['name'],
                  style: TextStyle(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  widget.snap['category'],
                  style: TextStyle(fontSize: 10, color: Colors.black54),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Description :',
                  style: TextStyle(fontSize: 10, color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  widget.snap['description'] == ''
                      ? '    No description'
                      : '    ' + widget.snap['description'],
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Prices :',
                  style: TextStyle(fontSize: 10, color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: List.generate(widget.snap['prices'], (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Rs.${widget.snap['price_${index + 1}']}/${widget.snap['quantity_${index + 1}']}${widget.snap['unit_${index + 1}']}',
                            style: TextStyle(fontSize: 13, color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            'Rs.${widget.snap['mrp_${index + 1}']}',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.red,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.black),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            '(${((widget.snap['mrp_${index + 1}'] - widget.snap['price_${index + 1}']) / widget.snap['mrp_${index + 1}'] * 100).round()}%)',
                            style: TextStyle(
                                fontSize: 8,
                                color: Colors.green,
                                fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: animation,
      child: GestureDetector(
        onLongPress: () {
          cardKey.currentState.toggleCard();
        },
        child: Stack(
          children: <Widget>[
            AbsorbPointer(
              absorbing: loading,
              child: FlipCard(
                key: cardKey,
                front: InkWell(
                  onTap: () {
                    _showDialog();
                  },
                  child: Container(
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
                              tag: widget.snap['name'],
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: AspectRatio(
                                  aspectRatio: 3 / 2,
                                  child: Image(
                                    image: NetworkImage(widget.snap['image']),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Text(
                                widget.snap['name'],
                                style: TextStyle(fontSize: 16),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Text(
                                widget.snap['category'],
                                style: TextStyle(
                                    fontSize: 10, color: Colors.black54),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Rs.${widget.snap['price_1']}/${widget.snap['quantity_1']}${widget.snap['unit_1']}',
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.black),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    'Rs.${widget.snap['mrp_1']}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.red,
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor: Colors.black),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    '(${((widget.snap['mrp_1'] - widget.snap['price_1']) / widget.snap['mrp_1'] * 100).round()}%)',
                                    style: TextStyle(
                                        fontSize: 8,
                                        color: Colors.green,
                                        fontWeight: FontWeight.w600),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                back: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Flexible(
                        child: InkWell(
                          onTap: () async {
                            cardKey.currentState.toggleCard();
                            await Firestore.instance
                                .collection('locations')
                                .document('isnapur')
                                .collection('groceries')
                                .document(widget.snap['name'])
                                .delete();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.deepOrangeAccent,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8))),
                            child: Text('Remove',
                                style: TextStyle(fontWeight: FontWeight.w600)),
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 1,
                      ),
                      Flexible(
                        child: InkWell(
                          onTap: () {
                            cardKey.currentState.toggleCard();
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ModifyProduct(snap: widget.snap),
                            ));
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
            ),
            if (loading)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: LinearProgressIndicator(),
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
