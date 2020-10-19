import 'package:avwidget/popup_loading_widget.dart';
import 'package:avwidget/size_tool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/styles.dart';
import 'package:halan/base/tool.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/model/enum.dart';
import 'package:halan/page/ticket_confirm/payment/ticket_payment_bloc.dart';
import 'package:halan/page/ticket_confirm/seat_map/seat_map_bloc.dart';

class SeatMapWidget extends StatefulWidget {
  const SeatMapWidget(
      {Key key,
      this.trip,
      this.routeEntity,
      this.tripPrice,
      this.ticketPaymentBloc,
      this.listSeat1,
      this.listSeat2})
      : super(key: key);

  final Trip trip;
  final RouteEntity routeEntity;
  final int tripPrice;
  final TicketPaymentBloc ticketPaymentBloc;
  final List<Seat> listSeat1;
  final List<Seat> listSeat2;

  @override
  _SeatMapWidgetState createState() => _SeatMapWidgetState();
}

class _SeatMapWidgetState extends State<SeatMapWidget> {
  final SeatMapBloc bloc = SeatMapBloc();

  @override
  void initState() {
    bloc.add(GetDataSeatMapEvent(widget.listSeat1, widget.listSeat2));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeatMapBloc, SeatMapState>(
      cubit: bloc,
      builder: (BuildContext context, SeatMapState state) {
        if (state is GetDataSeatMapState) {
          if (state.seatList1 != null) {
            return _body(context, state);
          } else
            return Container();
        } else if (state is FailGetDataSeatMapState) {
          return Container(
            child: Center(
              child: Text(state.error),
            ),
          );
        } else
          return Container();
      },
      buildWhen: (SeatMapState prev, SeatMapState current) {
        if (current is TurnOnLoadingSeatMapState) {
          _showLoading(context);
          return false;
        } else if (current is TurnOffLoadingSeatMapState) {
          Navigator.pop(context);

          return false;
        } else
          return true;
      },
    );
  }

  Widget _body(BuildContext context, GetDataSeatMapState state) {
    final List<Seat> selectedSeats = <Seat>[];
    for (final Seat seat in state.seatList1) {
      if (seat.isPicked != null) {
        if (seat.isPicked) {
          selectedSeats.add(seat);
        }
      }
    }
    for (final Seat seat in state.seatList2) {
      if (seat.isPicked != null) {
        if (seat.isPicked) {
          selectedSeats.add(seat);
        }
      }
    }
    widget.ticketPaymentBloc
        .add(ChooseSeatTicketPaymentEvent(selectedSeats, widget.tripPrice));
    return Expanded(
      child: ListView(
        children: <Widget>[
          Container(
            height: AVSize.getSize(context, 32),
            color: HaLanColor.borderColor,
            child: Center(
              child: Text(
                'Tầng 1',
                style: textTheme.subtitle1.copyWith(
                    fontSize: AVSize.getFontSize(context, 14),
                    fontWeight: FontWeight.w500,
                    color: HaLanColor.black),
              ),
            ),
          ),
          _seatMap(
            context: context,
            trip: widget.trip,
            seatList: state.seatList1,
          ),
          if (widget.trip.seatMap.numberOfFloors == 2)
            Container(
              height: AVSize.getSize(context, 32),
              color: HaLanColor.borderColor,
              child: Center(
                child: Text(
                  'Tầng 2',
                  style: textTheme.subtitle1.copyWith(
                      fontSize: AVSize.getFontSize(context, 14),
                      fontWeight: FontWeight.w500,
                      color: HaLanColor.black),
                ),
              ),
            ),
//          if (widget.trip.seatMap.numberOfFloors == 2)
//            Container(
//              height: AVSize.getSize(context, 350),
//              width: AVSize.getSize(context, 1),
//              color: HaLanColor.bannerColor,
//            ),
          if (widget.trip.seatMap.numberOfFloors == 2)
            _seatMap(
              context: context,
              trip: widget.trip,
              seatList: state.seatList2,
            ),
        ],
      ),
    );
  }

