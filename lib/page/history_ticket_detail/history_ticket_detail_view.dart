import 'package:avwidget/size_tool.dart';
import 'package:flutter/material.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/styles.dart';
import 'package:halan/base/tool.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/model/enum.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HistoryTicketDetailPage extends StatefulWidget {
  const HistoryTicketDetailPage({Key key, this.ticket}) : super(key: key);

  final Ticket ticket;

  @override
  _HistoryTicketDetailPageState createState() =>
      _HistoryTicketDetailPageState();
}

class _HistoryTicketDetailPageState extends State<HistoryTicketDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết vé'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Column(
          children: <Widget>[
            QrImage(
              data: widget.ticket.ticketId,
              size: AVSize.getSize(context, 120),
              version: QrVersions.auto,
              backgroundColor: HaLanColor.white,
            ),
            Container(
              height: AVSize.getSize(context, 8),
            ),
            Text(
              'Mã vé: ${widget.ticket.ticketId}',
              style: textTheme.subtitle1.copyWith(
                  fontSize: AVSize.getFontSize(context, 16),
                  fontWeight: FontWeight.w500,
                  height: 5 / 4,
                  color: HaLanColor.black),
            ),
            if (widget.ticket.ticketStatus == TicketStatus.bookedAdmin ||
                widget.ticket.ticketStatus == TicketStatus.booked)
              Text(
                'Đang xử lý',
                style: textTheme.subtitle1.copyWith(
                    fontSize: AVSize.getFontSize(context, 16),
                    fontWeight: FontWeight.w500,
                    height: 5 / 4,
                    color: HaLanColor.primaryColor),
              )
            else if (widget.ticket.ticketStatus == TicketStatus.overTime ||
                widget.ticket.ticketStatus == TicketStatus.canceled)
              Text(
                'Đã hủy',
                style: textTheme.subtitle1.copyWith(
                    fontSize: AVSize.getFontSize(context, 16),
                    fontWeight: FontWeight.w500,
                    height: 5 / 4,
                    color: HaLanColor.cancelColor),
              )
            else
              Text(
                'Đã hoàn thành',
                style: textTheme.subtitle1.copyWith(
                    fontSize: AVSize.getFontSize(context, 16),
                    fontWeight: FontWeight.w500,
                    height: 5 / 4,
                    color: HaLanColor.green),
              ),
            Container(
              padding:  EdgeInsets.all(AVSize.getSize(context, 16)),
              decoration: BoxDecoration(
                color: HaLanColor.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        height: AVSize.getSize(context, 40),
                        child: Text(
                          convertTime(
                              'HH:mm', widget.ticket.getInTimePlan, true),
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
                        height: AVSize.getSize(context, 40),
                        child: Text(
                          convertTime(
                              'HH:mm', widget.ticket.getOffTimePlan, true),
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
                          color: HaLanColor.primaryColor
                        ),
                      ),
                      Container(
                        height: AVSize.getSize(context, 48),
                        width: AVSize.getSize(context, 2),
                        color: HaLanColor.primaryColor,
                      ),
                      Container(
                        height: AVSize.getSize(context, 8),
                        width: AVSize.getSize(context, 8),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: HaLanColor.primaryColor
                        ),
                      ),
                      Container(
                        height: AVSize.getSize(context, 10),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
