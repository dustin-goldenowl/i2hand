import 'package:flutter/material.dart';
import 'package:i2hand/src/feature/cart/logic/cart_state.dart';
import 'package:i2hand/src/feature/home/feature/search/widget/location_picker.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/utils/base_cubit.dart';
import 'package:i2hand/src/utils/string_utils.dart';

class CartBloc extends BaseCubit<CartState> {
  CartBloc()
      : super(
          CartState(
            listProductsInCart: List.empty(growable: true),
            listProductsInWishlist: List.empty(growable: true),
            listPopularProduct: List.empty(growable: true),
          ),
        );

  Future<void> selectLocationBottomsheet(BuildContext context,
      {required String location}) async {
    final isLocation = StringUtils.isNullOrEmpty(location);
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => FractionallySizedBox(
        heightFactor: 0.65,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: LayoutBuilder(
            builder: (context, constraints) => XLocationPicker(
              bottomsheetHeight: constraints.maxHeight,
              initCountry: isLocation ? '' : location.split(', ')[1],
              initState: isLocation ? '' : location.split(', ')[0],
            ),
          ),
        ),
      ),
      isScrollControlled: true,
      barrierColor: AppColors.black.withOpacity(0.6),
      enableDrag: true,
      isDismissible: false,
    ).then((value) {
      if (value != null) {}
    });
  }

  void onChangeShippingAddress(String address) {
    emit(state.copyWith(shippingAddress: address));
  }

  String getAddressText() {
    final addressRawText = state.shippingAddress.replaceAll(RegExp(r'\[|\]'), '');
    final addressListData = addressRawText.split(',');
    final removeEmptyAddressDataText =
        addressListData.where((element) => element.trim().isNotEmpty).toList();
    return removeEmptyAddressDataText.join(',');
  }
}
