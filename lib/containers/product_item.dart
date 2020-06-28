import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  bool stock;

  @override
  void initState() {
    stock = widget.snap['stock'];
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 64, horizontal: 32),
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Hero(
                  tag: widget.snap['product_id'],
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Stock :',
                        style: TextStyle(fontSize: 12),
                      ),
                      Switch.adaptive(
                        value: stock,
                        onChanged: (c) async {
                          stock = c;
                          await Firestore.instance
                              .collection('locations')
                              .document('isnapur')
                              .collection('groceries')
                              .document(widget.snap['product_id'])
                              .updateData({'stock': c});
                        },
                        activeColor: Colors.green,
                        activeTrackColor: Colors.white,
                        inactiveThumbColor: Colors.red,
                        inactiveTrackColor: Colors.white,
                      ),
                    ],
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
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(widget.snap['prices'], (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                widget.snap['quantity_${index + 1}']
                                            .toString() !=
                                        '0'
                                    ? 'Rs.${widget.snap['price_${index + 1}']}/${widget.snap['quantity_${index + 1}']}${widget.snap['unit_${index + 1}']}'
                                    : 'Rs.${widget.snap['price_${index + 1}']}',
                                style: TextStyle(
                                    fontSize: 13, color: Colors.black),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              if (widget.snap['price_${index + 1}'] !=
                                  widget.snap['mrp_${index + 1}'])
                                SizedBox(
                                  width: 4,
                                ),
                              if (widget.snap['price_${index + 1}'] !=
                                  widget.snap['mrp_${index + 1}'])
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
                              if (widget.snap['price_${index + 1}'] !=
                                  widget.snap['mrp_${index + 1}'])
                                SizedBox(
                                  width: 4,
                                ),
                              if (widget.snap['price_${index + 1}'] !=
                                  widget.snap['mrp_${index + 1}'])
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
                ),
              ],
            ),
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
                              tag: widget.snap['product_id'],
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
                            SizedBox(
                              height: 1,
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
                              padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    widget.snap['quantity_1'].toString() != '0'
                                        ? 'Rs.${widget.snap['price_1']}/${widget.snap['quantity_1']}${widget.snap['unit_1']}'
                                        : 'Rs.${widget.snap['price_1']}',
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.black),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  if (widget.snap['price_1'] !=
                                      widget.snap['mrp_1'])
                                    SizedBox(
                                      width: 4,
                                    ),
                                  if (widget.snap['price_1'] !=
                                      widget.snap['mrp_1'])
                                    Text(
                                      'Rs.${widget.snap['mrp_1']}',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.red,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          decorationColor: Colors.black),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  if (widget.snap['price_1'] !=
                                      widget.snap['mrp_1'])
                                    SizedBox(
                                      width: 4,
                                    ),
                                  if (widget.snap['price_1'] !=
                                      widget.snap['mrp_1'])
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  /*Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Stock',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      Text('10 kg',
                                          style: TextStyle(fontSize: 12))
                                    ],
                                  ),*/
                                  Text(
                                    'Stock :',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Switch.adaptive(
                                    value: stock,
                                    onChanged: (c) async {
                                      setState(() {
                                        stock = c;
                                      });
                                      await Firestore.instance
                                          .collection('locations')
                                          .document('isnapur')
                                          .collection('groceries')
                                          .document(widget.snap['product_id'])
                                          .updateData({'stock': c});
                                    },
                                    activeColor: Colors.green,
                                    activeTrackColor: Colors.white,
                                    inactiveThumbColor: Colors.red,
                                    inactiveTrackColor: Colors.white,
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
                            await FirebaseStorage.instance
                                .ref()
                                .child(
                                    'Images/isnapur/groceries/${widget.snap['product_id']}')
                                .delete();
                            await Firestore.instance
                                .collection('locations')
                                .document('isnapur')
                                .collection('groceries')
                                .document(widget.snap['product_id'])
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
