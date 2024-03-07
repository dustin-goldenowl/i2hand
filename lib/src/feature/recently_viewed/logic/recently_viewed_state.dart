import 'package:equatable/equatable.dart';
import 'package:i2hand/src/network/model/product/product.dart';

enum RecentlyViewedStatus { init, laoding, success, fail }

class RecentlyViewedState with EquatableMixin {
  RecentlyViewedState({
    this.status = RecentlyViewedStatus.init,
    required this.selectedDate,
    this.isExpanded = false,
    required this.listProducts,
  });

  final RecentlyViewedStatus status;
  final DateTime selectedDate;
  final bool isExpanded;
  final List<MProduct> listProducts;

  RecentlyViewedState copyWith({
    RecentlyViewedStatus? status,
    DateTime? selectedDate,
    bool? isExpanded,
    List<MProduct>? listProducts,
  }) {
    return RecentlyViewedState(
      status: status ?? this.status,
      selectedDate: selectedDate ?? this.selectedDate,
      isExpanded: isExpanded ?? this.isExpanded,
      listProducts: listProducts ?? this.listProducts,
    );
  }

  @override
  List<Object?> get props => [status, selectedDate, isExpanded, listProducts];
}
