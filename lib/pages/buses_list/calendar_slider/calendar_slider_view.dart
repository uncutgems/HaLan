import 'package:flutter/material.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/styles.dart';
import 'package:halan/pages/widget/calendar/horizontal_calendar.dart';

class CalendarSlider extends StatefulWidget {
  @override
  _CalendarSliderState createState() => _CalendarSliderState();
}

class _CalendarSliderState extends State<CalendarSlider> {
  @override
  Widget build(BuildContext context) {
    return HorizontalCalendar(
      height: 42,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      selectedDecoration: BoxDecoration(
        color: AppColor.primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      selectedDateTextStyle: textTheme.bodyText2.copyWith(
          fontSize: 12, color: AppColor.white, fontWeight: FontWeight.w600),
      dateTextStyle: textTheme.bodyText2.copyWith(
          fontSize: 12, color: AppColor.gray80, fontWeight: FontWeight.w600),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
      dateFormat: 'dd/MM',
      initialSelectedDates: <DateTime>[DateTime.now()],
      pressCalender: true,
      contentPadding: EdgeInsets.all(4),
      spacingBetweenDates: 35,

    );
  }
}
