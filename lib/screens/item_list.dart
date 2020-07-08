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

  @override
  Widget build(BuildContext context) {
//    print('${widget.snap['products']} 99');
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
                  color: Colors.yellow,
                  splashColor: Colors.black12,
                  customerName: 'Sumanth',
                  itemnumbers: widget.snap['length'],
                  items: '',
                  onTap: () {},
                  address: '12-80/2, srinagar colony, patancheru',
                  phone: '9100x0xxxx',
                  total: '${widget.snap['total']}',
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
            RaisedButton.icon(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                color: Colors.redAccent,
                onPressed: () async {},
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                label: Text(
                  'Reject',
                  style: TextStyle(color: Colors.white),
                )),
            SizedBox(
              width: 16,
            ),
            RaisedButton.icon(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                color: Colors.lightGreen,
                onPressed: () async {},
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
      ),
    );
  }
}
