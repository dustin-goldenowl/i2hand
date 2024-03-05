import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/network/data/country/api_services.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/src/utils/utils.dart';
import 'package:i2hand/widget/button/fill_button.dart';

class XLocationPicker extends StatefulWidget {
  final String initCountry;
  final double bottomsheetHeight;
  const XLocationPicker({
    Key? key,
    required this.initCountry,
    this.bottomsheetHeight = 0,
  }) : super(key: key);

  @override
  State<XLocationPicker> createState() => _XLocationPickerState();
}

class _XLocationPickerState extends State<XLocationPicker> {
  final double _buttonHeight = 150;
  final double _headerHeight = 50;

  late List<String> listCountry = [];

  late String _country;

  @override
  void initState() {
    super.initState();
    Future.wait([_getListCountry()]);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _getListCountry() async {
    try {
      final listCountries = await ApiServices.fetchCountryData();
      if (isNullOrEmpty(listCountries)) return;
      listCountry = listCountries.map((e) => e.name).toList();
      _country = listCountry.first;
      setState(() {});
    } catch (e) {
      xLog.e(e);
      return;
    }
  }

  void _onChangeCountry(String country) {
    _country = country;
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

  Widget _renderListItem({
    required List<String> list,
    required Function(String) onChangeValue,
    required int index,
  }) {
    return Expanded(
      child: Stack(
        children: [
          Picker(
            height: widget.bottomsheetHeight - _buttonHeight - _headerHeight,
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
    );
  }

  Widget _renderScrollPicker(
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
            child: _renderScrollPicker(
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
          onPressed: () => AppCoordinator.pop(_country),
          label: Text(
            S.of(context).done,
            style: AppTextStyle.buttonTextStylePrimary,
          )),
    );
  }
}
