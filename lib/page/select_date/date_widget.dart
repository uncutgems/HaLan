import 'package:avwidget/avwidget.dart';
import 'package:flutter/material.dart';
import 'package:halan/base/size.dart';
import 'package:intl/intl.dart';

import 'date_helper.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({
    Key key,
    @required this.date,
    this.onTap,
    this.onLongTap,
    this.isSelected = false,
    this.isDisabled = false,
    this.monthTextStyle,
    this.selectedMonthTextStyle,
    this.monthFormat,
    this.dateTextStyle,
    this.selectedDateTextStyle,
    this.dateFormat,
    this.weekDayTextStyle,
    this.selectedWeekDayTextStyle,
    this.weekDayFormat,
    this.defaultDecoration,
    this.selectedDecoration = const BoxDecoration(color: Colors.cyan),
    this.disabledDecoration = const BoxDecoration(color: Colors.grey),
    this.padding,
    this.labelOrder,
  }) : super(key: key);

  String get defaultDateFormat => 'dd';

  String get defaultMonthFormat => 'MMM';

  String get defaultWeekDayFormat => 'EEE';

  final DateTime date;
  final TextStyle monthTextStyle;
  final TextStyle selectedMonthTextStyle;
  final String monthFormat;
  final TextStyle dateTextStyle;
  final TextStyle selectedDateTextStyle;
  final String dateFormat;
  final TextStyle weekDayTextStyle;
  final TextStyle selectedWeekDayTextStyle;
  final String weekDayFormat;
  final VoidCallback onTap;
  final VoidCallback onLongTap;
  final Decoration defaultDecoration;
  final Decoration selectedDecoration;
  final Decoration disabledDecoration;
  final bool isSelected;
  final bool isDisabled;
  final EdgeInsetsGeometry padding;
  final List<LabelType> labelOrder;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.headline6;
    final TextStyle subtextStyle = Theme.of(context).textTheme.subtitle2;

    final TextStyle monthStyle =
        isSelected ? selectedMonthTextStyle ?? monthTextStyle ?? subtextStyle : monthTextStyle ?? subtextStyle;
    final TextStyle dateStyle =
        isSelected ? selectedDateTextStyle ?? dateTextStyle ?? textStyle : dateTextStyle ?? textStyle;
    final TextStyle dayStyle =
        isSelected ? selectedWeekDayTextStyle ?? weekDayTextStyle ?? subtextStyle : weekDayTextStyle ?? subtextStyle;
//    if(date.day>DateTime.now().day+2){
//      dateStyle=dateTextStyle.copyWith(color: HalanColor.disableColor);
//      dayStyle=weekDayTextStyle.copyWith(color: HalanColor.disableColor);
//    }
    bool today = false;
    if (date.day == DateTime.now().day) {
      today = true;
    }
    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      onLongPress: isDisabled ? null : onLongTap,
      child: Container(
        decoration: isSelected ? selectedDecoration : isDisabled ? disabledDecoration : defaultDecoration,
        child: Padding(
          padding: padding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ...labelOrder.map((LabelType type) {
                Text text;
                switch (type) {
                  case LabelType.date:
                    text = Text(
                      DateFormat(dateFormat ?? defaultDateFormat).format(date),
                      style: dateStyle,
                    );
                    break;
                  case LabelType.month:
                    String  monthText = DateFormat(monthFormat ?? defaultMonthFormat,'vi').format(date);
                     monthText = monthText.substring(1,monthText.length);
                     monthText = 'T'+monthText;
                    text = Text(
                      monthText, style: date.month<DateTime.now().month&&date.millisecondsSinceEpoch<DateTime.now().millisecondsSinceEpoch?Theme
                        .of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(color: AVColor.gray100,fontSize: AppSize.getFontSize(context, 16)) :monthStyle,
                    );
                    break;

                  case LabelType.weekday:
                    text = Text(
                      today ? 'H??m nay' : DateFormat(weekDayFormat ?? defaultWeekDayFormat, 'vi').format(date),
                      style: dayStyle,
                    );
                    break;
                }
                return text;
              }).toList(growable: false)
            ],
          ),
        ),
      ),
    );
  }
}
