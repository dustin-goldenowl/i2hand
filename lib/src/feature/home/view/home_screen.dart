import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i2hand/package/dismiss_keyboard/dismiss_keyboard.dart';
import 'package:i2hand/src/feature/home/logic/home_bloc.dart';
import 'package:i2hand/src/feature/home/logic/home_state.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/network/model/category/category.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/src/utils/utils.dart';
import 'package:i2hand/widget/appbar/app_bar.dart';
import 'package:i2hand/widget/carousel/default_carousel.dart';
import 'package:i2hand/widget/text_field/search_input.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().initial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey7,
      body: DismissKeyBoard(
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _renderAppBar(),
              XPaddingUtils.verticalPadding(height: AppPadding.p10),
              _renderNotificationBanner(context),
              _renderCategoriesSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderAppBar() {
    return Container(
      color: AppColors.white,
      child: XAppBar(
          titlePage: S.of(context).i2hand,
          actions: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: XSearchInput(
                  onChanged: (searchText) {},
                  bgColor: AppColors.grey8,
                  suffix: const Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt_outlined,
                        size: AppSize.s24,
                        color: AppColors.blue,
                      ),
                    ],
                  ),
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
          )),
    );
  }

  Widget _renderNotificationBanner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.r16),
        color: AppColors.white,
      ),
      child: const XCarousel(),
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
          _renderTitleSection(context),
          XPaddingUtils.verticalPadding(height: AppPadding.p10),
          _renderListCategories(),
        ],
      ),
    );
  }

  Widget _renderTitleSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppPadding.p16),
      child: Text(
        S.of(context).categories,
        style:
            AppTextStyle.contentTexStyleBold.copyWith(color: AppColors.black),
      ),
    );
  }

  Widget _renderListCategories() {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          previous.listCategory != current.listCategory,
      builder: (context, state) {
        return SizedBox(
          height: AppSize.s200,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: context.read<HomeBloc>().getNumberColumns(),
              itemBuilder: (context, index) {
                return _renderCategoryInOneColumn(
                    firstCategory: state.listCategory[2 * index],
                    secondCategory:
                        context.read<HomeBloc>().checkInvalidIndex(index)
                            ? null
                            : state.listCategory[2 * index + 1]);
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
        _renderCategory(firstCategory),
        XPaddingUtils.verticalPadding(height: AppPadding.p12),
        isNullOrEmpty(secondCategory)
            ? const SizedBox.shrink()
            : _renderCategory(secondCategory!),
      ],
    );
  }

  Widget _renderCategory(MCategory category) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
      width: AppSize.s70,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.memory(
            Uint8List.fromList(
              category.image?.map((e) => int.parse(e)).toList() ?? [],
            ),
            height: AppSize.s60,
            width: AppSize.s60,
          ),
          Text(
            category.name,
            style:
                AppTextStyle.contentTexStyle.copyWith(color: AppColors.black),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            maxLines: 2,
          )
        ],
      ),
    );
  }
}
