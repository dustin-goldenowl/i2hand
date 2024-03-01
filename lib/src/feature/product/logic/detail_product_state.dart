import 'package:equatable/equatable.dart';
import 'package:i2hand/src/network/model/product/product.dart';
import 'package:i2hand/src/network/model/user/user.dart';

enum DetailProductScreenStatus { init, loading, success, fail }

enum FetchAssetsStatus { init, loading, success, fail }

class DetailProductState with EquatableMixin {
  DetailProductState({
    required this.id,
    this.status = DetailProductScreenStatus.init,
    required this.product,
    this.user,
    this.assetsStatus = FetchAssetsStatus.init,
  });

  final String id;
  final DetailProductScreenStatus status;
  final FetchAssetsStatus assetsStatus;
  final MProduct product;
  final MUser? user;

  DetailProductState copyWith(
      {String? id,
      DetailProductScreenStatus? status,
      FetchAssetsStatus? assetsStatus,
      MProduct? product,
      MUser? user}) {
    return DetailProductState(
      id: id ?? this.id,
      status: status ?? this.status,
      product: product ?? this.product,
      user: user ?? this.user,
      assetsStatus: assetsStatus ?? this.assetsStatus,
    );
  }

  @override
  List<Object?> get props => [id, status, product, user, assetsStatus];

  @override
  String toString() {
    return 'DetailProductState{id=$id, status=$status, product=$product, user=$user}';
  }
}
