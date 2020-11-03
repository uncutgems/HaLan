import 'package:avwidget/av_alert_dialog_widget.dart';
import 'package:avwidget/av_button_widget.dart';
import 'package:avwidget/size_tool.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/constant.dart';
import 'package:halan/base/routes.dart';
import 'package:halan/base/styles.dart';
import 'package:halan/base/tools.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/model/enum.dart';
import 'package:halan/page/history_ticket_detail/history_ticket_detail_bloc.dart';
import 'package:halan/widget/fail_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HistoryTicketDetailPage extends StatefulWidget {
  const HistoryTicketDetailPage({Key key, this.ticketCode}) : super(key: key);

  final String ticketCode;

  @override
  _HistoryTicketDetailPageState createState() =>
      _HistoryTicketDetailPageState();
}

class _HistoryTicketDetailPageState extends State<HistoryTicketDetailPage> {
  final HistoryTicketDetailBloc bloc = HistoryTicketDetailBloc();

  @override
  void initState() {
    bloc.add(GetDataHistoryTicketDetailEvent(widget.ticketCode));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryTicketDetailBloc, HistoryTicketDetailState>(
      cubit: bloc,
      builder: (BuildContext context, HistoryTicketDetailState state) {
        if (state is SuccessGetDataTicketDetailState) {
          if (state.listTicket.isNotEmpty) {
            return _body(context, state);
          } else
            return Scaffold(
              appBar: AppBar(
                title: const Text('Chi tiết vé'),
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                  onPressed: () => Navigator.popUntil(
                      context, ModalRoute.withName(RoutesName.busBookingPage)),
                ),
              ),
            );
        } else if (state is FailGetDataTicketDetailState) {
          return Center(
            child: FailWidget(
              message: state.error,
              onPressed: () {
                bloc.add(GetDataHistoryTicketDetailEvent(widget.ticketCode));
              },
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _body(BuildContext context, SuccessGetDataTicketDetailState state) {
    final Ticket firstTicket = state.listTicket[0];

    final bool paidMoneyYet = firstTicket.ticketStatus == TicketStatus.booked ||
        firstTicket.ticketStatus == TicketStatus.bookedAdmin ||
        (firstTicket.ticketStatus == TicketStatus.bought &&
            firstTicket.paidMoney < firstTicket.agencyPrice);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết vé'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.popUntil(
              context, ModalRoute.withName(RoutesName.busBookingPage)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: ListView(
          children: <Widget>[
            CarouselSlider.builder(
              options: CarouselOptions(
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                  height: 600),
              itemCount: state.listTicket.length,
              itemBuilder: (BuildContext context, int index) {
                final Ticket ticket = state.listTicket[index];
                return _itemTicket(ticket);
              },
            ),
            Container(
              height: AVSize.getSize(context, 8),
            ),
            if (!paidMoneyYet)
              Container(
                padding: EdgeInsets.all(AVSize.getSize(context, 16)),
                decoration: BoxDecoration(
                  color: HaLanColor.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Tổng tiền',
                      style: textTheme.bodyText2.copyWith(
                          fontSize: AVSize.getFontSize(context, 14),
                          height: 11 / 7),
                    ),
                    Expanded(child: Container()),
                    Text(
                      currencyFormat(state.totalMoney.toInt(), 'Đ'),
                      style: textTheme.bodyText1.copyWith(
                          fontWeight: FontWeight.w600,
                          color: HaLanColor.primaryColor,
                          fontSize: AVSize.getFontSize(context, 16),
                          height: 3 / 2),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: !paidMoneyYet
          ? Container(
              color: HaLanColor.red20,
              height: AVSize.getSize(context, 48),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Bạn cần trợ giúp?',
                      style: textTheme.bodyText2.copyWith(
                          fontSize: AVSize.getFontSize(context, 14),
                          fontWeight: FontWeight.w600,
                          color: HaLanColor.red100),
                    ),
                    Container(
                      width: AVSize.getSize(context, 8),
                    ),
                    AVButton(
                      fontWeight: FontWeight.w600,
                      fontSize: AVSize.getFontSize(context, 14),
                      title: 'Gọi tổng đài ngay',
                      color: HaLanColor.white,
                      textColor: HaLanColor.red100,
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            )
          : Container(
              padding: EdgeInsets.all(AVSize.getSize(context, 16)),
              decoration: const BoxDecoration(
                color: HaLanColor.primaryColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Tổng tiền',
                        style: textTheme.subtitle1.copyWith(
                            fontSize: AVSize.getFontSize(context, 14),
                            color: HaLanColor.white,
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: AVSize.getSize(context, 8),
                      ),
                      Text(
                        currencyFormat(state.totalMoney, 'Đ'),
                        style: textTheme.subtitle1.copyWith(
                            fontSize: AVSize.getFontSize(context, 18),
                            color: HaLanColor.white,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  Expanded(
                      child: Container(
                    height: 1,
                  )),
                  AVButton(
                    title: 'Tiến hành thanh toán',
                    fontSize: AVSize.getFontSize(context, 12),
                    color: HaLanColor.white,
                    textColor: HaLanColor.primaryColor,
                    onPressed: () {
                      Navigator.pushNamed(context, RoutesName.paymentHomePage,
                          arguments: <String, dynamic>{
                            Constant.listTicket: state.listTicket,
                            Constant.totalPrice: state.totalMoney
                          });
                    },
                    trailingIcon: const Icon(
                      Icons.arrow_forward,
                      color: HaLanColor.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _itemTicket(Ticket ticket) {
    final bool showLocation = ticket.ticketStatus == TicketStatus.booked ||
        ticket.ticketStatus == TicketStatus.bought ||
        ticket.ticketStatus == TicketStatus.bookedAdmin;
    return Column(
      children: <Widget>[
        Center(
          child: QrImage(
            data: ticket.ticketId,
            size: AVSize.getSize(context, 120),
            version: QrVersions.auto,
            backgroundColor: HaLanColor.white,
          ),
        ),
        Container(
          height: AVSize.getSize(context, 8),
        ),
        Center(
          child: Text(
            'Mã vé: ${ticket.ticketId}',
            style: textTheme.subtitle1.copyWith(
                fontSize: AVSize.getFontSize(context, 16),
                fontWeight: FontWeight.w500,
                height: 5 / 4,
                color: HaLanColor.black),
          ),
        ),
        Center(
          child: Text(
            setTitleByTicketStatus(ticket),
            style: textTheme.subtitle1.copyWith(
                fontSize: AVSize.getFontSize(context, 16),
                fontWeight: FontWeight.w500,
                height: 5 / 4,
                color: setColorByTicketStatus(ticket)),
          ),
        ),
        Container(
          height: AVSize.getSize(context, 8),
        ),
        Center(
          child: Container(
            decoration: BoxDecoration(
              color: HaLanColor.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      left: AVSize.getSize(context, 16),
                      top: AVSize.getSize(context, 16),
                      right: AVSize.getSize(context, 12)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            height: AVSize.getSize(context, 50),
                            child: Text(
                              convertTime('HH:mm', ticket.getInTimePlan, true),
                              style: textTheme.subtitle2.copyWith(
                                  fontSize: AVSize.getFontSize(context, 14),
                                  fontWeight: FontWeight.w600,
                                  color: HaLanColor.black),
                            ),
                          ),
                          Container(
                            height: AVSize.getSize(context, 16),
                          ),
                          Container(
                            height: AVSize.getSize(context, 50),
                            child: Text(
                              convertTime('HH:mm', ticket.getOffTimePlan, true),
                              style: textTheme.subtitle2.copyWith(
                                  fontSize: AVSize.getFontSize(context, 14),
                                  fontWeight: FontWeight.w600,
                                  color: HaLanColor.black),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: AVSize.getSize(context, 10),
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            height: AVSize.getSize(context, 5),
                          ),
                          Container(
                            height: AVSize.getSize(context, 8),
                            width: AVSize.getSize(context, 8),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: HaLanColor.primaryColor),
                          ),
                          Container(
                            height: AVSize.getSize(context, 60),
                            width: AVSize.getSize(context, 2),
                            color: HaLanColor.primaryColor,
                          ),
                          Container(
                            height: AVSize.getSize(context, 8),
                            width: AVSize.getSize(context, 8),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: HaLanColor.primaryColor),
                          ),
                          Container(
                            height: AVSize.getSize(context, 10),
                          ),
                        ],
                      ),
                      Container(
                        width: AVSize.getSize(context, 8),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: AVSize.getSize(context, 50),
                            width: AVSize.getSize(context, 236),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  ticket.pointUp.name,
                                  style: textTheme.subtitle2.copyWith(
                                      fontSize: AVSize.getFontSize(context, 14),
                                      fontWeight: FontWeight.w500,
                                      color: HaLanColor.black),
                                ),
                                Expanded(
                                  child: Text(
                                    ticket.pointUp.address,
                                    style: textTheme.bodyText2.copyWith(
                                        fontSize:
                                            AVSize.getFontSize(context, 12),
                                        fontWeight: FontWeight.w400,
                                        color: HaLanColor.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: AVSize.getSize(context, 16),
                          ),
                          Container(
                            height: AVSize.getSize(context, 50),
                            width: AVSize.getSize(context, 236),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  ticket.pointDown.name,
                                  style: textTheme.subtitle2.copyWith(
                                      fontSize: AVSize.getFontSize(context, 14),
                                      fontWeight: FontWeight.w500,
                                      color: HaLanColor.black),
                                ),
                                Expanded(
                                  child: Text(
                                    ticket.pointDown.address,
                                    style: textTheme.bodyText2.copyWith(
                                        fontSize:
                                            AVSize.getFontSize(context, 12),
                                        fontWeight: FontWeight.w400,
                                        color: HaLanColor.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: AVSize.getSize(context, 343),
                  color: HaLanColor.gray30,
                  height: AVSize.getSize(context, 1),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    if (showLocation)
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RoutesName.driverLocationPage);
                          },
                          child: Container(
                            child: Center(
                              child: Text(
                                'Vị trí tài xế',
                                style: textTheme.bodyText2.copyWith(
                                    color: HaLanColor.blue,
                                    fontSize: AVSize.getFontSize(context, 14)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (showLocation)
                      Container(
                        height: AVSize.getSize(context, 49),
                        color: HaLanColor.gray30,
                        width: AVSize.getSize(context, 1),
                      ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (ticket.tripInfo.drivers.isNotEmpty) {
                            _callPhone(
                                ticket.tripInfo.drivers.first.phoneNumber);
                          } else
                            showDialog<dynamic>(
                                context: context,
                                builder: (BuildContext context) =>
                                    AVAlertDialogWidget(
                                      context: context,
                                      title: 'Chưa có tài xế',
                                      content: 'Vui lòng thử lại sau',
                                      bottomWidget: Center(
                                        child: AVButton(
                                          color: HaLanColor.primaryColor,
                                          title: 'Hủy',
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ));
                        },
                        child: Container(
                          height: AVSize.getSize(context, 49),
                          child: Center(
                            child: Text(
                              'Gọi tài xế',
                              style: textTheme.bodyText2.copyWith(
                                  color: HaLanColor.blue,
                                  fontSize: AVSize.getFontSize(context, 14)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          height: AVSize.getSize(context, 8),
        ),
        Container(
          padding: EdgeInsets.all(AVSize.getSize(context, 16)),
          decoration: BoxDecoration(
            color: HaLanColor.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: <Widget>[
              _rowInfo(context, 'Ghế đã chọn', ticket.listSeatId.join(',')),
              Container(
                height: AVSize.getSize(context, 8),
              ),
              _rowInfo(context, 'Tên liên hệ', ticket.fullName),
              Container(
                height: AVSize.getSize(context, 8),
              ),
              _rowInfo(context, 'Số điện thoại', ticket.phoneNumber),
              Container(
                height: AVSize.getSize(context, 8),
              ),
//                  _rowInfo(context, 'Email', widget.ticket.m),
            ],
          ),
        ),
      ],
    );
  }
}

Future<void> _callPhone(String phoneNumber) async {
  if (await canLaunch('tel:$phoneNumber')) {
    await launch('tel:$phoneNumber');
  } else {
    throw 'Could not launch $phoneNumber';
  }
}

Widget _rowInfo(BuildContext context, String title, String content) {
  return Row(
    children: <Widget>[
      Text(
        title,
        style: textTheme.bodyText2.copyWith(
            fontSize: AVSize.getFontSize(context, 14), height: 11 / 7),
      ),
      Expanded(child: Container()),
      Text(content,
          style: textTheme.bodyText2.copyWith(
              fontSize: AVSize.getFontSize(context, 14),
              fontWeight: FontWeight.w600,
              height: 11 / 7)),
    ],
  );
}
