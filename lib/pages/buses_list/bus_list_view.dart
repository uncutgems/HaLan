import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/styles.dart';
import 'package:halan/base/tools.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/pages/buses_list/bus_list_bloc.dart';
import 'package:halan/pages/buses_list/calendar_slider/calendar_slider_view.dart';

class BusesListPage extends StatefulWidget {
  @override
  _BusesListPageState createState() => _BusesListPageState();
}

class _BusesListPageState extends State<BusesListPage> {
  final BusListBloc bloc = BusListBloc();

  @override
  void initState() {
    bloc.add(GetDataBusListEvent(
        'P0FT1t0lhczZM64',
        'P0FZ1t36daLrKDR',
        int.parse(convertTime(
            'yyyyMMdd', DateTime.now().millisecondsSinceEpoch, false))));
    super.initState();
  }

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
      body: ListView(
        children: <Widget>[
          CalendarSlider(),
          Row(
            children: <Widget>[
              FlatButton(
                child: Row(
                  children: <Widget>[
                    Text(
                      'Thời gian khởi hành',
                      style: textTheme.bodyText2
                          .copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                    const Icon(Icons.arrow_upward, size: 16,)
                  ],
                ),
                onPressed: () {
                  print('thời gian');
                },
              ),
              FlatButton(
                child: Row(
                  children: <Widget>[
                    Text('Giá vé',
                        style: textTheme.bodyText2.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w400)),
                    const Icon(
                      Icons.arrow_upward, size: 16,
                    )
                  ],
                ),
                onPressed: () {
                  print('giá vé');
                },
              ),
              Expanded(child: Container()),
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () {
                  print('filter page');
                },
              ),
            ],
          ),
          BlocBuilder<BusListBloc, BusListState>(
            cubit: bloc,
            builder: (BuildContext context, BusListState state) {
              if (state is SuccessGetDataBusListState) {
                return _body(context, state);
              } else if (state is FailGetDataBusListState) {
                return Container(
                  child: Text(state.error),
                );
              } else
                return Container();
            },
          ),
        ],
      ),
    );
  }

  Widget _body(BuildContext context, SuccessGetDataBusListState state) {
    return Column(
      children: <Widget>[
        ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              final Trip trip = state.listTrip[index];
              return _cardItem(context, trip);
            },
            separatorBuilder: (BuildContext context, int index) => Container(
                  height: 8,
                ),
            itemCount: state.listTrip.length)
      ],
    );
  }

  Widget _cardItem(BuildContext context, Trip trip) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
//      padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: HaLanColor.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, left: 16, right: 16, bottom: 4),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 54,
                        child: Text(
                          convertTime('hh:mm', trip.startTimeReality, true),
                          style: textTheme.subtitle1.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              height: 1.5),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_upward,
                        size: 16,
                        color: HaLanColor.blue,
                      ),
                      Text(
                        trip.pointUp.name,
                        style: textTheme.bodyText2
                            .copyWith(fontSize: 12, height: 5 / 3),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 54,
                        child: Text(
                          convertTime('hh:mm',
                              trip.startTimeReality + trip.runTime, true),
                          style: textTheme.subtitle1.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              height: 1.5),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_downward,
                        size: 16,
                        color: HaLanColor.red100,
                      ),
                      Text(
                        trip.pointDown.name,
                        style: textTheme.bodyText2
                            .copyWith(fontSize: 12, height: 5 / 3),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              color: HaLanColor.gray30,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16, top: 4, bottom: 8),
              child: Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(trip.seatMap.seatMapName,
                          style: textTheme.bodyText2
                              .copyWith(fontSize: 12, height: 4 / 3)),
                      Text(
                        '${trip.totalEmptySeat}/${trip.totalSeat} ghế trống',
                        style: textTheme.bodyText2.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            height: 4 / 3),
                      )
                    ],
                  ),
                  Expanded(child: Container()),
                  Text(
                    trip.price.toInt().toString(),
                    style: textTheme.headline6.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: HaLanColor.primaryColor,
                        height: 11 / 9),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
