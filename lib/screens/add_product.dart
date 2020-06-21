import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final formkey = GlobalKey<FormState>();
  TextEditingController name_controller = new TextEditingController();
  TextEditingController price_controller = new TextEditingController();
  TextEditingController oprice_controller = new TextEditingController();
  TextEditingController quantity_controller = new TextEditingController();

  String name, cat;

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
          'Add Product',
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                height: 64,
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
                              return "Please enter your Shop Name.";
                            } else {
                              name = pname;
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              labelText: 'Product Name',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.black)),
                              fillColor: Colors.white),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text('Category'),
                        SizedBox(
                          height: 1,
                        ),
                        Container(
                          padding: const EdgeInsets.all(2),
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
                        Row(
                          children: <Widget>[],
                        )
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
