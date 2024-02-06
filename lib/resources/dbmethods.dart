import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class DBMethods {
  Future<String> createRemainder({
    required String title,
    required String date,
    required DateTime time,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('remainders')
          .doc(FirebaseMessaging.instance.getToken().toString())
          .collection('myremainders')
          .doc()
          .set({
        'title': title,
        'description':  date,
        'time': time,
      });
      return 'Remainder created';
    } on Exception {
      return 'error creating remainder';
    }
  }
}
