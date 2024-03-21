import 'package:equatable/equatable.dart';
import 'package:i2hand/src/network/model/country/country_code.dart';
import 'package:i2hand/src/network/model/product/product.dart';
import 'package:i2hand/src/network/model/user/user.dart';

enum PaymentScreenStatus { init, loading, fail, success }

class PaymentState with EquatableMixin {
  PaymentState(
      {this.status = PaymentScreenStatus.init,
      this.address = '',
      this.email = '',
      this.countryCode,
      this.phoneNumber = '',
      this.productId = '',
      required this.seller,
      required this.user,
      required this.product});

  final PaymentScreenStatus status;
  final String address;
  final String email;
  final CountryCode? countryCode;
  final String phoneNumber;
  final MProduct product;
  final String productId;
  final MUser seller;
  final MUser user;

  PaymentState copyWith({
    PaymentScreenStatus? status,
    String? address,
    String? email,
    CountryCode? countryCode,
    String? phoneNumber,
    MProduct? product,
    String? productId,
    MUser? seller,
    MUser? user,
  }) {
    return PaymentState(
      status: status ?? this.status,
      address: address ?? this.address,
      email: email ?? this.email,
      countryCode: countryCode ?? this.countryCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      productId: productId ?? this.productId,
      product: product ?? this.product,
      seller: seller ?? this.seller,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
        status,
        address,
        email,
        countryCode,
        phoneNumber,
        product,
        productId,
        seller,
        user
      ];

  @override
  String toString() {
    return 'PaymentState{status=$status, address=$address, email=$email, countryCode=$countryCode, phoneNumber=$phoneNumber, product=$product}';
  }
}
