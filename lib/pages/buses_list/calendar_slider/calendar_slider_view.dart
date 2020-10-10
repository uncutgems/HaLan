import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halan/base/tool.dart';
import 'package:halan/pages/buses_list/calendar_slider/calendar_slider_bloc.dart';

class CalendarSlider extends StatefulWidget {
  @override
  _CalendarSliderState createState() => _CalendarSliderState();
}

class _CalendarSliderState extends State<CalendarSlider> {
  final CalendarSliderBloc bloc = CalendarSliderBloc();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarSliderBloc, CalendarSliderState>(
      cubit: bloc,
      builder: (BuildContext context, CalendarSliderState state) {
        if (state is CalendarSliderInitial) {
          return _body(context);
        } else
          return Container();
      },
    );
  }
}

Widget _body(BuildContext context) {
  final List<DateTime> dates = List<DateTime>.generate(
      60,
      (int i) => DateTime.utc(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ).add(Duration(days: i)));
  return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        final DateTime date = dates[index];
        return _calendarItem(context, date);
      },
      separatorBuilder: (BuildContext context, int index) =>
          Container(width: 32),
      itemCount: dates.length);
}

Widget _calendarItem(BuildContext context, DateTime date) {
  return FlatButton(
    child: Text(convertTime('dd/mm', date.millisecondsSinceEpoch, true)),
    onPressed: () {

    },
  );
}

//HorizontalCalendar(
//height: 42,
//padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
//selectedDecoration: BoxDecoration(
//color: HaLanColor.primaryColor,
//borderRadius: BorderRadius.circular(8),
//),
//selectedDateTextStyle: textTheme.bodyText2.copyWith(
//fontSize: 12, color: HaLanColor.white, fontWeight: FontWeight.w600),
//dateTextStyle: textTheme.bodyText2.copyWith(
//fontSize: 12, color: HaLanColor.gray80, fontWeight: FontWeight.w600),
//firstDate: DateTime.now(),
//lastDate: DateTime(2025),
//dateFormat: 'dd/MM',
//initialSelectedDates: <DateTime>[DateTime.now()],
//pressCalender: true,
//contentPadding: const EdgeInsets.all(4),
//spacingBetweenDates: 35,
//onDateSelected: (DateTime date) {
//
//},
//
//);
