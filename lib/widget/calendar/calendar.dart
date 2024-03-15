import 'package:flutter/material.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/decorations.dart';
import 'package:i2hand/src/theme/styles.dart';
import 'package:i2hand/src/theme/value.dart';
import 'package:table_calendar/table_calendar.dart';

class XCalendar extends StatefulWidget {
  const XCalendar({
    super.key,
    required this.selectedDate,
    required this.onTappedDate,
    required this.collapseCalendar,
  });
  final DateTime selectedDate;
  final Function(DateTime) onTappedDate;
  final Function collapseCalendar;

  @override
  State<XCalendar> createState() => _XCalendarState();
}

class _XCalendarState extends State<XCalendar> {
  final double _dayCellHeight = AppSize.s36;
  final double _dayOfWeekHeight = AppSize.s0;
  late DateTime _selectedDay;
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = widget.selectedDate;
    _focusedDay = widget.selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          width: double.infinity,
          margin: const EdgeInsets.only(
            left: AppMargin.m20,
            right: AppMargin.m20,
            bottom: AppMargin.m16,
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(
              AppRadius.r16,
            ),
            boxShadow: AppDecorations.fullShadow(),
          ),
          child: _renderTableSection(context),
        ),
        Positioned(
          bottom: 0,
          child: _renderCollapseButton(context),
        )
      ],
    );
  }

  Widget _renderTableSection(BuildContext context) {
    return TableCalendar(
      focusedDay: _focusedDay,
      currentDay: _selectedDay,
      firstDay: DateTime(2024, 1, 1),
      lastDay: DateTime(2024, 6, 6),
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        widget.onTappedDate(selectedDay);
      },
      daysOfWeekVisible: false,
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
      rowHeight: _dayCellHeight,
      daysOfWeekHeight: _dayOfWeekHeight,
      headerStyle: _formatHeaderStyle(),
      calendarStyle: _formatCalendarStyle(),
    );
  }

  CalendarStyle _formatCalendarStyle() {
    return CalendarStyle(
      tablePadding: const EdgeInsets.only(
        left: AppPadding.p10,
        right: AppPadding.p10,
        bottom: AppPadding.p10,
      ),
      isTodayHighlighted: false,
      cellMargin: const EdgeInsets.symmetric(
        vertical: AppMargin.m4,
        horizontal: AppMargin.m2,
      ),
      selectedTextStyle: AppTextStyle.titleTextStyle.copyWith(
        fontSize: AppFontSize.f15,
        color: AppColors.primary,
      ),
      todayTextStyle: AppTextStyle.titleTextStyle.copyWith(
        fontSize: AppFontSize.f15,
        color: AppColors.primary,
      ),
      defaultTextStyle: AppTextStyle.titleTextStyle.copyWith(
        fontSize: AppFontSize.f15,
        color: AppColors.black,
      ),
      weekendTextStyle: AppTextStyle.titleTextStyle.copyWith(
        fontSize: AppFontSize.f15,
        color: AppColors.black,
      ),
      todayDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.r30),
        color: AppColors.backgroundButton,
      ),
      selectedDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.r30),
        color: AppColors.backgroundButton,
      ),
      defaultDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.r30),
        color: AppColors.grey8,
      ),
      weekendDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.r30),
        color: AppColors.grey8,
      ),
    );
  }

  HeaderStyle _formatHeaderStyle() {
    return HeaderStyle(
      titleCentered: true,
      leftChevronIcon: const CircleAvatar(
        radius: AppRadius.r16,
        backgroundColor: AppColors.backgroundButton,
        child: Icon(Icons.chevron_left_rounded, color: AppColors.primary),
      ),
      rightChevronIcon: const CircleAvatar(
        radius: AppRadius.r16,
        backgroundColor: AppColors.backgroundButton,
        child: Icon(Icons.chevron_right_rounded, color: AppColors.primary),
      ),
      titleTextStyle:
          AppTextStyle.labelStyle.copyWith(color: AppColors.primary),
    );
  }

  Widget _renderCollapseButton(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.collapseCalendar(),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.r30),
          boxShadow: AppDecorations.shadowTwo,
        ),
        child: const CircleAvatar(
          radius: AppRadius.r16,
          backgroundColor: AppColors.white,
          child: Icon(
            Icons.keyboard_arrow_up_rounded,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
