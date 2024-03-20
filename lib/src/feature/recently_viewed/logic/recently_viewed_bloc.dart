import 'package:flutter/material.dart';
import 'package:i2hand/src/feature/recently_viewed/logic/recently_viewed_state.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/network/model/product/product.dart';
import 'package:i2hand/src/utils/base_cubit.dart';
import 'package:i2hand/src/utils/datetime_ext.dart';
import 'package:i2hand/src/utils/utils.dart';
import 'package:table_calendar/table_calendar.dart';

class RecentlyViewedBloc extends BaseCubit<RecentlyViewedState> {
  RecentlyViewedBloc()
      : super(RecentlyViewedState(
          selectedDate: DateTime.now(),
          listProducts: List.empty(growable: true),
        ));

  Future<void> inital(BuildContext context) async {
    try {
      // TODO: Add logic get recently data
      // final data =
      //     await GetIt.I.get<NewProductsLocalRepo>().getAllDetails().get();
      // final listProducts = data.convertToProductData();
      emit(state.copyWith(listProducts: [MProduct.empty()]));
    } catch (e) {
      xLog.e(e);
    }
  }

  void showExpandedCalendar(bool isExpanded) {
    emit(state.copyWith(isExpanded: isExpanded));
  }

  void onChangedSelectedDate(DateTime date) {
    emit(state.copyWith(selectedDate: date));
  }

  String getDateText(BuildContext context) {
    // Return text format Month, day when selectedDate isn't equal with today and yesterday
    if (!isSameDay(DateTime.now(), state.selectedDate) &&
        !isSameDay(
          DateTime.now().subtract(const Duration(days: 1)),
          state.selectedDate,
        )) {
      return state.selectedDate.toMMMd;
    }
    return S.of(context).yesterday;
  }

  bool isSelectedDate() {
    if (!isSameDay(DateTime.now(), state.selectedDate)) {
      return true;
    }
    return false;
  }
}
