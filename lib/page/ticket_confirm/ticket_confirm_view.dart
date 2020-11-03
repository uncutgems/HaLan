import 'package:avwidget/popup_loading_widget.dart';
import 'package:avwidget/size_tool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/routes.dart';
import 'package:halan/base/styles.dart';
import 'package:halan/base/tools.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/model/enum.dart';
import 'package:halan/page/ticket_confirm/payment/ticket_payment_bloc.dart';
import 'package:halan/page/ticket_confirm/payment/ticket_payment_view.dart';
import 'package:halan/page/ticket_confirm/seat_map/seat_map_view.dart';
import 'package:halan/page/ticket_confirm/seat_number/seat_number_view.dart';
import 'package:halan/page/ticket_confirm/ticket_confirm_bloc.dart';

class TicketConfirmPage extends StatefulWidget {
  const TicketConfirmPage(
      {Key key,
      @required this.trip,
      @required this.startPoint,
      @required this.endPoint})
      : super(key: key);
  final Trip trip;
  final Point startPoint;
  final Point endPoint;

  @override
  _TicketConfirmPageState createState() => _TicketConfirmPageState();
}

class _TicketConfirmPageState extends State<TicketConfirmPage> {
  final TicketPaymentBloc _ticketPaymentBloc = TicketPaymentBloc();
  final TicketConfirmBloc bloc = TicketConfirmBloc();

