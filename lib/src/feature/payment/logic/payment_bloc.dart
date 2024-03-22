import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:i2hand/src/feature/payment/logic/payment_state.dart';
import 'package:i2hand/src/local/entities/product_entity.dart';
import 'package:i2hand/src/local/repo/product/product_local_repo.dart';
import 'package:i2hand/src/network/data/user/user_repository.dart';
import 'package:i2hand/src/network/model/product/product.dart';
import 'package:i2hand/src/network/model/user/user.dart';
import 'package:i2hand/src/service/shared_pref.dart';
import 'package:i2hand/src/service/stripe_payment_handler.dart';
import 'package:i2hand/src/utils/base_cubit.dart';
import 'package:i2hand/src/utils/string_utils.dart';
import 'package:i2hand/src/utils/utils.dart';

class PaymentBloc extends BaseCubit<PaymentState> {
  PaymentBloc(String id)
      : super(PaymentState(
          product: MProduct.empty(),
          productId: id,
          seller: MUser.empty(),
          user: MUser.empty(),
        ));

  void _fetchStatusFail() =>
      emit(state.copyWith(status: PaymentScreenStatus.fail));

  void _fetchStatusLoading() =>
      emit(state.copyWith(status: PaymentScreenStatus.loading));

  void _fetchStatusSuccess() =>
      emit(state.copyWith(status: PaymentScreenStatus.success));

  Future<void> inital(BuildContext context) async {
    await _getInitalProduct();
    await _getUserData();
  }

  Future<void> _getInitalProduct() async {
    if (StringUtils.isNullOrEmpty(state.productId)) return;
    final product = await GetIt.I
        .get<ProductsLocalRepo>()
        .getDetail(id: state.productId)
        .get();
    final productDetail = product.convertToProductData().first;
    emit(state.copyWith(
      product: productDetail,
      totalPrice: productDetail.price,
    ));
  }

  Future<void> _getUserData() async {
    final user = SharedPrefs.I.getUser();
    emit(state.copyWith(user: user, phoneNumber: user?.phone));
  }

  void setAddress(String address) {
    emit(state.copyWith(address: address));
  }

  Future<void> setPhoneNumber(String phoneContact) async {
    emit(state.copyWith(phoneNumber: phoneContact));
    final user = state.user.copyWith(phone: phoneContact);
    try {
      await GetIt.I.get<UserRepository>().getOrAddUser(user);
      await SharedPrefs.I.setUser(user);
    } catch (e) {
      xLog.e(e);
    }
  }

  void paidProduct() {
    StripePaymentHandle().stripeMakePayment(
      buyerMail: state.user.email ?? '',
      buyerPhone: state.user.phone ?? '',
      address: state.address.split(','),
      price: state.totalPrice,
    );
  }
}
