import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/constant.dart';
import 'package:halan/base/routes.dart';
import 'package:halan/base/styles.dart';
import 'package:halan/base/tools.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/page/buses_list/bus_list_item/bus_list_item_bloc.dart';
import 'package:halan/widget/sizing_widget.dart';

class BusListItemWidget extends StatefulWidget {
  const BusListItemWidget({Key key, this.trip}) : super(key: key);

  final Trip trip;
//  final ValueChanged<Size> sizeItem;

  @override
  _BusListItemWidgetState createState() => _BusListItemWidgetState();
}

class _BusListItemWidgetState extends State<BusListItemWidget> {
  final BusListItemBloc bloc = BusListItemBloc();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusListItemBloc, BusListItemState>(
      cubit: bloc,
      builder: (BuildContext context, BusListItemState state) {
        if (state is BusListItemInitial) {
          return _cardItem(context, widget.trip, state);
        } else
          return Container();
      },
    );
  }

  Widget _cardItem(
      BuildContext context, Trip trip, BusListItemInitial state) {
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
                Constant.startPoint: widget.trip.pointUp,
                Constant.endPoint: widget.trip.pointDown
              });
        }
      },
      child: Stack(children: <Widget>[
        MeasureSize(
          onChange: (Size size) {
            bloc.add(ChangingSizeBusListItemEvent(size));
          },
          child: Container(
//            height: 125,
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
                          Expanded(
                            child: Text(
                              trip.pointUp.name,
                              style: textTheme.bodyText2
                                  .copyWith(fontSize: 12, height: 5 / 3),
                            ),
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
                          Expanded(
                            child: Text(
                              trip.pointDown.name,
                              style: textTheme.bodyText2
                                  .copyWith(fontSize: 12, height: 5 / 3),
                            ),
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
          _maskWidget(context, passStartTime, state),
      ]),
    );
  }

  Widget _maskWidget(BuildContext context, bool passStartTime, BusListItemInitial state) {
    return Container(
      child: Center(
        child: Text(
          passStartTime == true ? 'CHUYẾN ĐÃ KHỞI HÀNH' : 'ĐÃ HẾT GHẾ TRỐNG',
          style: textTheme.subtitle1
              .copyWith(color: HaLanColor.white, fontWeight: FontWeight.w600),
        ),
      ),
      height: state.size.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: HaLanColor.gray80.withOpacity(0.8),
      ),
    );
  }
}
