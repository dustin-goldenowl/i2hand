import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i2hand/src/config/constants/app_const.dart';
import 'package:i2hand/src/config/enum/attribute_enum.dart';
import 'package:i2hand/src/config/enum/product_enum.dart';
import 'package:i2hand/src/feature/global/logic/global_bloc.dart';
import 'package:i2hand/src/feature/home/feature/search/logic/search_bloc.dart';
import 'package:i2hand/src/feature/home/feature/search/logic/search_state.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/network/model/category/category.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/src/utils/utils.dart';
import 'package:i2hand/widget/button/dropdown_button.dart';
import 'package:i2hand/widget/button/radio_button.dart';
import 'package:i2hand/widget/chip/label_chip.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class XFilterBottomsheet extends StatefulWidget {
  const XFilterBottomsheet({super.key, this.category});
  final MCategory? category;

  @override
  State<XFilterBottomsheet> createState() => _XFilterBottomsheetState();
}

class _XFilterBottomsheetState extends State<XFilterBottomsheet> {
  late double _minPrice;
  late double _maxPrice;

  @override
  void initState() {
    super.initState();
    _minPrice = AppConstantData.minPrice;
    _maxPrice = AppConstantData.maxPrice;
    context.read<SearchBloc>().newFilter();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _renderHeader(context),
          XPaddingUtils.verticalPadding(height: AppPadding.p10),
          _renderListFilter(context),
        ],
      ),
    );
  }

  Widget _renderHeader(BuildContext context) {
    return Row(
      children: [
        _renderBackButton(),
        _renderTitle(context),
      ],
    );
  }

  Widget _renderBackButton() {
    return IconButton(
        onPressed: () => AppCoordinator.pop(),
        icon: const Icon(Icons.arrow_back));
  }

  Widget _renderTitle(BuildContext context) {
    return Text(
      S.of(context).filter,
      style: AppTextStyle.titleTextStyle.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _renderListFilter(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        _renderStatusSection(context),
        widget.category == null
            ? _renderSampleFilter(context)
            : _renderCategoryFilter(context),
        _renderPriceFilterSection(context),
      ],
    );
  }

  Widget _renderSampleFilter(BuildContext context) {
    return Column(
      children: [
        _renderStatusFilterSection(context),
      ],
    );
  }

  Widget _renderCategoryFilter(BuildContext context) {
    return Column(
      children: [
        _renderStatusFilterSection(context),
      ],
    );
  }

  Widget _renderStatusSection(BuildContext context) {
    return BlocSelector<SearchBloc, SearchState, ProductStatusEnum>(
      selector: (state) => state.productStatus,
      builder: (context, productStatus) {
        return Row(
          children: [
            XPaddingUtils.horizontalPadding(width: AppPadding.p12),
            Expanded(
                child: XRadioWithLabelButton<ProductStatusEnum>(
              value: ProductStatusEnum.newest,
              groupValue: productStatus,
              label: S.of(context).newest,
              borderRadius: AppRadius.r30,
              onTap: (value) =>
                  context.read<SearchBloc>().setProductStatusFilter(value),
            )),
            XPaddingUtils.horizontalPadding(width: AppPadding.p16),
            Expanded(
              child: XRadioWithLabelButton<ProductStatusEnum>(
                value: ProductStatusEnum.mostViewed,
                groupValue: productStatus,
                label: S.of(context).mostViewed,
                borderRadius: AppRadius.r30,
                onTap: (value) =>
                    context.read<SearchBloc>().setProductStatusFilter(value),
              ),
            ),
            XPaddingUtils.horizontalPadding(width: AppPadding.p12),
          ],
        );
      },
    );
  }

  Widget _renderPriceText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          S.of(context).price,
          style:
              AppTextStyle.titleTextStyle.copyWith(fontSize: AppFontSize.f14),
        ),
        _renderPriceRangeValue(context),
      ],
    );
  }

  Widget _renderPriceRangeValue(BuildContext context) {
    return BlocSelector<SearchBloc, SearchState, SfRangeValues>(
      selector: (state) =>
          state.priceRange ?? AppConstantData.defaultPriceRange,
      builder: (context, priceRange) {
        return DefaultTextStyle(
          style: AppTextStyle.hintTextStyle
              .copyWith(fontSize: AppFontSize.f18, color: AppColors.black),
          child: Row(
            children: [
              _renderPrice(priceRange.start as double),
              Text(S.of(context).dash),
              _renderPrice(priceRange.end as double),
              if (priceRange.end == _maxPrice) Text(S.of(context).plus),
            ],
          ),
        );
      },
    );
  }

  Widget _renderPrice(double price) {
    return Text(
      Utils.createPriceText(price),
    );
  }

  Widget _renderPriceFilterSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p12, vertical: AppPadding.p20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _renderPriceText(context),
          _renderPriceSlider(),
          XPaddingUtils.verticalPadding(height: AppPadding.p15),
          _renderPriceFilter(context),
        ],
      ),
    );
  }

  Widget _renderPriceSlider() {
    return BlocBuilder<SearchBloc, SearchState>(
      buildWhen: (previous, current) =>
          previous.priceRange != current.priceRange,
      builder: (context, state) {
        return SfRangeSlider(
          min: _minPrice,
          max: _maxPrice,
          values: state.priceRange ?? AppConstantData.defaultPriceRange,
          stepSize: 1,
          enableTooltip: true,
          inactiveColor: AppColors.backgroundButton,
          tooltipShape: const SfPaddleTooltipShape(),
          onChanged: (SfRangeValues values) =>
              context.read<SearchBloc>().setPriceRange(values),
          onChangeEnd: (SfRangeValues values) =>
              context.read<SearchBloc>().onChangedPriceRangeEnd(values),
        );
      },
    );
  }

  Widget _renderPriceFilter(BuildContext context) {
    return BlocSelector<SearchBloc, SearchState, PriceFilterEnum>(
      selector: (state) => state.priceFilter,
      builder: (context, priceFilter) {
        return Row(
          children: [
            Expanded(
                child: XRadioWithLabelButton<PriceFilterEnum>(
              value: PriceFilterEnum.priceHighToLow,
              groupValue: priceFilter,
              label: S.of(context).priceHighToLow,
              borderRadius: AppRadius.r30,
              onTap: (value) =>
                  context.read<SearchBloc>().setPriceFilter(value),
            )),
            XPaddingUtils.horizontalPadding(width: AppPadding.p16),
            Expanded(
              child: XRadioWithLabelButton<PriceFilterEnum>(
                value: PriceFilterEnum.priceLowToHigh,
                groupValue: priceFilter,
                label: S.of(context).priceLowToHigh,
                borderRadius: AppRadius.r30,
                onTap: (value) =>
                    context.read<SearchBloc>().setPriceFilter(value),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _renderStatusFilterSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
      child: XDropdownButton(
        label: S.of(context).status,
        expandWidget: Container(
          width: double.infinity,
          child: _renderProductStatus(context),
        ),
      ),
    );
  }

  Widget _renderProductStatus(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppPadding.p2,
        bottom: AppPadding.p10,
      ),
      child: Wrap(
        spacing: AppPadding.p10,
        runSpacing: AppPadding.p10,
        children: _getProductStatusData(),
      ),
    );
  }

  List<Widget> _getProductStatusData() {
    List<Widget> listProductsWidget = [];
    final statusData = context
        .read<GlobalBloc>()
        .state
        .listAttributeData
        .where((element) => element.name == AttributeEnum.status)
        .toList()
        .first;
    for (String productData in statusData.data ?? []) {
      listProductsWidget.add(
        XLabelChip(
          title: productData,
          textStyle: AppTextStyle.hintTextStyle.copyWith(
            fontSize: AppFontSize.f12,
            color: AppColors.black,
          ),
          backgroundColor: AppColors.pinkBackgroundSecondary,
          onTap: () {},
        ),
      );
    }
    return listProductsWidget;
  }
}