  @override
  void initState() {
    bloc.add(GetDataTicketConfirmEvent(
        widget.trip, widget.startPoint.id, widget.endPoint.id));
    bloc.add(GetListTicketTicketConfirmEvent(
        widget.trip, widget.startPoint.id, widget.endPoint.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketConfirmBloc, TicketConfirmState>(
        cubit: bloc,
        builder: (BuildContext context, TicketConfirmState state) {
          if (state is SuccessGetDataTicketConfirmState) {
            return _body(context, state);
          } else if (state is FailGetDataTicketConfirmState) {
            return Container(
              child: Text(state.error),
            );
          } else
            return Container();
        },
        buildWhen: (TicketConfirmState prev, TicketConfirmState current) {
          if (current is TurnOnLoadingTicketConfirmState) {
            showPopupLoading(context);
            return false;
          } else if (current is TurnOffLoadingTicketConfirmState) {
            Navigator.pop(context);

            return false;
          } else
            return true;
        });
  }

  Widget _body(BuildContext context, SuccessGetDataTicketConfirmState state) {
    final List<Seat> totalSeat = <Seat>[];
    totalSeat.addAll(state.listSeat1);
    totalSeat.addAll(state.listSeat2);

    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Xác nhận đặt vé'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },

          ),
//          actions: <Widget>[
//            IconButton(icon: const Icon(Icons.message), onPressed: (){
//              prefs.setString(Constant.trip, jsonEncode(widget.trip));
//              Navigator.pushNamed(context, RoutesName.driverLocationPage,);
//            }),
//          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Khởi hành',
                        style: textTheme.subtitle2.copyWith(
                            fontWeight: FontWeight.w500,
                            color: HaLanColor.primaryColor,
                            height: 17 / 14),
                      ),
                      Container(
                        height: AVSize.getSize(context, 4),
                      ),
                      Text(
                        convertTime(
                            'dd/MM/yyyy',
                            convertNewDayStyleToMillisecond(widget.trip.date),
                            false),
                        style: textTheme.bodyText2.copyWith(
                            fontWeight: FontWeight.normal,
                            fontSize: AVSize.getFontSize(context, 12),
                            height: 5 / 3),
                      ),
                      Container(
                        height: AVSize.getSize(context, 4),
                      ),
                      Text(
                        convertTime(
                            'HH:mm', widget.trip.startTimeReality, true),
                        style: textTheme.subtitle1.copyWith(
                            fontSize: AVSize.getFontSize(context, 24),
                            fontWeight: FontWeight.w500,
                            height: 29 / 24),
                      ),
                      Container(
                        height: AVSize.getSize(context, 4),
                      ),
                      Container(
                        width: AVSize.getSize(context, 150),
                        child: Text(
                          widget.trip.pointUp.name,
                          style: textTheme.bodyText2.copyWith(fontSize: 12),
                        ),
                      )
                    ],
                  ),
                  Expanded(child: Container()),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Đến nơi',
                        style: textTheme.subtitle2.copyWith(
                            fontWeight: FontWeight.w500,
                            color: HaLanColor.primaryColor,
                            height: 17 / 14),
                      ),
                      Container(
                        height: AVSize.getSize(context, 4),
                      ),
                      Text(
                        convertTime(
                            'dd/MM/yyyy',
                            convertNewDayStyleToMillisecond(widget.trip.date),
                            false),
                        style: textTheme.bodyText2.copyWith(
                            fontWeight: FontWeight.normal,
                            fontSize: AVSize.getFontSize(context, 12),
                            height: 5 / 3),
                      ),
                      Container(
                        height: AVSize.getSize(context, 4),
                      ),
                      Text(
                        convertTime(
                            'HH:mm',
                            widget.trip.startTimeReality + widget.trip.runTime,
                            true),
                        style: textTheme.subtitle1.copyWith(
                            fontSize: AVSize.getFontSize(context, 24),
                            fontWeight: FontWeight.w500,
                            height: 29 / 24),
                      ),
                      Container(
                        height: AVSize.getSize(context, 4),
                      ),
                      Container(
                        width: AVSize.getSize(context, 150),
                        child: Text(
                          widget.trip.pointDown.name,
                          textAlign: TextAlign.end,
                          style: textTheme.bodyText2.copyWith(fontSize: 12),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Container(
                height: AVSize.getSize(context, 32),
              ),
              if (widget.trip.choosableSeat == ChoosableSeat.notAllowed)
                SeatNumberWidget(
                  trip: widget.trip,
                  onSeatChanged: (int seatNumber) {
                    _ticketPaymentBloc.add(ChangeSeatNumberTicketPaymentEvent(
                        seatNumber, state.tripPrice, totalSeat));
                  },
                ),
              Container(
                height: AVSize.getSize(context, 16),
              ),
              if (widget.trip.choosableSeat == ChoosableSeat.allowed)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Chọn ghế',
                      style: textTheme.subtitle2.copyWith(
                          fontSize: AVSize.getFontSize(context, 14),
                          fontWeight: FontWeight.w500),
                    ),
                    Container(
                      height: AVSize.getSize(context, 8),
                    ),
                    Row(
                      children: <Widget>[
                        _rowOption(
                            context, HaLanColor.primaryColor, 'Ghế đang chọn'),
                        Container(
                          width: AVSize.getSize(context, 16),
                        ),
                        _rowOption(context, HaLanColor.iconColor, 'Ghế trống'),
                        Container(
                          width: AVSize.getSize(context, 16),
                        ),
                        _rowOption(
                            context, HaLanColor.borderColor, 'Ghế đã đặt'),
                      ],
                    ),
                  ],
                ),
              Container(
                height: AVSize.getSize(context, 24),
              ),
              if (widget.trip.choosableSeat == ChoosableSeat.allowed &&
                  state.routeEntity.id != null)
                SeatMapWidget(
                  trip: widget.trip,
                  routeEntity: state.routeEntity,
                  tripPrice: state.tripPrice,
                  ticketPaymentBloc: _ticketPaymentBloc,
                  listSeat1: state.listSeat1,
                  listSeat2: state.listSeat2,
                ),
//              PromotionWidget(),
            ],
          ),
        ),
        bottomNavigationBar: BlocProvider<TicketPaymentBloc>(
          create: (BuildContext context) => _ticketPaymentBloc,
          child: TicketPaymentWidget(
            trip: widget.trip,
            tripPrice: state.tripPrice,
            navigate: () {
              Navigator.pushNamed(context, RoutesName.homeSignInPage);
            },
          ),
        ),
      ),
    );
  }

  Widget _rowOption(BuildContext context, Color color, String title) {
    return Row(
      children: <Widget>[
        Container(
          height: AVSize.getSize(context, 20),
          width: AVSize.getSize(context, 20),
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        Container(
          width: AVSize.getSize(context, 4),
        ),
        Text(
          title,
          style: textTheme.bodyText2.copyWith(
              fontSize: AVSize.getFontSize(context, 12),
              color: HaLanColor.black,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

}
