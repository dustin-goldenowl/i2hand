import 'package:i2hand/src/dialog/toast_wrapper.dart';
import 'package:i2hand/src/feature/common/country_logic/search_dial_code_state.dart';
import 'package:i2hand/src/network/data/country/api_services.dart';
import 'package:i2hand/src/network/model/country/country_code.dart';
import 'package:i2hand/src/utils/base_cubit.dart';

class SearchDialCodeBloc extends BaseCubit<SearchDialCodeState> {
  SearchDialCodeBloc() : super(SearchDialCodeState());
  List<CountryCode>? _countryCodes;

  Future<void> initState() async {
    XToast.showLoading();
    _countryCodes = await ApiServices.fetchCountryDomain();
    emit(state.copyWith(countryCodes: _countryCodes));
    if (XToast.isShowLoading) XToast.hideLoading();
  }

  void onChangedSearchInput(String value) {
    final newList = _countryCodes?.where((element) {
      return element.name!.toLowerCase().contains(value.toLowerCase()) ||
          '+${element.dial!}'.contains(value.toLowerCase());
    }).toList();
    emit(state.copyWith(countryCodes: newList));
  }

  void clearSearchInput() {
    emit(state.copyWith(countryCodes: _countryCodes));
  }
}
