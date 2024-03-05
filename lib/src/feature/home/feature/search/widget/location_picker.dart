import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/network/data/country/api_services.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/debounce.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/src/utils/utils.dart';
import 'package:i2hand/widget/button/fill_button.dart';

class XLocationPicker extends StatefulWidget {
  final String initCountry;
  final String initState;
  final String initCity;
  final double bottomsheetHeight;
  const XLocationPicker({
    Key? key,
    required this.initCountry,
    required this.initState,
    required this.initCity,
    this.bottomsheetHeight = 0,
  }) : super(key: key);

  @override
  State<XLocationPicker> createState() => _XLocationPickerState();
}

class _XLocationPickerState extends State<XLocationPicker> {
  final double _buttonHeight = 150;
  final double _headerHeight = 50;
  final Debounce _debounce = Debounce(const Duration(milliseconds: 500));

  late List<String> listCountry = [];
  late List<String> listState = [];
  late List<String> listCity = [];

  late String _country;
  late String _state;
  late String _city;

  @override
  void initState() {
    super.initState();
    Future.wait([_getListCountry()]);
  }

  @override
  void dispose() {
    _debounce.dispose();
    super.dispose();
  }

  Future<void> _getListCountry() async {
    try {
      final listCountries = await ApiServices.fetchCountryData();
      if (isNullOrEmpty(listCountries)) return;
      listCountry = listCountries.map((e) => e.name).toList();
      _country = listCountry.first;
      setState(() {});
      await _getListState(listCountry.first);
    } catch (e) {
      xLog.e(e);
      return;
    }
  }

  void _onChangeCountry(String country) {
    _debounce.call(() {
      _country = country;
      _getListState(country);
    });
  }

  Future<void> _getListState(String country) async {
    try {
      final listStates = await ApiServices.fetchStateData(country);
      if (isNullOrEmpty(listStates)) return;
      listState = listStates.map((e) => e.name).toList();
      _state = listState.first;
      setState(() {});
      await _getListCity(listState.first);
    } catch (e) {
      xLog.e(e);
      return;
    }
  }

  void _onChangeState(String state) {
    _debounce.call(() {
      _state = state;
      _getListCity(state);
    });
  }

  Future<void> _getListCity(String state) async {
    try {
      final listCities = await ApiServices.fetchCityData(state);
      if (isNullOrEmpty(listCities)) return;
      listCity = listCities.map((e) => e.name).toList();
      _city = listCity.first;
      setState(() {});
    } catch (e) {
      xLog.e(e);
      return;
    }
  }

  void _onChangeCity(String city) {
    _debounce.call(() {
      _city = city;
    });
  }

  Widget _renderFadedContainer(
    AlignmentGeometry begin,
    AlignmentGeometry end,
  ) {
    return IgnorePointer(
      child: Container(
        height: AppSize.s36,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin,
            end: end,
            colors: [
              Colors.white.withOpacity(0),
              Colors.white.withOpacity(1),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderListItemAndroid(
      {required List<String> list,
      required Function(String) onChangeValue,
      required int index,
      required String label}) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: AppTextStyle.labelStyle.copyWith(
              color: AppColors.black,
              fontSize: AppFontSize.f18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Picker(
                  height:
                      widget.bottomsheetHeight - _buttonHeight - _headerHeight,
                  adapter: PickerDataAdapter<String>(
                    pickerData: list,
                  ),
                  diameterRatio: 20,
                  hideHeader: true,
                  onSelect: (Picker picker, int index, List<int> selected) {
                    onChangeValue(picker.adapter.text
                        .substring(1, picker.adapter.text.length - 1));
                  },
                  selecteds: [index == -1 ? 0 : index],
                  selectedTextStyle: AppTextStyle.contentTexStyleBold,
                  selectionOverlay: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.065),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(AppRadius.r4),
                      ),
                    ),
                  ),
                  squeeze: 1,
                  textStyle: AppTextStyle.contentTexStyle,
                ).makePicker(),
                _renderFadedContainer(
                  Alignment.bottomCenter,
                  Alignment.topCenter,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: _renderFadedContainer(
                    Alignment.topCenter,
                    Alignment.bottomCenter,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderAndroidBloodPressurePicker(
    BuildContext context,
    double width,
  ) {
    return Container(
      width: width,
      alignment: Alignment.center,
      child: Stack(
        children: [
          Row(
            children: [
              _renderListItemAndroid(
                list: listCountry,
                onChangeValue: (country) => _onChangeCountry(country),
                index: listCountry.indexWhere((element) => element == _country),
                label: S.of(context).country,
              ),
              const SizedBox(
                width: AppPadding.p14,
              ),
              _renderListItemAndroid(
                list: listState,
                onChangeValue: (state) => _onChangeState(state),
                index: listState.indexWhere((element) => element == _state),
                label: S.of(context).state,
              ),
              const SizedBox(
                width: AppPadding.p14,
              ),
              _renderListItemAndroid(
                list: listCity,
                onChangeValue: (city) => _onChangeCity(city),
                index: listCity.indexWhere((element) => element == _city),
                label: S.of(context).city,
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const width = double.infinity;
    return Column(
      children: [
        XPaddingUtils.verticalPadding(height: AppPadding.p16),
        Text(
          S.of(context).selectLocation,
          style:
              AppTextStyle.titleTextStyle.copyWith(fontWeight: FontWeight.w900),
        ),
        XPaddingUtils.verticalPadding(height: AppPadding.p10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
            child: _renderAndroidBloodPressurePicker(
              context,
              width,
            ),
          ),
        ),
        _renderDivider(),
        XPaddingUtils.verticalPadding(height: AppPadding.p10),
        _renderButton(),
      ],
    );
  }

  Container _renderDivider() {
    return Container(
      height: 1,
      width: double.infinity,
      color: AppColors.divider,
    );
  }

  Widget _renderButton() {
    return Container(
      margin: const EdgeInsets.only(
        bottom: AppMargin.m10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.r16),
      ),
      padding: const EdgeInsets.all(AppPadding.p8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          _renderAddCartButton(context),
          XPaddingUtils.horizontalPadding(width: AppPadding.p16),
          _renderBuyButton(context),
        ],
      ),
    );
  }

  Widget _renderAddCartButton(BuildContext context) {
    return Expanded(
      child: XFillButton(
          bgColor: AppColors.black3,
          label: Text(
            S.of(context).cancel,
            style: AppTextStyle.buttonTextStylePrimary
                .copyWith(color: AppColors.white),
          )),
    );
  }

  Widget _renderBuyButton(BuildContext context) {
    return Expanded(
      child: XFillButton(
          label: Text(
        S.of(context).next,
        style: AppTextStyle.buttonTextStylePrimary,
      )),
    );
  }
}
