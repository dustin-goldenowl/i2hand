import 'package:flutter/material.dart';
import 'package:i2hand/src/feature/cart/logic/select_location_state.dart';
import 'package:i2hand/src/network/data/country/api_services.dart';
import 'package:i2hand/src/network/model/country/location.dart';
import 'package:i2hand/src/utils/base_cubit.dart';
import 'package:i2hand/src/utils/string_utils.dart';
import 'package:i2hand/src/utils/utils.dart';

class SelectLocationBloc extends BaseCubit<SelectLocationState> {
  SelectLocationBloc(String address)
      : super(SelectLocationState(
          address: address,
          listCityData: List.empty(growable: true),
          listCountryData: List.empty(growable: true),
          listStateData: List.empty(growable: true),
        ));

  /// Address format: [address], [city], [state], [country]
  void inital(BuildContext context) async {
    if (state.address.trim().isEmpty) {
      await _getListCountryData();
      return;
    }
    final listAddress = state.address
        .split('], [')
        .map((e) => e.replaceAll(RegExp(r'\[|\]'), ''))
        .toList();
    await _getDetailAddress(listAddress.first);
    await _getListCountryData(listAddress: listAddress);
  }

  Future<void> _getDetailAddress(String detailAddress) async {
    emit(state.copyWith(initDetailAddress: detailAddress));
    _setAddressText();
  }

  Future<void> _getListCountryData({List<String>? listAddress}) async {
    try {
      final listCountry = await ApiServices.fetchCountryData();
      if (listCountry.isEmpty) return;
      int countryIndex = 0;
      if (!isNullOrEmpty(listAddress)) {
        countryIndex = listCountry
            .indexWhere((element) => element.name == listAddress!.last);
      }
      // If initAddress's lastIndex is not match with listCountry => get the first country in listCountry
      if (countryIndex == -1) {
        countryIndex = 0;
      }
      emit(state.copyWith(
        countryIndex: countryIndex,
        listCountryData: listCountry,
      ));

      _setAddressText();

      // Get state data
      await _getListStateData(
          country: listCountry[countryIndex], listAddress: listAddress);
    } catch (e) {
      xLog.e(e);
    }
  }

  Future<void> _getListStateData(
      {required MLocation country, List<String>? listAddress}) async {
    try {
      final listState =
          await ApiServices.fetchStateDataByCountry(country.iso2 ?? '');
      // This country doesn't have State
      if (listState.isEmpty) {
        emit(state.copyWith(listStateData: List.empty(growable: true)));
        _setAddressText();
        await _getListCityData(
          country: country,
          listAddress: listAddress,
        );
        return;
      }
      int stateIndex = 0;
      if (!isNullOrEmpty(listAddress) && listAddress!.length >= 2) {
        stateIndex = listState.indexWhere(
            (element) => element.name == listAddress[listAddress.length - 2]);
      }
      // If not found State in listState => Get list city by country
      if (stateIndex == -1) {
        await _getListCityData(
          country: country,
          listAddress: listAddress,
        );
        return;
      }
      emit(state.copyWith(
        stateIndex: stateIndex,
        listStateData: listState,
      ));
      _setAddressText();
      // Get list city by country and state
      await _getListCityData(
        country: country,
        stateData: listState[stateIndex],
        listAddress: listAddress,
      );
    } catch (e) {
      xLog.e(e);
    }
  }

  Future<void> _getListCityData({
    required MLocation country,
    MLocation? stateData,
    List<String>? listAddress,
  }) async {
    try {
      final listCity = stateData == null
          ? await ApiServices.fetchCityDataByCountry(
              iso2Country: country.iso2 ?? '')
          : await ApiServices.fetchCityDataByCountryAndState(
              iso2Country: country.iso2 ?? '', iso2State: stateData.iso2 ?? '');
      if (listCity.isEmpty) {
        emit(state.copyWith(listCityData: List.empty()));
        _setAddressText();
        return;
      }
      int cityIndex = 0;
      if (!isNullOrEmpty(listAddress) && listAddress!.length >= 3) {
        cityIndex = listCity.indexWhere(
            (element) => element.name == listAddress[listAddress.length - 3]);
      }
      // If not found City in listCity
      if (cityIndex == -1) {
        cityIndex = 0;
      }
      emit(state.copyWith(
        cityIndex: cityIndex,
        listCityData: listCity,
      ));
      _setAddressText();
    } catch (e) {
      xLog.e(e);
    }
  }

  void onChangeCountry({required String countryText}) async {
    final countryIndex = state.listCountryData
        .indexWhere((element) => element.name == countryText);
    MLocation country = state.listCountryData[countryIndex];
    emit(state.copyWith(countryIndex: countryIndex));
    await _getListStateData(country: country);
  }

  void onChangeState({required String stateText}) async {
    final stateIndex =
        state.listStateData.indexWhere((element) => element.name == stateText);
    MLocation stateData = state.listStateData[stateIndex];
    MLocation country = state.listCountryData[state.countryIndex ?? 0];
    emit(state.copyWith(stateIndex: stateIndex));
    await _getListCityData(country: country, stateData: stateData);
  }

  void onChangeCity({required String cityText}) async {
    final cityIndex =
        state.listCityData.indexWhere((element) => element.name == cityText);
    emit(state.copyWith(cityIndex: cityIndex));
    _setAddressText();
  }

  void onChangeDetailAddress(String text) {
    emit(state.copyWith(detailAddress: text, initDetailAddress: ''));
    _setAddressText();
  }

  void _setAddressText() {
    final detailAddress = StringUtils.isNullOrEmpty(state.initDetailAddress)
        ? state.detailAddress
        : state.initDetailAddress!;
    final cityText = state.listCityData.isEmpty
        ? ''
        : state.listCityData[state.cityIndex ?? 0].name;
    final stateText = state.listStateData.isEmpty
        ? ''
        : state.listStateData[state.stateIndex ?? 0].name;
    final countryText = state.listCountryData.isEmpty
        ? ''
        : state.listCountryData[state.countryIndex ?? 0].name;
    final List<String> addressTextDetail = [
      detailAddress,
      cityText,
      stateText,
      countryText,
    ];
    final addressDetailList = addressTextDetail.map((e) => "[$e]").toList();
    emit(state.copyWith(address: addressDetailList.join(', ')));
  }

  String getAddressText() {
    // Structure raw address [detailAddress], [city], [state], [country]
    final addressRawText = state.address.replaceAll(RegExp(r'\[|\]'), '');
    // return addressRawText = "detailAddress, city, state, country"
    final addressListData = addressRawText.split(',');
    // return addressListData = [detailAddress, city, state, country]
    final removeEmptyAddressDataText =
        addressListData.where((element) => element.trim().isNotEmpty).toList();
    return removeEmptyAddressDataText.join(',');
  }
}
