import 'package:cloud_firestore/cloud_firestore.dart';

class Storage {
  static List<DocumentSnapshot> productsList;
  static Map<String, dynamic> products = new Map<String, dynamic>();
  static List<DocumentSnapshot> customersList;
  static Map<String, dynamic> customers = new Map<String, dynamic>();
}
