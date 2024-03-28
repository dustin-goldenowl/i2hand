import 'package:equatable/equatable.dart';
import 'package:i2hand/src/network/model/order/order.dart';
import 'package:i2hand/src/network/model/recently_viewed/recently_viewed.dart';
import 'package:i2hand/src/network/model/user/user.dart';

enum ProfileScreenStatus { init, loading, failed, succeeded }

class ProfileState with EquatableMixin {
  ProfileState({
    this.status = ProfileScreenStatus.init,
    required this.account,
    required this.listOrder,
    required this.listRecentlyViewed,
    this.numberPage = 0,
  });

  final ProfileScreenStatus status;
  final MUser account;
  final List<MOrder> listOrder;
  final List<MRecentlyViewedProduct> listRecentlyViewed;
  final int numberPage;
  ProfileState copyWith({
    ProfileScreenStatus? status,
    MUser? account,
    List<MOrder>? listOrder,
    List<MRecentlyViewedProduct>? listRecentlyViewed,
    int? numberPage,
  }) {
    return ProfileState(
      status: status ?? this.status,
      account: account ?? this.account,
      listOrder: listOrder ?? this.listOrder,
      listRecentlyViewed: listRecentlyViewed ?? this.listRecentlyViewed,
      numberPage: numberPage ?? this.numberPage,
    );
  }

  @override
  List<Object?> get props =>
      [status, account, listOrder, listRecentlyViewed, numberPage];
}
