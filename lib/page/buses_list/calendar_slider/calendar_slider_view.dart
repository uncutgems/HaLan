import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/styles.dart';
import 'package:halan/base/tool.dart';
import 'package:halan/page/buses_list/calendar_slider/calendar_slider_bloc.dart';

class CalendarSlider extends StatefulWidget {
  const CalendarSlider({Key key, @required this.selectedDate}) : super(key: key);
  final ValueChanged<DateTime> selectedDate;

  @override
  _CalendarSliderState createState() => _CalendarSliderState();
}

class _CalendarSliderState extends State<CalendarSlider> {
   CalendarSliderBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<CalendarSliderBloc>(context);
    bloc.add(ChoosingDateCalendarSliderEvent(DateTime.now()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarSliderBloc, CalendarSliderState>(
      cubit: bloc,
      builder: (BuildContext context, CalendarSliderState state) {
        if (state is CalendarSliderInitial) {
          return _body(context, state);
        } else
          return Container();
      },
      buildWhen: (CalendarSliderState prev, CalendarSliderState current) {
        if (current is CallBackCalendarSliderState) {
          print('vao day');
          widget.selectedDate(current.date);
          return false;
        } else
          return true;
      },
    );
  }

  Widget _body(BuildContext context, CalendarSliderInitial state) {
    final List<DateTime> dates = List<DateTime>.generate(
        60,
        (int i) => DateTime.utc(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
            ).add(Duration(days: i)));
    return AbsorbPointer(
      absorbing: state.disableValue,
      child: Container(
        height: 36,
        child: ListView.separated(
          padding: const EdgeInsets.only(left: 24, top: 4, bottom: 8),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            final DateTime date = dates[index];
            return _calendarItem(context, date, state);
          },
          separatorBuilder: (BuildContext context, int index) =>
              Container(width: 40),
          itemCount: dates.length,
        ),
      ),
    );
  }

  Widget _calendarItem(
      BuildContext context, DateTime date, CalendarSliderInitial state) {
    final bool isSelected =
        state.date.day == date.day;
    return GestureDetector(
      onTap: () {
        bloc.add(ChoosingDateCalendarSliderEvent(date));
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250 ),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color:
              isSelected ? HaLanColor.primaryColor : HaLanColor.backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          convertTime('dd/MM', date.millisecondsSinceEpoch, true),
          style: textTheme.subtitle2.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              height: 5 / 3,
              color: isSelected ? HaLanColor.white : HaLanColor.textColor),
        ),
      ),
    );
  }
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
