import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:i2hand/src/config/constants/duration_const.dart';
import 'package:i2hand/src/feature/profile/logic/profile_state.dart';
import 'package:i2hand/src/local/entities/order_entity.dart';
import 'package:i2hand/src/local/entities/recently_viewed_entity.dart';
import 'package:i2hand/src/local/repo/order/order_local_repo.dart';
import 'package:i2hand/src/local/repo/product/product_local_repo.dart';
import 'package:i2hand/src/local/repo/recently_viewed/recently_viewed_local_repo.dart';
import 'package:i2hand/src/network/model/order/order.dart';
import 'package:i2hand/src/network/model/user/user.dart';
import 'package:i2hand/src/service/shared_pref.dart';
import 'package:i2hand/src/utils/base_cubit.dart';

class ProfileBloc extends BaseCubit<ProfileState> {
  ProfileBloc()
      : super(ProfileState(
          account: MUser.empty(),
          listOrder: List.empty(),
          listRecentlyViewed: List.empty(),
        ));

  PageController pageController = PageController();
  StreamSubscription? _recentlySubcription;
  StreamSubscription? _orderSubcription;

  Future<void> inital() async {
    _getAccount();
    await _initStreamSubscription();
  }

  @override
  Future<void> close() {
    pageController.dispose();
    _recentlySubcription?.cancel();
    _orderSubcription?.cancel();
    return super.close();
  }

  Future<void> _initStreamSubscription() async {
    _streamRecentlyViewed();
    _streamOrder();
  }

  void _streamRecentlyViewed() {
    _orderSubcription = GetIt.I
        .get<OrderLocalRepo>()
        .getAllDetails()
        .watch()
        .listen((event) async {
      List<MOrder> listOrderWithoutImage = event.convertToOrderData();
      List<MOrder> listOrderWithImage = [];
      for (MOrder order in listOrderWithoutImage) {
        final orderWithImage = await _getOrderWithImage(order);
        // Add to list
        listOrderWithImage.add(orderWithImage);
      }
      emit(state.copyWith(listOrder: listOrderWithImage));
    });
  }

  Future<MOrder> _getOrderWithImage(MOrder orderWithoutImage) async {
    final image = await GetIt.I
        .get<ProductsLocalRepo>()
        .getProductImageById(userId: orderWithoutImage.productId);
    return orderWithoutImage.copyWith(
      image: image?.map((e) => e.toString()).toList(),
    );
  }

  void _streamOrder() {
    _recentlySubcription = GetIt.I
        .get<RecentlyViewedLocalRepo>()
        .getAllDetails()
        .watch()
        .listen((event) {
      final listRecently = event.convertToRecentlyProductData();
      emit(state.copyWith(listRecentlyViewed: listRecently));
    });
  }

  void _getAccount() {
    MUser rawAccount = _getAccountData();
    final avatar = _getAccountAvatar();
    final accountData =
        rawAccount.copyWith(avatar: avatar.map((e) => e.toString()).toList());
    emit(state.copyWith(account: accountData));
  }

  MUser _getAccountData() {
    return SharedPrefs.I.getUser() ?? MUser.empty();
  }

  Uint8List _getAccountAvatar() {
    return SharedPrefs.I.getUserAvatar();
  }

  void jumpToPage(int page) {
    pageController.animateToPage(
      page,
      duration: DurationConstant.animateDuration,
      curve: Curves.linear,
    );
    emit(state.copyWith(numberPage: page));
  }
}
