import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/page/buses_list/bus_list_bloc.dart';
import 'package:halan/page/buses_list/bus_list_view.dart';
import 'package:halan/page/buses_list/calendar_slider/calendar_slider_bloc.dart';
import 'package:halan/page/buses_list/calendar_slider/calendar_slider_view.dart';
import 'package:halan/page/buses_list/filter/trip_filter_view.dart';

class BusesListPage extends StatefulWidget {
  const BusesListPage(
      {Key key,
      @required this.startPoint,
      @required this.endPoint,
      @required this.date})
      : super(key: key);

  final Point startPoint;
  final Point endPoint;
  final DateTime date;

  @override
  _BusesListPageState createState() => _BusesListPageState();
}

class _BusesListPageState extends State<BusesListPage> {
  final BusListBloc busListBloc = BusListBloc();
  final CalendarSliderBloc calendarSliderBloc = CalendarSliderBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('${widget.startPoint.name} - ${widget.endPoint.name}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          BlocProvider<CalendarSliderBloc>(
            create: (BuildContext context) => calendarSliderBloc,
            child: CalendarSlider(
              firstDate: widget.date,
              selectedDate: (DateTime date) {
                busListBloc.add(GetDataBusListEvent(
                    startPoint: widget.startPoint.id,
                    endPoint: widget.endPoint.id,
                    date: date));
              },
            ),
          ),
          TripFilterWidget(
            onTimePeriod: (List<int> timePeriod) {
              busListBloc.add(SortTimePeriodBusListEvent(
                  timePeriod.first, timePeriod.last));
            },
            onSort: (List<bool> sortType) {
              busListBloc.add(SortListGetDataBusListEvent(sortType));
            },
          ),
          Expanded(
            child: BlocProvider<BusListBloc>(
                create: (BuildContext context) => busListBloc,
                child: BusesListWidget(
                  endPoint: widget.endPoint,
                  startPoint: widget.startPoint,
                  onStart: () {
                    calendarSliderBloc.add(DisableCalendarSliderEvent(true));
                  },
                  onStop: () {
                    calendarSliderBloc.add(DisableCalendarSliderEvent(false));
                  },
                )),
          ),
        ],
      ),
    );
  }
}
