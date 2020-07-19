import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderContainer extends StatelessWidget {
  Color color, splashColor;
  String customerName, items;
  int itemnumbers;
  String address = '', total = '', phone = '';
  VoidCallback onTap;
  bool fullAddress;

  OrderContainer(
      {Key key,
      @required this.color,
      @required this.splashColor,
      @required this.customerName,
      @required this.itemnumbers,
      @required this.items,
      @required this.onTap,
      this.address = '',
      this.fullAddress = false,
      this.phone = '',
      this.total = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
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
            padding: const EdgeInsets.all(16),
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
                      color: Colors.black, fontSize: 12, fontFamily: 'Poppins'),
                ),
                if (fullAddress)
                  Text(
                    address == '' ? items : address,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Poppins'),
                  ),
                if (!fullAddress)
                  Text(
                    address == '' ? items : address,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Poppins'),
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
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
    );
  }
}
