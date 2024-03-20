import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i2hand/src/feature/add_product/logic/add_product_state.dart';
import 'package:i2hand/src/feature/global/logic/global_bloc.dart';
import 'package:i2hand/src/network/model/category/category.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/service/image_handler.dart';
import 'package:i2hand/src/utils/base_cubit.dart';

class AddProductBloc extends BaseCubit<AddProductState> {
  AddProductBloc(String category)
      : super(AddProductState(
          attributesData: createAttributesData(category),
          selectedCategory: initCategory(category),
        ));

  static MCategory initCategory(String categoryText) {
    final listCategories =
        AppCoordinator.context.read<GlobalBloc>().state.listCategories;
    for (MCategory category in listCategories) {
      if (category.name.toLowerCase().compareTo(categoryText.toLowerCase()) ==
          0) {
        return category;
      }
    }
    return MCategory.empty();
  }

  static Map<String, String> createAttributesData(String categoryText) {
    Map<String, String> data = {};
    final listCategories =
        AppCoordinator.context.read<GlobalBloc>().state.listCategories;
    for (MCategory category in listCategories) {
      if (category.name.toLowerCase().compareTo(categoryText.toLowerCase()) ==
          0) {
        for (var element in category.attributes) {
          data.addEntries({element: ''}.entries);
        }
      }
    }
    return data;
  }

  Future<void> showSelectedPage(
      {required String attributeName,
      required String selectedValue,
      bool isSelectCategory = false}) async {
    final value = await AppCoordinator.showSelectedAttributeValueScreen(
      attributeName: attributeName,
      selectedValue: selectedValue.isEmpty ? '1' : selectedValue,
    );
    isSelectCategory
        ? _setCategoryChange(value)
        : _setAttributeChange(
            value: value,
            attributeName: attributeName,
          );
  }

  void _setCategoryChange(String? value) {
    if (value == null) return;
    final category = AppCoordinator.context
        .read<GlobalBloc>()
        .state
        .listCategories
        .singleWhere(
          (element) => element.name.toLowerCase() == value.toLowerCase(),
        );
    emit(state.copyWith(selectedCategory: category));
  }

  void _setAttributeChange({String? value, required String attributeName}) {
    var copyData = state.getAttributesData;
    copyData[attributeName.toLowerCase()] = value ?? '';
    emit(state.copyWith(attributesData: copyData));
  }

  void onChangedPrice(String price) {
    var copyData = state.getAttributesData;
    copyData['price'] = price;
    emit(state.copyWith(attributesData: copyData));
  }

  void setTitle(String title) {
    emit(state.copyWith(title: title));
  }

  void setDescription(String des) {
    emit(state.copyWith(description: des));
  }

  void showSelectedAddressPage(BuildContext context) async {
    await AppCoordinator.showSelectLocationPage(
      address: state.address.isEmpty ? ' ' : state.address,
    ).then((value) {
      if (value == null) return;
      _onChangedAddress(value);
    });
  }

  void _onChangedAddress(String value) {
    emit(state.copyWith(address: value));
  }

  String getAddressText() {
    final addressRawText = state.address.replaceAll(RegExp(r'\[|\]'), '');
    final addressListData = addressRawText.split(',');
    final removeEmptyAddressDataText =
        addressListData.where((element) => element.trim().isNotEmpty).toList();
    return removeEmptyAddressDataText.join(',');
  }

  void onTapAddImage(BuildContext context) {
    ImageHandler.pickImagehandler(context,
        setImage: (image) => _setImage(image));
  }

  void _setImage(Uint8List image) {
    final listImage = state.listImage ?? [];
    var copyList = listImage.take(10).toList();
    copyList.add(image);
    emit(state.copyWith(listImage: copyList));
  }
}
