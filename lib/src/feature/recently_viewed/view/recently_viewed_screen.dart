import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i2hand/src/feature/recently_viewed/logic/recently_viewed_bloc.dart';
import 'package:i2hand/src/feature/recently_viewed/logic/recently_viewed_state.dart';
import 'package:i2hand/src/localization/localization_utils.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:i2hand/src/utils/padding_utils.dart';
import 'package:i2hand/widget/appbar/app_bar.dart';
import 'package:i2hand/widget/calendar/calendar.dart';
import 'package:i2hand/widget/card/product_card_large_size.dart';
import 'package:i2hand/widget/chip/selected_chip.dart';
import 'package:table_calendar/table_calendar.dart';

class RecentlyViewedScreen extends StatefulWidget {
  const RecentlyViewedScreen({super.key});

  @override
  State<RecentlyViewedScreen> createState() => _RecentlyViewedScreenState();
}

class _RecentlyViewedScreenState extends State<RecentlyViewedScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RecentlyViewedBloc>().inital(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _renderAppBar(context),
              _renderselectDateSection(context),
              _renderListProduct(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderAppBar(BuildContext context) {
    return XAppBar(
      titlePage: S.of(context).recentlyViewed,
    );
  }

  Widget _renderselectDateSection(BuildContext context) {
    return BlocBuilder<RecentlyViewedBloc, RecentlyViewedState>(
      buildWhen: (previous, current) =>
          previous.isExpanded != current.isExpanded ||
          previous.selectedDate != current.selectedDate,
      builder: (context, state) {
        return AnimatedCrossFade(
          firstChild: _renderSelectDate(context),
          secondChild:
              _renderCalendar(context, selectedDate: state.selectedDate),
          crossFadeState: state.isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 1000),
        );
      },
    );
  }

  Widget _renderSelectDate(BuildContext context) {
    return BlocBuilder<RecentlyViewedBloc, RecentlyViewedState>(
      buildWhen: (previous, current) =>
          previous.selectedDate != current.selectedDate,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
          child: Row(
            children: [
              Expanded(
                child: XSelectedChip(
                  title: S.of(context).today,
                  isSelected: isSameDay(
                    state.selectedDate,
                    DateTime.now(),
                  ),
                  onTap: () => context
                      .read<RecentlyViewedBloc>()
                      .onChangedSelectedDate(DateTime.now()),
                ),
              ),
              XPaddingUtils.horizontalPadding(width: AppPadding.p6),
              Expanded(
                child: XSelectedChip(
                  title:
                      context.read<RecentlyViewedBloc>().getDateText(context),
                  isSelected:
                      context.read<RecentlyViewedBloc>().isSelectedDate(),
                  onTap: () =>
                      context.read<RecentlyViewedBloc>().onChangedSelectedDate(
                            DateTime.now().subtract(const Duration(days: 1)),
                          ),
                ),
              ),
              XPaddingUtils.horizontalPadding(width: AppPadding.p7),
              _renderExpandCalendarSection(context),
            ],
          ),
        );
      },
    );
  }

  Widget _renderExpandCalendarSection(BuildContext context) {
    return IconButton.filled(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.primary)),
      onPressed: () =>
          context.read<RecentlyViewedBloc>().showExpandedCalendar(true),
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: AppColors.white,
      ),
    );
  }

  Widget _renderCalendar(BuildContext context,
      {required DateTime selectedDate}) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p4),
      child: XCalendar(
        selectedDate: selectedDate,
        onTappedDate: (date) =>
            context.read<RecentlyViewedBloc>().onChangedSelectedDate(date),
        collapseCalendar: () =>
            context.read<RecentlyViewedBloc>().showExpandedCalendar(false),
      ),
    );
  }

  Widget _renderListProduct(BuildContext context) {
    return BlocBuilder<RecentlyViewedBloc, RecentlyViewedState>(
      buildWhen: (previous, current) =>
          !listEquals(previous.listProducts, current.listProducts),
      builder: (context, state) {
        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p20,
            vertical: AppPadding.p20,
          ),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: AppPadding.p5,
            crossAxisSpacing: AppPadding.p20,
            childAspectRatio: 10 / 17,
          ),
          itemBuilder: (context, index) => XProductCardLarge(
            product: state.listProducts[index],
          ),
          itemCount: state.listProducts.length,
        );
      },
    );
  }
}