  Widget _seatMap({
    @required BuildContext context,
    @required Trip trip,
    @required List<Seat> seatList,
//    @required List<Ticket> ticketList,
//    @required List<Seat> pickedSeat,
//    @required CalculateMoneyBloc calculateMoneyBloc,
//    @required double tripPrice,
  }) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: trip.seatMap.numberOfColumns,
      children: seatList.map<Widget>((Seat seat) {
        return _seatByType(
          context: context,
          onPressed: () {
            bloc.add(ClickSeatSeatMapEvent(seat));
          },
          trip: trip,
          seat: seat,
        );
      }).toList(),
    );
  }

  Widget _seatByType(
      {@required BuildContext context,
      @required Trip trip,
      @required Seat seat,
      @required VoidCallback onPressed}) {
    String imageString;
    bool allowClick;
    switch (seat.seatType) {
      case SeatType.driverSeat:
        imageString = 'assets/driver_seat.png';
        allowClick = false;
        break;
      case SeatType.astSeat:
        imageString = 'assets/driver_seat.png';
        allowClick = false;
        break;
      case SeatType.empty:
        imageString = 'no_seat';
        allowClick = false;
        break;
      case SeatType.bedSeat:
        imageString = 'assets/bed.png';
        if (seat.ticketStatus == TicketStatus.empty) {
          allowClick = true;
        } else
          allowClick = false;
        break;
      case SeatType.normalSeat:
        imageString = 'assets/normal_seat.png';
        if (seat.ticketStatus == TicketStatus.empty) {
          allowClick = true;
        } else
          allowClick = false;
        break;
      case SeatType.door:
        imageString = 'assets/door.png';
        allowClick = false;
        break;
      default:
        imageString = 'no_seat';
        allowClick = false;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: allowClick ? onPressed : null,
        child: imageString != 'no_seat'
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: AVSize.getSize(context, 40),
                    child: Image.asset(
                      imageString,
                      color: setColorForSeat(seat),
                    ),
                  ),
                  Text(
                    seat.seatType != SeatType.door
                        ? 'Ghế ${seat.seatId}'
                        : 'Cửa ra',
                    style: textTheme.bodyText2.copyWith(
                      fontSize: AVSize.getFontSize(
                          context, trip.seatMap.numberOfColumns > 3 ? 8 : 12),
                      color: setColorForSeat(seat),
                    ),
                  ),
                  if (seat.seatType != SeatType.driverSeat &&
                      trip.seatMap.numberOfColumns <= 3)
                    Text(
                      currencyFormat(
                          widget.tripPrice.toInt() + seat.extraPrice.toInt(),
                          'Đ'),
                      style: textTheme.bodyText2.copyWith(
                          fontSize: AVSize.getFontSize(context, 12),
                          color: setColorForSeat(seat)),
                    )
                  else
                    Container(),
                ],
              )
            : Container(
                color: HaLanColor.backgroundColor,
              ),
      ),
    );
  }

  Color setColorForSeat(Seat seat) {
    switch (seat.ticketStatus) {
      case TicketStatus.empty:
        if (seat.isPicked != null) {
          if (seat.isPicked) {
            return HaLanColor.primaryColor;
          } else {
            return HaLanColor.iconColor;
          }
        }
        break;
      case TicketStatus.booked:
        if (seat.overTime >= DateTime.now().millisecondsSinceEpoch ||
            seat.overTime == 0) {
          return HaLanColor.borderColor;
        } else {
          if (seat.isPicked) {
            return HaLanColor.primaryColor;
          } else {
            return HaLanColor.iconColor;
          }
        }
        break;
      case TicketStatus.bought:
        return HaLanColor.borderColor;
        break;
      case TicketStatus.onTheTrip:
        return HaLanColor.borderColor;
        break;
      case TicketStatus.completed:
        return HaLanColor.borderColor;
        break;
      case TicketStatus.bookedAdmin:
        return HaLanColor.borderColor;
        break;
    }
    return HaLanColor.iconColor;
  }

  void _showLoading(BuildContext context) {
    showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) => const AVLoadingWidget());
  }
}
