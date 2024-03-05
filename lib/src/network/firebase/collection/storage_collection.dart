import 'package:firebase_storage/firebase_storage.dart';

class XStorageCollection {
  static Reference get users => FirebaseStorage.instance.ref().child('user');
  static Reference get categories => FirebaseStorage.instance.ref().child('categories');
  static Reference get products => FirebaseStorage.instance.ref().child('products');
}
