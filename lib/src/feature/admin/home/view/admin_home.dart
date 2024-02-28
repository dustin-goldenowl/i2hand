import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i2hand/gen/assets.gen.dart';
import 'package:i2hand/src/feature/admin/home/logic/admin_home_bloc.dart';
import 'package:i2hand/src/feature/admin/home/logic/admin_home_state.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/network/model/category/category.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/src/utils/string_ext.dart';
import 'package:i2hand/src/utils/utils.dart';
import 'package:i2hand/widget/appbar/app_bar.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AdminHomeBloc>().initListCategories(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Stack(
          children: [
            _renderBackground(),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _renderAppBar(context),
                XPaddingUtils.verticalPadding(height: AppPadding.p16),
                _renderListCategories(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _renderBackground() {
    return Assets.svg.bubbles5.svg(fit: BoxFit.fitWidth);
  }

  Widget _renderAppBar(BuildContext context) {
    return XAppBar(
      titlePage: S.of(context).categories,
      fontColor: AppColors.white,
      actions: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () => context
                .read<AdminHomeBloc>()
                .showAttributesDetailBottomsheet(context),
            icon: const Icon(Icons.add),
            color: AppColors.primary,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                AppColors.backgroundButton,
              ),
              shape: MaterialStateProperty.all(
                const CircleBorder(
                  side: BorderSide(
                    color: AppColors.grey6,
                    width: AppSize.s0_5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderListCategories(BuildContext context) {
    return BlocSelector<AdminHomeBloc, AdminHomeState, AdminHomeStatus>(
      selector: (state) {
        return state.status;
      },
      builder: (context, status) {
        switch (status) {
          case AdminHomeStatus.loading:
            return _renderLoadingScreen();
          default:
            return _renderListCategoriesSuccess(context);
        }
      },
    );
  }

  Widget _renderLoadingScreen() {
    return Assets.jsons.syncData.lottie(width: AppSize.s300);
  }

  Widget _renderListCategoriesSuccess(BuildContext context) {
    return BlocBuilder<AdminHomeBloc, AdminHomeState>(
      buildWhen: (previous, current) =>
          previous.listCategories != current.listCategories,
      builder: (context, state) {
        return Container(
          height: MediaQuery.of(context).size.height - AppSize.s200,
          padding: const EdgeInsets.only(
              left: AppPadding.p15, right: AppPadding.p15, top: AppPadding.p10),
          child: isNullOrEmpty(state.listCategories)
              ? _renderEmptyCategories(context)
              : GridView.builder(
                  padding: const EdgeInsets.symmetric(
                      vertical: AppPadding.p10, horizontal: AppPadding.p10),
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: AppPadding.p10,
                      crossAxisSpacing: AppPadding.p10),
                  itemBuilder: (context, index) => _renderCategoryButton(
                    context,
                    category: state.listCategories[index],
                  ),
                  itemCount: state.listCategories.length,
                ),
        );
      },
    );
  }

  Widget _renderCategoryButton(
    BuildContext context, {
    required MCategory category,
  }) {
    return Material(
      borderRadius: BorderRadius.circular(AppRadius.r10),
      elevation: AppElevation.ev1,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () => context
            .read<AdminHomeBloc>()
            .onTappedCategoryButton(context, category: category),
        radius: AppRadius.r20,
        child: Ink(
          height: AppSize.s123,
          decoration: BoxDecoration(
            color: AppColors.grey8,
            borderRadius: BorderRadius.circular(AppRadius.r10),
            border: Border.all(color: AppColors.grey6, width: AppSize.s0_5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.memory(
                (category.image ?? []).convertToUint8List(),
                height: AppSize.s60,
                width: AppSize.s60,
              ),
              XPaddingUtils.verticalPadding(height: AppPadding.p10),
              Text(
                category.name.capitalizeEachText(),
                style: AppTextStyle.contentTexStyleBold.copyWith(
                  color: AppColors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderEmptyCategories(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.svg.emptyData.svg(
              fit: BoxFit.contain, width: MediaQuery.of(context).size.width),
          Text(
            S.of(context).noCreatedCategory,
            style: AppTextStyle.titleTextStyle,
          )
        ],
      ),
    );
  }
}
