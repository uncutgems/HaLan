import 'package:avwidget/size_tool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/styles.dart';
import 'package:halan/base/tools.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/model/enum.dart';
import 'package:halan/page/ticket_confirm/payment/ticket_payment_bloc.dart';
import 'package:halan/page/ticket_confirm/payment/ticket_payment_view.dart';
import 'package:halan/page/ticket_confirm/promotion/promotion_view.dart';
import 'package:halan/page/ticket_confirm/seat_map/seat_map_view.dart';
import 'package:halan/page/ticket_confirm/seat_number/seat_number_view.dart';

class TicketConfirmPage extends StatefulWidget {
  const TicketConfirmPage({Key key, this.trip}) : super(key: key);
  final Trip trip;

  @override
  _TicketConfirmPageState createState() => _TicketConfirmPageState();
}

class _TicketConfirmPageState extends State<TicketConfirmPage> {
  final TicketPaymentBloc _ticketPaymentBloc = TicketPaymentBloc();

  @override
  Widget build(BuildContext context) {
    print(widget.trip.choosableSeat.toString() + 'lấy được ko thế');
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
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Column(
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
                            'hh:mm', widget.trip.startTimeReality, true),
                        style: textTheme.subtitle1.copyWith(
                            fontSize: AVSize.getFontSize(context, 24),
                            fontWeight: FontWeight.w500,
                            height: 29 / 24),
                      ),
                      Container(
                        height: AVSize.getSize(context, 4),
                      ),
                      Text(
                        widget.trip.pointUp.name,
                        style: textTheme.bodyText2.copyWith(fontSize: 12),
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
                            'hh:mm',
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
                      Text(
                        widget.trip.pointDown.name,
                        style: textTheme.bodyText2.copyWith(fontSize: 12),
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
                        seatNumber, widget.trip.price));
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
                    Container(height: AVSize.getSize(context, 8),),

                    Row(
                      children: <Widget>[
                        _rowOption(context, HaLanColor.primaryColor, 'Ghế đang chọn'),
                        Container(width: AVSize.getSize(context, 16),),
                        _rowOption(context, HaLanColor.iconColor, 'Ghế trống'),
                        Container(width: AVSize.getSize(context, 16),),

                        _rowOption(context, HaLanColor.borderColor, 'Ghế đã đặt'),
                      ],
                    ),
                  ],
                ),
              Container(height: AVSize.getSize(context, 24),),
              if (widget.trip.choosableSeat == ChoosableSeat.allowed)
                SeatMapWidget(
                  trip: widget.trip,
                ),
              PromotionWidget(),
            ],
          ),
        ),
        bottomNavigationBar: BlocProvider<TicketPaymentBloc>(
          create: (BuildContext context) => _ticketPaymentBloc,
          child: TicketPaymentWidget(),
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
          decoration:  BoxDecoration(
              shape: BoxShape.circle,
              color: color),
        ),
        Container(
          width: AVSize.getSize(context, 4),
        ),
        Text(
          title,
          style: textTheme.bodyText2.copyWith(
              fontSize: AVSize.getFontSize(context, 12),
              color: HaLanColor.black, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
