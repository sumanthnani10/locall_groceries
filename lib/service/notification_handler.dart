import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:overlay_support/overlay_support.dart';

class NotificationHandler {
  NotificationHandler._();
  String serverToken =
      'AAAARwUkrPg:APA91bF7MuNF46VnZq8grpnXfJRCjDUrapm5em9A48CCUUwSjjm5FatrH189-RMMMuaLgF5-HqXUERQPlMo1LZGb1DEls5dq_wX3VazvPJujVBSqJaXIomcjkUPg6sKJ1n5QM-ITdw9P';

  factory NotificationHandler() => instance;
  static final NotificationHandler instance = NotificationHandler._();
  final FirebaseMessaging fcm = FirebaseMessaging();
  bool initialized = false;
  String token;
  Future<void> init(context) async {
    if (!initialized) {
      fcm.requestNotificationPermissions();
      fcm.configure(onMessage: (message) async {
        showSimpleNotification(
          Text(
            message['notification']['body'],
          ),
          autoDismiss: true,
          background: Color(0xffffaf00),
          foreground: Colors.black,
          duration: Duration(seconds: 5),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
          position: NotificationPosition.bottom,
        );
      });

      // For testing purposes print the Firebase Messaging token
      token = await fcm.getToken();
      initialized = true;
    }
    return token;
  }

  Future<void> sendMessage(title, body, nt, stage) async {
    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{'body': '$body', 'title': '$title'},
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done',
            'stage': stage
          },
          'to': nt,
        },
      ),
    );
    /*
    final Completer<Map<String, dynamic>> completer =
        Completer<Map<String, dynamic>>();

    fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        completer.complete(message);
      },
    );

    return completer.future;*/
  }
}
