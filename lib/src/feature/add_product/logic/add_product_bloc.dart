import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:i2hand/src/config/enum/attribute_enum.dart';
import 'package:i2hand/src/feature/account/bloc/account_bloc.dart';
import 'package:i2hand/src/feature/add_product/logic/add_product_state.dart';
import 'package:i2hand/src/feature/global/logic/global_bloc.dart';
import 'package:i2hand/src/local/database_app.dart';
import 'package:i2hand/src/local/repo/new_product/new_product_local_repo.dart';
import 'package:i2hand/src/local/repo/product/product_local_repo.dart';
import 'package:i2hand/src/network/data/product/product_repository.dart';
import 'package:i2hand/src/network/model/category/category.dart';
import 'package:i2hand/src/network/model/product/attribute/attribute.dart';
import 'package:i2hand/src/network/model/product/product.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/service/image_handler.dart';
import 'package:i2hand/src/utils/base_cubit.dart';
import 'package:i2hand/src/utils/string_utils.dart';
import 'package:i2hand/src/utils/utils.dart';

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

  void resetStatus() => emit(state.copyWith(status: AddProductStatus.init));

  void setLoadingStatus() =>
      emit(state.copyWith(status: AddProductStatus.loading));

  void setFailStatus() => emit(state.copyWith(status: AddProductStatus.fail));

  void setSuccessStatus() =>
      emit(state.copyWith(status: AddProductStatus.success));

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
    if (StringUtils.isNullOrEmpty(value)) return;
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

  void onTapAddImage(BuildContext context) {
    AssetHandler.pickImagehandler(context,
        setImage: (image) => _setImage(image));
  }

  Future<void> _setImage(Uint8List image) async {
    final listImage = state.listImage ?? [];
    var copyList = listImage.take(10).toList();
    final compressImage = await AssetHandler.compressImage(image);
    copyList.add(compressImage);
    emit(state.copyWith(listImage: copyList));
  }

  void removeImage(Uint8List image) {
    final listImage = state.listImage ?? [];
    var copyList = listImage.take(10).toList();
    copyList
        .removeWhere((element) => listEquals(element.toList(), image.toList()));
    emit(state.copyWith(listImage: copyList));
  }

  void onTapAddVideo(BuildContext context) {
    AssetHandler.pickVideoHandler(
      context,
      setVideoThumbnail: (image) => _setVideoThumbnail(image),
      setVideo: () {},
    );
  }

  Future<void> _setVideoThumbnail(Uint8List image) async {
    emit(state.copyWith(videoThumbnail: image));
  }

  Future<void> postProduct() async {
    if (state.status == AddProductStatus.loading) return;
    setLoadingStatus();
    final product = MProduct(
      id: StringUtils.createGenerateRandomText(length: 20),
      title: state.title,
      description: state.description,
      attributes: _createListAttributes(),
      province: state.address,
      price: _getPriceValue(state.attributesData['price']),
      isNew: true,
      owner: _getUserId(),
    );
    try {
      final result =
          await GetIt.I.get<ProductRepository>().getOrAddProduct(product);
      if (result.data == null) {
        setFailStatus();
        return;
      }
      await _uploadImageFile(listImage: state.listImage, id: product.id);
      await _syncToLocalDatabase(product);
      setSuccessStatus();
    } catch (e) {
      xLog.e(e);
      setFailStatus();
    }
  }

  Future<void> _uploadImageFile(
      {List<Uint8List>? listImage, required String id}) async {
    if (isNullOrEmpty(listImage)) return;
    for (int index = 0; index < listImage!.length; index++) {
      try {
        await GetIt.I
            .get<ProductRepository>()
            .addImage(id: id, data: listImage[index], index: index);
      } catch (e) {
        xLog.e(e);
      }
    }
  }

  List<MAttributeData> _createListAttributes() {
    List<MAttributeData> data = [];
    state.attributesData.forEach(
      (key, value) {
        data.add(MAttributeData(
            attributeName: AttributeEnum.getAttributeEnum(key), data: value));
      },
    );
    return data;
  }

  String _getUserId() {
    return AppCoordinator.context.read<AccountBloc>().state.account?.id ?? '';
  }

  double _getPriceValue(String? priceText) {
    if (StringUtils.isNullOrEmpty(priceText)) return 0.0;
    return double.parse(priceText!);
  }

  Future<void> _syncToLocalDatabase(MProduct product) async {
    try {
      final image = state.listImage?.first;
      final productLocalData = product.convertToProductLocalData();
      _syncToProductLocal(productLocalData: productLocalData, image: image);
      _syncToNewestProductLocal(newProduct: productLocalData);
    } catch (e) {
      xLog.e(e);
    }
  }

  Future<void> _syncToProductLocal(
      {required ProductsEntityData productLocalData, Uint8List? image}) async {
    await GetIt.I
        .get<ProductsLocalRepo>()
        .insertDetail(productLocalData.copyWith(image: Value(image)));
  }

  Future<void> _syncToNewestProductLocal(
      {required ProductsEntityData newProduct}) async {
    await GetIt.I
        .get<NewProductsLocalRepo>()
        .insertDetail(NewProductsEntityData(id: newProduct.id));
  }
}
