import 'package:flutter/material.dart';
import 'package:i2hand/src/config/constants/app_const.dart';
import 'package:i2hand/src/config/enum/product_enum.dart';
import 'package:i2hand/src/feature/home/feature/search/logic/search_state.dart';
import 'package:i2hand/src/network/model/category/category.dart';
import 'package:i2hand/src/network/model/product/product.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/utils/base_cubit.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SearchBloc extends BaseCubit<SearchState> {
  SearchBloc()
      : super(SearchState(
          selectedCategory: MCategory.empty(),
          searchedProduct: List.empty(growable: true),
        ));

  void resetStatus() => emit(state.copyWith(status: SearchStatus.init));
  void setLoadingStatus() => emit(state.copyWith(status: SearchStatus.loading));
  void setReloadStatus() => emit(state.copyWith(status: SearchStatus.reload));
  void setFailStatus() => emit(state.copyWith(status: SearchStatus.fail));
  void setSuccessStatus() => emit(state.copyWith(status: SearchStatus.success));

  void inital(BuildContext context) {
    setReloadStatus();
    _changedListProduct();
  }

  void newFilter() {
    emit(state.copyWith(isChangeFilter: false));
  }

  void onChangedSearchText(String text) {
    emit(state.copyWith(searchText: text));
  }

  void onChangedFilterCategories(MCategory category) {
    emit(state.copyWith(
      selectedCategory:
          state.selectedCategory == category ? MCategory.empty() : category,
    ));
    return;
  }

  bool isSelectedCategory(MCategory category) =>
      category == state.selectedCategory;

  void onChangedLocation(String location) {
    emit(state.copyWith(location: location));
  }



  void resetFilter() {
    emit(state.copyWith(
      isChangeFilter: false,
      productStatus: ProductStatusEnum.none,
      priceFilter: PriceFilterEnum.none,
      priceRange: AppConstantData.defaultPriceRange,
    ));
  }

  void setProductStatusFilter(ProductStatusEnum value) {
    if (state.productStatus == value) {
      emit(state.copyWith(
          productStatus: ProductStatusEnum.none, isChangeFilter: true));
      _changedListProduct();
      return;
    }
    emit(state.copyWith(productStatus: value, isChangeFilter: true));
    _changedListProduct();
  }

  void setPriceFilter(PriceFilterEnum value) {
    if (state.priceFilter == value) {
      emit(state.copyWith(
          priceFilter: PriceFilterEnum.none, isChangeFilter: true));
      _changedListProduct();
      return;
    }
    emit(state.copyWith(priceFilter: value, isChangeFilter: true));
    _changedListProduct();
  }

  void setPriceRange(SfRangeValues price) {
    emit(state.copyWith(priceRange: price, isChangeFilter: true));
  }

  void onChangedPriceRangeEnd(SfRangeValues price) {
    _changedListProduct();
  }

  Future<void> _changedListProduct() async {
    setLoadingStatus();
    final data =
        await state.productStatus.getListProducts(AppCoordinator.context);

    final dataAfterFilterPrice = await _filterPrice(data);

    final dataFilterByPriceRange =
        await _filterRangePrice(dataAfterFilterPrice);

    emit(state.copyWith(searchedProduct: dataFilterByPriceRange));
    setSuccessStatus();
  }

  Future<List<MProduct>> _filterPrice(List<MProduct> data) async {
    switch (state.priceFilter) {
      case PriceFilterEnum.priceHighToLow:
        final dataSort = [...data];
        dataSort.sort((a, b) => b.price.compareTo(a.price));
        return dataSort;
      case PriceFilterEnum.priceLowToHigh:
        final dataSort = [...data];
        dataSort.sort((a, b) => a.price.compareTo(b.price));
        return dataSort;
      case PriceFilterEnum.none:
        return data;
    }
  }

  Future<List<MProduct>> _filterRangePrice(List<MProduct> data) async {
    final rangeData = [...data];
    final priceRange = state.priceRange ?? AppConstantData.defaultPriceRange;
    if (priceRange == AppConstantData.defaultPriceRange) return rangeData;
    return rangeData.where((element) {
      if (priceRange.end == AppConstantData.maxPrice) {
        return element.price >= priceRange.start;
      }
      return element.price >= priceRange.start &&
          element.price <= priceRange.end;
    }).toList();
  }
}
