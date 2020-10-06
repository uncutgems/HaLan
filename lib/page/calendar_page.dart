import 'package:avwidget/avwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halan/base/size.dart';
import 'package:halan/page/calendar_bloc.dart';
import 'package:halan/page/select_date/date_helper.dart';
import 'package:halan/page/select_date/horizontal_calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarBloc bloc = CalendarBloc();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc,CalendarState>(
      cubit: bloc,
      builder: (BuildContext context, CalendarState state){
        if(state is CalendarInitial){
          return mainScreen(context);
        }
        return Container();
      },
    );
  }
  Widget mainScreen(BuildContext context){
    return Scaffold(
      backgroundColor: AVColor.halanBackground,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Chọn ngày khởi hành',style: TextStyle(fontSize:AppSize.getFontSize(context, 16),color: AVColor.gray100 ),),
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back,color: AVColor.gray100,),onPressed: (){
          Navigator.pop(context);
        },),
        backgroundColor: AVColor.halanBackground,
      ),
      body: HorizontalCalendar(
        pressCalender: true,
        initialSelectedDates: <DateTime>[DateTime.now()],
        spacingBetweenDates: AppSize.getWidth(context, 20),
        onDateSelected: (DateTime date) {
          print(date.month);
        },
        height:  AppSize.getHeight(context, 40),
        padding: const EdgeInsets.all(0),
        labelOrder: const <LabelType>[LabelType.month],
        weekDayFormat: 'EEEE',
        dateFormat: 'MM',
        monthFormat: 'MMMM (yyyy)',

        dateTextStyle: Theme
            .of(context)
            .textTheme
            .bodyText2
            .copyWith(color: AVColor.white,fontSize: AppSize.getFontSize(context, 12)),
        weekDayTextStyle: Theme
            .of(context)
            .textTheme
            .bodyText2
            .copyWith(color: AVColor.white,fontSize: AppSize.getFontSize(context, 12)),
        monthTextStyle:Theme
            .of(context)
            .textTheme
            .bodyText2
            .copyWith(color: AVColor.orange100,fontSize: AppSize.getFontSize(context, 20)),
        firstDate: DateTime.utc(2020,DateTime.september,1),
        lastDate: DateTime.now().add(const Duration(days: 365)),
      ),
    );
  }
}
