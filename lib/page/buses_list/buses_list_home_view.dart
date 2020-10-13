import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halan/page/buses_list/bus_list_bloc.dart';
import 'package:halan/page/buses_list/bus_list_view.dart';
import 'package:halan/page/buses_list/calendar_slider/calendar_slider_bloc.dart';
import 'package:halan/page/buses_list/calendar_slider/calendar_slider_view.dart';
import 'package:halan/page/buses_list/filter/trip_filter_view.dart';

class BusesListPage extends StatefulWidget {
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
        title: const Text('abc'),
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
              selectedDate: (DateTime date) {
                busListBloc.add(GetDataBusListEvent(
                    'P0FT1t0lhczZM64', 'P0FZ1t36daLrKDR', date, 0));
              },
            ),
          ),
          TripFilterWidget(
            onSort: (List<bool> sortType) {
              busListBloc.add(SortListGetDataBusListEvent(sortType));
            },
          ),
          Expanded(
            child: BlocProvider<BusListBloc>(
                create: (BuildContext context) => busListBloc,
                child: BusesListWidget(
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
