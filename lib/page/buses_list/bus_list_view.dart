import 'package:avwidget/popup_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/constant.dart';
import 'package:halan/base/routes.dart';
import 'package:halan/base/styles.dart';
import 'package:halan/base/tools.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/page/buses_list/bus_list_bloc.dart';

class BusesListWidget extends StatefulWidget {
  const BusesListWidget(
      {Key key, this.onStart, this.onStop, this.startPoint, this.endPoint})
      : super(key: key);
  final VoidCallback onStart;
  final VoidCallback onStop;
  final Point startPoint;
  final Point endPoint;

  @override
  _BusesListWidgetState createState() => _BusesListWidgetState();
}

class _BusesListWidgetState extends State<BusesListWidget> {
  BusListBloc bloc;
  ScrollController tripController;

  @override
  void initState() {
    bloc = BlocProvider.of<BusListBloc>(context);
//    tripController = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusListBloc, BusListState>(
      cubit: bloc,
      builder: (BuildContext context, BusListState state) {
        if (state is SuccessGetDataBusListState) {
          if (state.page == -1) {
            widget.onStart();
            return _body(context, state);
          } else {
            widget.onStop();
            return _body(context, state);
          }
        } else if (state is FailGetDataBusListState) {
          return Scaffold(
            body: Text(state.error),
          );
        } else
          return Container();
      },
      buildWhen: (BusListState prev, BusListState current) {
        if (current is ShowLoadingGetDataBusListState) {
          widget.onStart();
          showLoading(context);
          return false;
        } else if (current is TurnOffLoadingGetDataBusListState) {
          widget.onStop();
          Navigator.pop(context);
          return false;
        } else
          return true;
      },
    );
  }

  Widget _body(BuildContext context, SuccessGetDataBusListState state) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: Column(children: <Widget>[
        if (state.listTrip.isNotEmpty)
          Expanded(
            child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  final Trip trip = state.listTrip[index];
                  return _cardItem(context, trip, state);
                },
                separatorBuilder: (BuildContext context, int index) =>
                    Container(
                      height: 8,
                    ),
                itemCount: state.listTrip.length),
          )
        else if (state.listTrip.isEmpty && state.page != -1)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset('assets/no_trip.png'),
                  Text(
                    'Hiện không có chuyến nào ở tuyến đường này! \n Vui lòng chọn tuyến đường hoặc ngày khác',
                    style: textTheme.bodyText1
                        .copyWith(fontWeight: FontWeight.w600, fontSize: 14),
                  )
                ],
              ),
            ),
          ),
        if (state.page == -1)
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
                child: CircularProgressIndicator(
              backgroundColor: HaLanColor.primaryColor,
              valueColor: AlwaysStoppedAnimation<Color>(HaLanColor.white),
            )),
          ),
      ]),
    );
  }

  Widget _cardItem(
      BuildContext context, Trip trip, SuccessGetDataBusListState state) {
    final int startTime =
        convertNewDayStyleToMillisecond(trip.date) + trip.startTimeReality;
    final bool passStartTime =
        DateTime.now().millisecondsSinceEpoch > startTime;
    final bool outOfSeat = trip.totalEmptySeat == 0;

    return GestureDetector(
      onTap: () {
        if (outOfSeat == false && passStartTime == false) {
          Navigator.pushNamed(context, RoutesName.ticketConfirmPage,
              arguments: <String, dynamic>{
                Constant.trip: trip,
                Constant.startPoint: widget.startPoint,
                Constant.endPoint: widget.endPoint
              });
        }
      },
      child: Stack(children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            height: 113,
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
                              convertTime('HH:mm', trip.startTimeReality, true),
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
                              convertTime('HH:mm',
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
                      left: 16.0, right: 16, top: 8, bottom: 8),
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
                        currencyFormat(trip.price.toInt(), 'Đ'),
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
        ),
        if (outOfSeat == true || passStartTime == true)
          Positioned(
            child: Container(
              child: Center(
                child: Text(
                  passStartTime == true
                      ? 'CHUYẾN ĐÃ KHỞI HÀNH'
                      : 'ĐÃ HẾT GHẾ TRỐNG',
                  style: textTheme.subtitle1.copyWith(
                      color: HaLanColor.white, fontWeight: FontWeight.w600),
                ),
              ),
              height: 113,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: HaLanColor.gray80.withOpacity(0.8)),
            ),
            left: 16,
            right: 16,
          ),
      ]),
    );
  }

  void showLoading(BuildContext context) {
    showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) => const AVLoadingWidget(
              color: HaLanColor.white,
            ));
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      if (notification.metrics.pixels >
          notification.metrics.maxScrollExtent * 0.9) {
        bloc.add(LoadMoreBusListEvent());
      }
    }
    return false;
  }
}
