import 'package:flutter/material.dart';
import 'package:locallgroceries/screens/home.dart';
import 'package:overlay_support/overlay_support.dart';

void main() {
  runApp(OverlaySupport(
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: Home(),
    ),
  ));
}
