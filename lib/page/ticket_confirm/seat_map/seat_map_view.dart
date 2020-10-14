
import 'package:avwidget/size_tool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/styles.dart';
import 'package:halan/base/tool.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/model/enum.dart';
import 'package:halan/page/ticket_confirm/seat_map/seat_map_bloc.dart';

class SeatMapWidget extends StatefulWidget {
  const SeatMapWidget({Key key, this.trip}) : super(key: key);

  final Trip trip;

  @override
  _SeatMapWidgetState createState() => _SeatMapWidgetState();
}

class _SeatMapWidgetState extends State<SeatMapWidget> {
  final SeatMapBloc bloc = SeatMapBloc();

  @override
  void initState() {
    print('ủa thế là sao');
    bloc.add(GetDataSeatMapEvent(widget.trip, const <Ticket>[]));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeatMapBloc, SeatMapState>(
      cubit: bloc,
      builder: (BuildContext context, SeatMapState state) {
        if (state is GetDataSeatMapState) {
          print('có vào body ko');
          return _body(context, state);
        } else
          return Container();
      },
    );
  }

  Widget _body(BuildContext context, GetDataSeatMapState state) {
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
          if (widget.trip.seatMap.numberOfFloors == 2) Container(
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
          if (widget.trip.seatMap.numberOfFloors == 2)
            Container(
              height: AVSize.getSize(context, 350),
              width: AVSize.getSize(context, 1),
              color: HaLanColor.bannerColor,
            ),
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
    return Expanded(
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: trip.seatMap.numberOfColumns,
        children: seatList.map<Widget>((Seat seat) {
//          final int index = seatList.indexOf(seat);
//          final List<Ticket> tickets = <Ticket>[];
//
//          for (final Ticket ticket in ticketList) {
//            if (ticket.seat.seatId == seat.seatId) {
//              tickets.add(ticket);
//            }
//          }

          return _seatByType(
            context: context,
            onPressed: () {},
            trip: trip,
            seat: seat,
          );
        }).toList(),
      ),
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

        allowClick = true;
        break;
      case SeatType.normalSeat:
        imageString = 'assets/normal_seat.png';

//        setColorForSeat(seat);
        allowClick = true;
        break;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: allowClick ? onPressed : null,
        child: imageString != 'no_seat'
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: AVSize.getSize(context, 40),
                    child: Image.asset(
                      imageString,
                      color: setColorForSeat(seat),
                    ),
                  ),
                  Text(
                    'Ghế ${seat.seatId}',
                    style: textTheme.bodyText2.copyWith(
                      fontSize: AVSize.getFontSize(context, 12),
                      color: setColorForSeat(seat),
                    ),
                  ),
                  Text(
                    currencyFormat(widget.trip.price.toInt(), 'Đ'),
                    style: textTheme.bodyText2.copyWith(
                        fontSize: AVSize.getFontSize(context, 12),
                        color: setColorForSeat(seat)),
                  )
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
}
