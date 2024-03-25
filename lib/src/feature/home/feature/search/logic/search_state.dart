import 'package:equatable/equatable.dart';
import 'package:i2hand/src/config/enum/product_enum.dart';
import 'package:i2hand/src/network/model/category/category.dart';
import 'package:i2hand/src/network/model/product/product.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

enum SearchStatus { init, loading, fail, success, reload }

class SearchState with EquatableMixin {
  SearchState({
    this.status = SearchStatus.init,
    this.searchText = '',
    this.location = '',
    this.productStatus = ProductStatusEnum.none,
    required this.selectedCategory,
    this.priceRange,
    this.priceFilter = PriceFilterEnum.none,
    required this.searchedProduct,
    this.isChangeFilter = false,
  });

  final SearchStatus status;
  final String searchText;
  final String location;
  final MCategory selectedCategory;
  final ProductStatusEnum productStatus;
  final SfRangeValues? priceRange;
  final PriceFilterEnum priceFilter;
  final List<MProduct> searchedProduct;
  final bool isChangeFilter;

  SearchState copyWith({
    SearchStatus? status,
    String? searchText,
    String? location,
    MCategory? selectedCategory,
    ProductStatusEnum? productStatus,
    SfRangeValues? priceRange,
    PriceFilterEnum? priceFilter,
    List<MProduct>? searchedProduct,
    bool? isChangeFilter,
  }) {
    return SearchState(
      status: status ?? this.status,
      searchText: searchText ?? this.searchText,
      location: location ?? this.location,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      productStatus: productStatus ?? this.productStatus,
      priceRange: priceRange ?? this.priceRange,
      priceFilter: priceFilter ?? this.priceFilter,
      searchedProduct: searchedProduct ?? this.searchedProduct,
      isChangeFilter: isChangeFilter ?? this.isChangeFilter,
    );
  }

  @override
  List<Object?> get props => [
        status,
        searchText,
        selectedCategory,
        location,
        productStatus,
        priceRange,
        priceFilter,
        searchedProduct,
        isChangeFilter,
      ];

  @override
  String toString() {
    return 'SearchState{status=$status, searchText=$searchText, selectedCategories=$selectedCategory, location=$location}';
  }
}
