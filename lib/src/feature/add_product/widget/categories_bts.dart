import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i2hand/src/feature/global/logic/global_bloc.dart';
import 'package:i2hand/src/feature/global/logic/global_state.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/network/model/category/category.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/widget/separate/dash_separate.dart';

class XCategoriesBottomsheet extends StatelessWidget {
  const XCategoriesBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _renderHeader(context),
            _renderListCategories(context),
          ],
        ),
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
      S.of(context).selectCategory,
      style: AppTextStyle.labelStyle.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _renderListCategories(BuildContext context) {
    return BlocBuilder<GlobalBloc, GlobalState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (MCategory category in state.listCategories)
                _renderCategoryItem(context, category: category)
            ],
          ),
        );
      },
    );
  }

  Widget _renderCategoryItem(BuildContext context,
      {required MCategory category}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppPadding.p12),
          child: Text(
            category.name,
            style:
                AppTextStyle.contentTexStyle.copyWith(color: AppColors.black),
          ),
        ),
        const XDashSeparator(
          height: AppSize.s0_5,
          dashWidth: AppSize.s4,
          color: AppColors.grey4,
        ),
      ],
    );
  }
}
