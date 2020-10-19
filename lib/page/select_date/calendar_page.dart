import 'package:avwidget/avwidget.dart';
import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/size.dart';
import 'package:halan/base/tool.dart';
import 'package:halan/page/select_date/calendar_bloc.dart';
import 'package:halan/page/select_date/date_helper.dart';
import 'package:halan/page/select_date/horizontal_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key key, this.chosenDate}) : super(key: key);
  final DateTime chosenDate;
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarBloc bloc = CalendarBloc();
  DateTime dateOfMonth = DateTime.now();
  DateTime datePickedComparable;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(
      cubit: bloc,
      builder: (BuildContext context, CalendarState state) {
        if (state is CalendarInitial) {
          dateOfMonth = state.dateTime;
          datePickedComparable=widget.chosenDate;
          print(dateOfMonth.month);
          return mainScreen(context);
        }
        else if (state is CalendarStateShowPickedDate) {
          datePickedComparable = state.pickedDate;
          print(datePickedComparable.day);
          return mainScreen(context);
        }
        return Container();
      },
    );
  }

  Widget mainScreen(BuildContext context) {
    print('sssss ${convertSolar2Lunar(7, 10, 2020, 7).day}');
    return Scaffold(
      backgroundColor: AVColor.halanBackground,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Chọn ngày khởi hành', style: TextStyle(
            fontSize: AppSize.getFontSize(context, 18),
            color: AVColor.gray100),),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AVColor.gray100,),
          onPressed: () {
            if(datePickedComparable!=null) {
              Navigator.pop(context,datePickedComparable);
            }
            else{
              Navigator.pop(context,DateTime.now());
            }
          },),
        backgroundColor: AVColor.halanBackground,
      ),
      body: Column(
        children: <Widget>[
          HorizontalCalendar(
            pressCalender: true,
            initialSelectedDates: <DateTime>[DateTime.now()],
            spacingBetweenDates: AppSize.getWidth(context, 20),
            onDateSelected: (DateTime date) {
//              print(date.month);
              bloc.add(CalendarEventClickMonth(date));
            },
            height: AppSize.getHeight(context, 40),
            padding: const EdgeInsets.all(0),
            labelOrder: const <LabelType>[LabelType.month],
            weekDayFormat: 'EEEE',
            dateFormat: 'MM',
            monthFormat: 'MMMM (yyyy)',
            dateTextStyle: Theme
                .of(context)
                .textTheme
                .bodyText2
                .copyWith(color: AVColor.white,
                fontSize: AppSize.getFontSize(context, 12)),
            weekDayTextStyle: Theme
                .of(context)
                .textTheme
                .bodyText2
                .copyWith(color: AVColor.white,
                fontSize: AppSize.getFontSize(context, 12)),
            monthTextStyle: Theme
                .of(context)
                .textTheme
                .bodyText2
                .copyWith(color: AVColor.orange100,
                fontSize: AppSize.getFontSize(context, 16)),
            firstDate: DateTime.utc(2020, DateTime.september, 1),
            lastDate: DateTime.now().add(const Duration(days: 365)),
          ),
          Container(height: AppSize.getWidth(context, 17),),
//          Container(height: AppSize.getWidth(context, 1),width: MediaQuery.of(context).size.width,color: HaLanColor.borderColor,),
          Expanded(child: calendar(context)),
        ],
      ),
//      bottomNavigationBar:const CommonBottomNavigationBar(),
    );
  }

  Widget calendar(BuildContext context) {
    return GridView.count(
      crossAxisCount: 7, children: dateWidget(context, dateOfMonth),
      mainAxisSpacing: AppSize.getWidth(context, 4),
    );
  }

  List<Widget> dateWidget(BuildContext context, DateTime date) {
    final DateUtil dateUtil = DateUtil();
    final int days = dateUtil.daysInMonth(date.month, date.year) as int;
    final List<Widget> daysWidget = <Widget>[];
    for (int i = 1; i <= days; i++) {
      daysWidget.add(
          Column(
            children: <Widget>[
              Container(height: AppSize.getWidth(context, 1),width: MediaQuery.of(context).size.width,color: HaLanColor.borderColor,),
              Container(height: AppSize.getWidth(context, 10),),
              GestureDetector(
                onTap: () {
                  bloc.add(CalendarEventClickDay(
                      DateTime.utc(date.year, date.month, i)));
                  print(i);
                },
                child: Container(
                  height: AppSize.getWidth(context, 40),
                  width: AppSize.getWidth(context, 40),
//                  margin: EdgeInsets.all(AppSize.getWidth(context, 4)),
                  decoration: datePickedComparable != null &&
                      datePickedComparable.day == i ? BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: HaLanColor.primaryColor,
                  ) : null,
                  child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            '$i', style: Theme
                              .of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(fontSize: AppSize.getFontSize(context, 16),
                              fontWeight: FontWeight.w600,
                              color: datePickedComparable!=null && datePickedComparable.day==i?HaLanColor.white:AVColor.gray100
                              ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child:  Text(
                            i==1?convertTime('dd/MM',convertSolar2Lunar(i,date.month,date.year, 7).millisecondsSinceEpoch,false):'${convertSolar2Lunar(i,date.month,date.year, 7).day}', style: Theme
                              .of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(fontSize: AppSize.getFontSize(context, 12),
                              fontWeight: FontWeight.w600,
                              color:datePickedComparable!=null && datePickedComparable.day==i?HaLanColor.white: HaLanColor.primaryColor),
                          ),
                        ),
                      ]
                  ),
                ),
              ),
            ],
          )
      );
    }
    return daysWidget;
  }
}
