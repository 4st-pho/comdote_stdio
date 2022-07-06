import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageMethos {
  final FirebaseStorage _storage = FirebaseStorage.instance;

// upload image to firebase_storage and get link image;
  Future<String> uploadAndGetImageLink(String childName, File file, ) async {
    Reference ref =
        _storage.ref().child(childName).child(DateTime.now().toIso8601String());
    TaskSnapshot snap = await ref.putFile(file);
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
