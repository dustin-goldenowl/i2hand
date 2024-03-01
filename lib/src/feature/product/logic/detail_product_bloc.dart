import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:i2hand/src/feature/product/logic/detail_product_state.dart';
import 'package:i2hand/src/network/data/product/product_repository.dart';
import 'package:i2hand/src/network/data/user/user_repository.dart';
import 'package:i2hand/src/network/model/product/product.dart';
import 'package:i2hand/src/network/model/user/user.dart';
import 'package:i2hand/src/utils/utils.dart';

class DetailProductBloc extends Cubit<DetailProductState> {
  DetailProductBloc(String id)
      : super(DetailProductState(
          id: id,
          product: MProduct.empty(),
        ));

  void fetchStatusFail() =>
      emit(state.copyWith(status: DetailProductScreenStatus.fail));

  void fetchStatusSuccess() =>
      emit(state.copyWith(status: DetailProductScreenStatus.success));
  Future<void> initial(BuildContext context) async {
    await _fetchProductData(state.id);
  }

  Future<void> _fetchProductData(String id) async {
    emit(state.copyWith(status: DetailProductScreenStatus.loading));
    try {
      final result = await GetIt.I
          .get<ProductRepository>()
          .getOrAddProduct(MProduct(id: id));
      if (result.data == null) return fetchStatusFail();
      emit(state.copyWith(product: result.data));
      await _fetchOwnerData(ownerId: result.data!.owner);
    } catch (e) {
      fetchStatusFail();
      xLog.e(e);
    }
  }

  Future<void> _fetchOwnerData({required String ownerId}) async {
    try {
      final result =
          await GetIt.I.get<UserRepository>().getOrAddUser(MUser(id: ownerId));
      if (result.data == null) return fetchStatusFail();
      await _fetchOwnerAvatar(user: result.data!);
      // emit(state.copyWith(user: result.data));
    } catch (e) {
      xLog.e(e);
      rethrow;
    }
  }

  Future<void> _fetchOwnerAvatar({required MUser user}) async {
    try {
      final result = await GetIt.I.get<UserRepository>().getImage(user.id);
      if (result.data == null) emit(state.copyWith(user: user));
      final userData =
          user.copyWith(avatar: result.data!.map((e) => e.toString()).toList());
      emit(state.copyWith(user: userData));
    } catch (e) {
      xLog.e(e);
      rethrow;
    }
  }
}
