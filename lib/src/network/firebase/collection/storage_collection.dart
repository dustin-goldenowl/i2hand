import 'package:firebase_storage/firebase_storage.dart';

class XStorageCollection {
  static Reference get users => FirebaseStorage.instance.ref().child('user');
}
