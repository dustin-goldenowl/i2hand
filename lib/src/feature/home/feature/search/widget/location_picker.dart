import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/network/data/country/api_services.dart';
import 'package:i2hand/src/network/model/country/location.dart';
import 'package:i2hand/src/router/coordinator.dart';
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
  final double bottomsheetHeight;
  const XLocationPicker({
    Key? key,
    required this.initCountry,
    required this.initState,
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

  late List<MLocation> listCountryData;
  late List<MLocation> listStateData;

  late String _country;
  late String _state;

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
      listCountryData = await ApiServices.fetchCountryData();
      if (isNullOrEmpty(listCountryData)) return;
      listCountry = listCountryData.map((e) => e.name).toList();
      _country = listCountry.first;
      setState(() {});
      await _getListState(listCountryData.first);
    } catch (e) {
      xLog.e(e);
      return;
    }
  }

  void _onChangeCountry(MLocation country) {
    _debounce.call(() {
      _country = country.name;
      _getListState(country);
    });
  }

  Future<void> _getListState(MLocation country) async {
    try {
      listStateData =
          await ApiServices.fetchStateDataByCountry(country.iso2 ?? '');
      if (isNullOrEmpty(listStateData)) return;
      listState = listStateData.map((e) => e.name).toList();
      _state = listState.first;
      setState(() {});
    } catch (e) {
      xLog.e(e);
      return;
    }
  }

  void _onChangeState(MLocation state) {
    _debounce.call(() {
      _state = state.name;
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

  Widget _renderListItem(
      {required List<String> list,
      required Function(MLocation) onChangeValue,
      required int index,
      bool isCountry = true,
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
                    final locationName = picker.adapter.text
                        .substring(1, picker.adapter.text.length - 1);

                    MLocation location = _getLocationData(
                        locationName: locationName,
                        listLocation:
                            isCountry ? listCountryData : listStateData);
                    onChangeValue(location);
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

  Widget _renderLocationPicker(
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
              _renderListItem(
                list: listCountry,
                onChangeValue: (country) => _onChangeCountry(country),
                index: listCountry.indexWhere((element) => element == _country),
                label: S.of(context).country,
              ),
              const SizedBox(
                width: AppPadding.p14,
              ),
              _renderListItem(
                list: listState,
                onChangeValue: (state) => _onChangeState(state),
                index: listState.indexWhere((element) => element == _state),
                label: S.of(context).state,
                isCountry: false,
              ),
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
            child: _renderLocationPicker(
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
          _renderCancelButton(context),
          XPaddingUtils.horizontalPadding(width: AppPadding.p16),
          _renderDoneButton(context),
        ],
      ),
    );
  }

  Widget _renderCancelButton(BuildContext context) {
    return Expanded(
      child: XFillButton(
          onPressed: () => AppCoordinator.pop(),
          bgColor: AppColors.black3,
          label: Text(
            S.of(context).cancel,
            style: AppTextStyle.buttonTextStylePrimary
                .copyWith(color: AppColors.white),
          )),
    );
  }

  Widget _renderDoneButton(BuildContext context) {
    return Expanded(
      child: XFillButton(
          onPressed: () => AppCoordinator.pop([_state, _country].join(', ')),
          label: Text(
            S.of(context).done,
            style: AppTextStyle.buttonTextStylePrimary,
          )),
    );
  }

  MLocation _getLocationData(
      {required String locationName, required List<MLocation> listLocation}) {
    for (MLocation data in listLocation) {
      if (locationName == data.name) {
        return data;
      }
    }
    return MLocation.empty();
  }
}
