import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i2hand/package/dismiss_keyboard/dismiss_keyboard.dart';
import 'package:i2hand/src/feature/global/logic/global_bloc.dart';
import 'package:i2hand/src/feature/global/logic/global_state.dart';
import 'package:i2hand/src/feature/home/feature/search/logic/search_bloc.dart';
import 'package:i2hand/src/feature/home/feature/search/logic/search_state.dart';
import 'package:i2hand/src/feature/home/feature/search/widget/location_picker.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/network/model/category/category.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/src/utils/string_utils.dart';
import 'package:i2hand/src/utils/utils.dart';
import 'package:i2hand/widget/appbar/app_bar.dart';
import 'package:i2hand/widget/avatar/avatar.dart';
import 'package:i2hand/widget/text_field/search_input.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey7,
      body: DismissKeyBoard(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                _renderAppBar(),
                XPaddingUtils.verticalPadding(height: AppPadding.p10),
                _renderCategoriesSection(context),
                XPaddingUtils.verticalPadding(height: AppPadding.p10),
                _renderProductNearFromYou(context),
                XPaddingUtils.verticalPadding(height: AppPadding.p10),
                _renderAllProducts(context),
                XPaddingUtils.verticalPadding(height: AppPadding.p45),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderAppBar() {
    return Container(
      color: AppColors.white,
      child: BlocSelector<SearchBloc, SearchState, String>(
        selector: (state) {
          return state.searchText;
        },
        builder: (context, searchText) {
          return XAppBar(
              titlePage: !StringUtils.isNullOrEmpty(searchText)
                  ? ''
                  : S.of(context).i2hand,
              leading: IconButton(
                onPressed: () => AppCoordinator.pop(),
                icon: const Icon(
                  Icons.arrow_back,
                  size: AppSize.s24,
                ),
              ),
              actions: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: XSearchInput(
                      onChanged: (searchText) => context
                          .read<SearchBloc>()
                          .onChangedSearchText(searchText),
                      bgColor: AppColors.grey8,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadius.r30),
                        borderSide: const BorderSide(
                            width: AppSize.s0, color: Colors.transparent),
                      ),
                      focusBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadius.r30),
                        borderSide: const BorderSide(
                            width: AppSize.s0, color: Colors.transparent),
                      ),
                    ),
                  )
                ],
              ));
        },
      ),
    );
  }

  Widget _renderCategoriesSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppPadding.p10),
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.r16),
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          _renderTitleSection(context, title: S.of(context).categories),
          XPaddingUtils.verticalPadding(height: AppPadding.p10),
          _renderListCategories(),
        ],
      ),
    );
  }

  Widget _renderTitleSection(BuildContext context,
      {required String title, Widget? actions}) {
    return Padding(
      padding: const EdgeInsets.only(left: AppPadding.p16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: AppTextStyle.contentTexStyleBold
                  .copyWith(color: AppColors.black),
            ),
          ),
          actions ?? const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _renderListCategories() {
    return BlocBuilder<GlobalBloc, GlobalState>(
      buildWhen: (previous, current) =>
          !listEquals(previous.listCategories, current.listCategories),
      builder: (context, state) {
        return SizedBox(
          height: AppSize.s200,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: context.read<GlobalBloc>().getNumberColumns(),
              itemBuilder: (context, index) {
                return _renderCategoryInOneColumn(
                    firstCategory: state.listCategories[2 * index],
                    secondCategory:
                        context.read<GlobalBloc>().checkInvalidIndex(index)
                            ? null
                            : state.listCategories[2 * index + 1]);
              }),
        );
      },
    );
  }

  Widget _renderCategoryInOneColumn(
      {required MCategory firstCategory, MCategory? secondCategory}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(child: _renderCategory(firstCategory)),
        XPaddingUtils.verticalPadding(height: AppPadding.p12),
        isNullOrEmpty(secondCategory)
            ? const SizedBox.shrink()
            : _renderCategory(secondCategory!),
      ],
    );
  }

  Widget _renderCategory(MCategory category) {
    return BlocBuilder<SearchBloc, SearchState>(
      buildWhen: (previous, current) =>
          !listEquals(previous.selectedCategories, current.selectedCategories),
      builder: (context, state) {
        return GestureDetector(
          onTap: () =>
              context.read<SearchBloc>().onChangedFilterCategories(category),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                XAvatar(
                  imageSize: AppSize.s70,
                  isSelected:
                      context.read<SearchBloc>().isSelectedCategory(category),
                  memoryData: Uint8List.fromList(
                    category.image?.map((e) => int.parse(e)).toList() ?? [],
                  ),
                  imageType: ImageType.memory,
                  borderColor: AppColors.white,
                ),
                Text(
                  category.name,
                  style: AppTextStyle.contentTexStyle
                      .copyWith(color: AppColors.black),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _renderProductNearFromYou(BuildContext context) {
    return Column(
      children: [
        _renderSelectPosition(context),
        Container(
          padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.r16),
            color: AppColors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              _renderTitleSection(context, title: S.of(context).nearYou),
              XPaddingUtils.verticalPadding(height: AppPadding.p10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                child: Text(
                  S.of(context).noProductFound,
                  style: AppTextStyle.contentTexStyleBold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _renderSelectPosition(BuildContext context) {
    return BlocSelector<SearchBloc, SearchState, String?>(
      selector: (state) {
        return state.location;
      },
      builder: (context, location) {
        return GestureDetector(
          onTap: () =>
              _selectLocationBottomsheet(context, location: location ?? ''),
          child: Padding(
            padding: const EdgeInsets.only(left: AppPadding.p15),
            child: Row(
              children: [
                _renderLocationIcon(),
                _renderYourPosition(context, location ?? ''),
                _renderDownArrow()
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _renderLocationIcon() {
    return const Icon(
      Icons.location_on_rounded,
      size: AppSize.s24,
      color: AppColors.errorColor,
    );
  }

  Widget _renderYourPosition(BuildContext context, String location) {
    return Text(
      location,
      style: AppTextStyle.contentTexStyleBold,
    );
  }

  Widget _renderDownArrow() {
    return const Icon(
      Icons.keyboard_arrow_down_rounded,
      size: AppSize.s17,
      color: AppColors.black,
    );
  }

  Future<void> _selectLocationBottomsheet(BuildContext context,
      {required String location}) async {
    final isLocation = StringUtils.isNullOrEmpty(location);
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => FractionallySizedBox(
        heightFactor: 0.65,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: LayoutBuilder(
            builder: (context, constraints) => XLocationPicker(
              bottomsheetHeight: constraints.maxHeight,
              initCountry: isLocation ? '' : location.split(', ')[1],
              initState: isLocation ? '' : location.split(', ')[0],
            ),
          ),
        ),
      ),
      isScrollControlled: true,
      barrierColor: AppColors.black.withOpacity(0.6),
      enableDrag: true,
      isDismissible: false,
    ).then((value) {
      if (value != null) {
        context.read<SearchBloc>().onChangedLocation(value);
      }
    });
  }

  Widget _renderAllProducts(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.r16),
            color: AppColors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              _renderTitleSection(
                context,
                title: S.of(context).allProducts,
                actions: _renderFilterButton(context),
              ),
              XPaddingUtils.verticalPadding(height: AppPadding.p10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                child: Text(
                  S.of(context).noProductFound,
                  style: AppTextStyle.contentTexStyleBold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _renderFilterButton(BuildContext context) {
    return IconButton(
        onPressed: () {
          //TODO: Navigation to filter page
        },
        icon: const Icon(Icons.filter_list_alt));
  }
}
