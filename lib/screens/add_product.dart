import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final formkey = GlobalKey<FormState>();
  TextEditingController name_controller = new TextEditingController();
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  List<Widget> _items = [];
  List<TextEditingController> price_controller =
      new List<TextEditingController>();
  List<TextEditingController> oprice_controller =
      new List<TextEditingController>();
  List<TextEditingController> quan_controller =
      new List<TextEditingController>();
  List<int> prices = new List<int>(),
      oprices = new List<int>(),
      quans = new List<int>();
  List<String> units = new List<String>();
  int count = 1;

  String name, cat = 'Category 1';

  @override
  void initState() {
    super.initState();
    price_controller.add(new TextEditingController());
    oprice_controller.add(new TextEditingController());
    quan_controller.add(new TextEditingController());
    units.add('kg');
    prices.add(0);
    oprices.add(0);
    quans.add(0);
    _items.add(getWidget(0));
  }

  Widget priceList() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            child: AnimatedList(
              key: listKey,
              initialItemCount: _items.length,
              itemBuilder: (context, index, animation) {
                return _buildItem(context, index, animation);
              },
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              onPressed: () {
                if (_items.length <= 1) return;
                price_controller.removeLast();
                oprice_controller.removeLast();
                quan_controller.removeLast();
                units.removeLast();
                prices.removeLast();
                oprices.removeLast();
                quans.removeLast();
                count--;
                listKey.currentState.removeItem(
                    _items.length - 1,
                    (_, animation) =>
                        _buildItem(context, _items.length - 1, animation),
                    duration: const Duration(milliseconds: 500));
                setState(() {
                  _items.removeLast();
                });
              },
              child: Text(
                "Remove",
              ),
            ),
            FlatButton(
              onPressed: () {
                setState(() {
                  price_controller.add(new TextEditingController());
                  oprice_controller.add(new TextEditingController());
                  quan_controller.add(new TextEditingController());
                  units.add('kg');
                  prices.add(0);
                  oprices.add(0);
                  quans.add(0);
                  count++;
                  listKey.currentState.insertItem(_items.length,
                      duration: const Duration(milliseconds: 500));
                  _items = []
                    ..addAll(_items)
                    ..add(getWidget(_items.length));
                });
              },
              child: Text(
                "Add",
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget getWidget(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: TextFormField(
              controller: price_controller[index],
              maxLines: 1,
              keyboardType: TextInputType.number,
              validator: (pprice) {
                if (pprice.isEmpty) {
                  return "*Required";
                } else {
                  prices[index] = int.parse(pprice);
                  return null;
                }
              },
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.black)),
                  labelStyle: TextStyle(color: Colors.black),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  labelText: 'Price',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.black)),
                  fillColor: Colors.white),
            ),
          ),
          SizedBox(
            width: 4,
          ),
          Flexible(
            child: TextFormField(
              controller: oprice_controller[index],
              maxLines: 1,
              keyboardType: TextInputType.number,
              validator: (pprice) {
                if (pprice.isEmpty) {
                  return "*Required";
                } else {
                  oprices[index] = int.parse(pprice);
                  return null;
                }
              },
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.black)),
                  labelStyle: TextStyle(color: Colors.black),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  labelText: 'MRP',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.black)),
                  fillColor: Colors.white),
            ),
          ),
          SizedBox(
            width: 4,
          ),
          Flexible(
            child: TextFormField(
              controller: quan_controller[index],
              maxLines: 1,
              keyboardType: TextInputType.number,
              validator: (pprice) {
                if (pprice.isEmpty) {
                  return "*Required";
                } else {
                  quans[index] = int.parse(pprice);
                  return null;
                }
              },
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.black)),
                  labelStyle: TextStyle(color: Colors.black),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  labelText: 'Quantity',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.black)),
                  fillColor: Colors.white),
            ),
          ),
          SizedBox(
            width: 4,
          ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 1),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black)),
              child: DropdownButton<String>(
                elevation: 0,
                autofocus: true,
                dropdownColor: Colors.greenAccent,
                iconSize: 16,
                isExpanded: true,
                value: units[index],
                items: <String>['kg', 'grams', 'l', 'ml', 'units']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String value) {
                  setState(() {
                    units[index] = value;
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index, animation) {
    Widget item = _items[index];
    return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, -1),
          end: Offset.zero,
        ).animate(animation),
        child: item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              formkey.currentState.validate();
            },
            child: Text(
              'Save',
              style: TextStyle(color: Colors.indigo),
            ),
          ),
        ],
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
          'Add Product',
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      height: 100,
                      width: 150,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image(
                          image: NetworkImage(
                              'https://media.istockphoto.com/photos/raw-white-rice-in-brown-bowl-and-and-ear-of-rice-or-unmilled-rice-on-picture-id974779604?k=6&m=974779604&s=612x612&w=0&h=YFtU6jUvvpI8NX2W3rxIwB_-G9sW0JJLM6WHbyeEvWI='),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    RaisedButton(
                      color: Color(0xff0011FF),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      onPressed: () {},
                      child: Text(
                        'Add Image',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Theme(
                  data: ThemeData(primaryColor: Colors.black),
                  child: Form(
                      key: formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            controller: name_controller,
                            maxLines: 1,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            validator: (pname) {
                              if (pname.isEmpty) {
                                return "Please enter Product Name.";
                              } else {
                                name = pname;
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                labelStyle: TextStyle(color: Colors.black),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                labelText: 'Product Name',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                fillColor: Colors.white),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(' Category'),
                          SizedBox(
                            height: 1,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.black)),
                            child: DropdownButton<String>(
                              elevation: 0,
                              autofocus: true,
                              dropdownColor: Colors.greenAccent,
                              iconSize: 32,
                              isExpanded: true,
                              value: cat,
                              items: <String>[
                                'Category 1',
                                'Category 2',
                                'Category 3',
                                'Category 4'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String value) {
                                setState(() {
                                  cat = value;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(height: 300, child: priceList())
                        ],
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
