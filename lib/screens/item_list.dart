import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:locallgroceries/containers/order_container.dart';
import 'package:locallgroceries/storage.dart';

class ItemList extends StatefulWidget {
  final snap;

  ItemList({@required this.snap});

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  /*final List<Map<String, String>> listOfColumns = [
    {"Product": "AAAAAA", "Quantity": "1", "Price": "101"},
    {"Product": "BBBJK", "Quantity": "2", "Price": "102"},
    {"Product": "DJDB", "Quantity": "3", "Price": "103"},
    {"Product": "BBWWW", "Quantity": "4", "Price": "104"},
    {"Product": "SSBB", "Quantity": "5", "Price": "105"},
    {"Product": "BBDD", "Quantity": "6", "Price": "106"},
    {"Product": "DD", "Quantity": "7", "Price": "107"},
    {"Product": "BB", "Quantity": "8", "Price": "108"},
    {"Product": "BBBB", "Quantity": "9", "Price": "109"},
    {"Product": "CCCCCC", "Quantity": "1", "Price": "103"}
  ];*/
  List<Color> colors = [
    Color(0xfffff700),
    Color(0xff00fd5d),
    Colors.cyanAccent,
    Colors.redAccent,
  ];
  List<Color> splashColors = [
    Colors.yellow,
    Colors.green,
    Colors.cyan,
    Colors.red
  ];

  @override
  Widget build(BuildContext context) {
    int c = 0;
    switch (widget.snap['details']['stage']) {
      case 'Order Placed':
        c = 0;
        break;
      case 'Accepted':
        c = 1;
        break;
      case 'Packed':
        c = 2;
        break;
      case 'Delivered':
        c = 2;
        break;
      case 'Rejected':
        c = 3;
        break;
    }
    ;
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
          'Order',
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                OrderContainer(
                  color: colors[c],
                  splashColor: splashColors[c],
                  customerName:
                      '${Storage.customers['${widget.snap['details']['customer_id']}']['first_name']} ${Storage.customers['${widget.snap['details']['customer_id']}']['last_name']}',
                  itemnumbers: widget.snap['length'],
                  items: '',
                  onTap: () {},
                  address:
                      '${Storage.customers['${widget.snap['details']['customer_id']}']['address']}',
                  phone:
                      '${Storage.customers['${widget.snap['details']['customer_id']}']['mobile']}',
                  total: '${widget.snap['price']['total']}',
                ),
                DataTable(
                    dataRowHeight: 36,
                    dividerThickness: 0.5,
                    horizontalMargin: 4,
                    columns: [
                      DataColumn(
                        label: Text(
                          'Product',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Quantity',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Price',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      )
                    ],
                    rows: widget.snap['products'].map<DataRow>((e) {
                      return DataRow(cells: <DataCell>[
                        DataCell(
                          Container(
                              width: 96,
                              child: Text(
                                '${Storage.products[e['product_id']]['name']}',
                                maxLines: 2,
                              )),
                        ),
                        DataCell(Center(
                            child: Text(Storage.products[e['product_id']]
                                        ['quantity_${e['price_num']}'] !=
                                    0
                                ? '${e['quantity']} x ${Storage.products[e['product_id']]['quantity_${e['price_num']}']} ${Storage.products[e['product_id']]['unit_${e['price_num']}']}'
                                : '${e['quantity']}'))),
                        DataCell(Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                                'Rs.${Storage.products[e['product_id']]['price_${e['price_num']}'] * e['quantity']}'))),
                      ]);
                    }).toList()),
                /*Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Product',
                        style: TextStyle(
                            fontSize: 16, decoration: TextDecoration.underline),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                      Text(
                        'Quantity',
                        style: TextStyle(
                            fontSize: 16, decoration: TextDecoration.underline),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                      Text(
                        'Price',
                        style: TextStyle(
                            fontSize: 16, decoration: TextDecoration.underline),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                    ],
                  ),
                  ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.black))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Item ${index + 1}',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.indigo),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                ),
                                Text(
                                  '${index + 4} kg',
                                  style: TextStyle(fontSize: 16),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                ),
                                Text(
                                  'Rs.${index + 100}',
                                  style: TextStyle(fontSize: 16),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),*/
              ],
            ),
          )),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            if (widget.snap['details']['stage'] == 'Order Placed')
              Row(
                children: <Widget>[
                  RaisedButton.icon(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      color: Colors.redAccent,
                      onPressed: () async {
                        showLoadingDialog(context, 'Rejecting');
                        await Firestore.instance
                            .collection('orders')
                            .document(widget.snap['order_id'])
                            .updateData({
                          'details.stage': 'Rejected',
                          'time.rejected': FieldValue.serverTimestamp()
                        });
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Reject ',
                        style: TextStyle(color: Colors.white),
                      )),
                  SizedBox(
                    width: 16,
                  ),
                  RaisedButton.icon(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      color: Colors.lightGreen,
                      onPressed: () async {
                        showLoadingDialog(context, 'Accepting');
                        await Firestore.instance
                            .collection('orders')
                            .document(widget.snap['order_id'])
                            .updateData({
                          'details.stage': 'Accepted',
                          'time.accepted': FieldValue.serverTimestamp()
                        });
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Accept',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            if (widget.snap['details']['stage'] == 'Accepted')
              RaisedButton.icon(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  color: Colors.blueAccent,
                  onPressed: () async {
                    showLoadingDialog(context, 'Packing');
                    await Firestore.instance
                        .collection('orders')
                        .document(widget.snap['order_id'])
                        .updateData({
                      'details.stage': 'Packed',
                      'time.packed': FieldValue.serverTimestamp()
                    });
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Packed',
                    style: TextStyle(color: Colors.white),
                  )),
            if (widget.snap['details']['stage'] == 'Packed')
              RaisedButton.icon(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  color: Colors.cyan,
                  onPressed: () async {
                    showLoadingDialog(context, 'Delivering');
                    await Firestore.instance
                        .collection('orders')
                        .document(widget.snap['order_id'])
                        .updateData({
                      'details.stage': 'Delivered',
                      'time.delivered': FieldValue.serverTimestamp()
                    });
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Delivered',
                    style: TextStyle(color: Colors.white),
                  )),
          ],
        ),
      ),
    );
  }

  showLoadingDialog(BuildContext context, String title) {
    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SimpleDialog(
          contentPadding: const EdgeInsets.all(8),
          children: <Widget>[
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(
                    width: 8,
                  ),
                  Text(title)
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
