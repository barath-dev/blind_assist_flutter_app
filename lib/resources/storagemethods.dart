// ignore_for_file: file_names

import 'dart:typed_data';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final did = FirebaseMessaging.instance.getToken();
  //adding umage to firebase storage
  Future<String> uploadImagetoStorage(Uint8List file) async {
    Reference ref = _storage
        .ref()
        .child('images')
        .child(did.toString())
        .child('${const Uuid().v4()}.jpg');

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snapShot = await uploadTask;
    String url = await snapShot.ref.getDownloadURL();
    return url;
  }
}
