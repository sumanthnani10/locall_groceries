import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderContainer extends StatelessWidget {
  Color color, splashColor;
  String customerName, items;
  int itemnumbers;
  String address = '', total = '', phone = '';
  VoidCallback onTap;

  OrderContainer(
      {Key key,
      @required this.color,
      @required this.splashColor,
      @required this.customerName,
      @required this.itemnumbers,
      @required this.items,
      @required this.onTap,
      this.address = '',
      this.phone = '',
      this.total = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        child: Ink(
          width: 340,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x16000000),
                  offset: Offset(2, 2),
                  blurRadius: 11,
                ),
                BoxShadow(
                  color: const Color(0x16000000),
                  offset: Offset(-2, -2),
                  blurRadius: 11,
                ),
              ]),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.all(Radius.circular(16)),
            splashColor: splashColor,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    customerName,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        fontFamily: 'Poppins'),
                  ),
                  Text(
                    '${itemnumbers} items',
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Poppins'),
                  ),
                  Text(
                    address == '' ? '${items} items' : address,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Poppins'),
                  ),
                  if (phone != '')
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          phone,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Poppins'),
                        ),
                        Text(
                          'Rs.${total}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    /*Scaffold(
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(-18.0, -110.0),
            child: Stack(
              children: <Widget>[
                Transform.translate(
                  offset: Offset(0.0, 60.0),
                  child: Stack(
                    children: <Widget>[
                      Transform.translate(
                        offset: Offset(18.0, 50.0),
                        child: Container(
                          width: 339.0,
                          height: 98.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: color,
                            border: Border.all(
                                width: 1.0, color: const Color(0xfffeb924)),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0x26000000),
                                offset: Offset(2, 5),
                                blurRadius: 11,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(18.0, 50.0),
                        child: Container(
                          width: 339.0,
                          height: 98.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: color,
                            border: Border.all(width: 1.0, color: color),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0x26e1cece),
                                offset: Offset(-5, -5),
                                blurRadius: 11,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Transform.translate(
                  offset: Offset(35.0, 129.0),
                  child: Text(
                    customerName,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(35.0, 154.0),
                  child: Text(
                    '${itemnumbers} items',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: const Color(0xff000000),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Transform.translate(
                  offset: Offset(35.0, 175.09),
                  child: SizedBox(
                    width: 282.0,
                    height: 18.0,
                    child: Text(
                      items,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 10,
                        color: const Color(0xff000000),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    )*/
  }
}
