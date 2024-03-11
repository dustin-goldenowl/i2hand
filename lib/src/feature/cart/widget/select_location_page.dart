import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:i2hand/package/dismiss_keyboard/dismiss_keyboard.dart';
import 'package:i2hand/src/feature/cart/logic/select_location_bloc.dart';
import 'package:i2hand/src/feature/cart/logic/select_location_state.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/debounce.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/src/utils/string_utils.dart';
import 'package:i2hand/widget/appbar/app_bar.dart';
import 'package:i2hand/widget/button/fill_button.dart';
import 'package:i2hand/widget/text_field/text_field.dart';

class XSelectLocationPage extends StatefulWidget {
  const XSelectLocationPage({
    Key? key,
  }) : super(key: key);

  @override
  State<XSelectLocationPage> createState() => _XSelectLocationPageState();
}

class _XSelectLocationPageState extends State<XSelectLocationPage> {
  final Debounce _debounce = Debounce(const Duration(milliseconds: 500));

  final double _safeHeight = 50.0;

  @override
  void initState() {
    super.initState();
    context.read<SelectLocationBloc>().inital(context);
  }

  @override
  void dispose() {
    _debounce.dispose();
    super.dispose();
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
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Picker(
                  height: AppSize.s250,
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

  Widget _renderLocationPicker(BuildContext context, double width) {
    return BlocBuilder<SelectLocationBloc, SelectLocationState>(
      builder: (context, state) {
        return Container(
          width: width,
          alignment: Alignment.center,
          height: AppSize.s300,
          child: Stack(
            children: [
              Row(
                children: [
                  _renderListItem(
                    list: state.listCountryData.map((e) => e.name).toList(),
                    onChangeValue: (country) => _debounce.call(() {
                      context
                          .read<SelectLocationBloc>()
                          .onChangeCountry(countryText: country);
                    }),
                    index: state.countryIndex ?? 0,
                    label: S.of(context).country,
                  ),
                  const SizedBox(
                    width: AppPadding.p14,
                  ),
                  _renderListItem(
                    list: state.listStateData.map((e) => e.name).toList(),
                    onChangeValue: (state) => _debounce.call(() {
                      context
                          .read<SelectLocationBloc>()
                          .onChangeState(stateText: state);
                    }),
                    index: state.stateIndex ?? 0,
                    label: S.of(context).state,
                  ),
                  const SizedBox(
                    width: AppPadding.p14,
                  ),
                  _renderListItem(
                    list: state.listCityData.map((e) => e.name).toList(),
                    onChangeValue: (city) => _debounce.call(() {
                      context
                          .read<SelectLocationBloc>()
                          .onChangeCity(cityText: city);
                    }),
                    index: state.cityIndex ?? 0,
                    label: S.of(context).city,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const width = double.infinity;
    return DismissKeyBoard(
      child: Scaffold(
        backgroundColor: AppColors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - _safeHeight,
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  _renderAppbar(context),
                  XPaddingUtils.verticalPadding(height: AppPadding.p10),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                    child: _renderLocationPicker(context, width),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppPadding.p16,
                      ),
                      child: _renderDetailAddress(context, width),
                    ),
                  ),
                  _renderDivider(),
                  XPaddingUtils.verticalPadding(height: AppPadding.p10),
                  _renderAddress(context),
                  _renderButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderAppbar(BuildContext context) {
    return XAppBar(
      titlePage: S.of(context).selectLocation,
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
          onPressed: () => AppCoordinator.pop(
              context.read<SelectLocationBloc>().state.address),
          label: Text(
            S.of(context).save,
            style: AppTextStyle.buttonTextStylePrimary,
          )),
    );
  }

  Widget _renderAddress(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p20,
        vertical: AppPadding.p10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            S.of(context).yourAddress,
            style:
                AppTextStyle.labelStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          _renderAddressText(context),
        ],
      ),
    );
  }

  Widget _renderDetailAddress(BuildContext context, double width) {
    return BlocBuilder<SelectLocationBloc, SelectLocationState>(
      buildWhen: (previous, current) =>
          previous.detailAddress != current.detailAddress,
      builder: (context, state) {
        return XTextField(
          hintText: S.of(context).address,
          labelStyle: AppTextStyle.labelStyle.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
          initText: StringUtils.isNullOrEmpty(state.detailAddress)
              ? state.initDetailAddress
              : null,
          onChanged: (text) =>
              context.read<SelectLocationBloc>().onChangeDetailAddress(text),
          label: S.of(context).address,
          cursorColor: AppColors.primary,
        );
      },
    );
  }

  Widget _renderAddressText(BuildContext context) {
    return BlocBuilder<SelectLocationBloc, SelectLocationState>(
      buildWhen: (previous, current) => previous.address != current.address,
      builder: (context, state) {
        return Text(
          context.read<SelectLocationBloc>().getAddressText(),
          style: AppTextStyle.contentTexStyle,
        );
      },
    );
  }
}
