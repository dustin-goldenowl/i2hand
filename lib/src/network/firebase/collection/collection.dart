import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:i2hand/src/network/model/category/category.dart';
import 'package:i2hand/src/network/model/product/product.dart';
import 'package:i2hand/src/network/model/user/user.dart';

class XCollection {
  static CollectionReference<MUser> get user =>
      FirebaseFirestore.instance.collection('users').withConverter<MUser>(
            fromFirestore: (snapshot, options) =>
                MUser.fromJson(snapshot.data() as Map<String, dynamic>),
            toFirestore: (chatRoom, _) => chatRoom.toJson(),
          );

  static CollectionReference<MCategory> get category =>
      FirebaseFirestore.instance
          .collection('categories')
          .withConverter<MCategory>(
            fromFirestore: (snapshot, options) =>
                MCategory.fromJson(snapshot.data() as Map<String, dynamic>),
            toFirestore: (chatRoom, _) => chatRoom.toJson(),
          );

  static CollectionReference<MProduct> get products =>
      FirebaseFirestore.instance
          .collection('products')
          .withConverter<MProduct>(
            fromFirestore: (snapshot, options) =>
                MProduct.fromJson(snapshot.data() as Map<String, dynamic>),
            toFirestore: (chatRoom, _) => chatRoom.toJson(),
          );
}
