import 'package:avwidget/size_tool.dart';
import 'package:flutter/material.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/constant.dart';
import 'package:halan/base/routes.dart';
import 'package:halan/base/styles.dart';
import 'package:halan/base/tool.dart';
import 'package:halan/model/entity.dart';

class PaymentHomePage extends StatefulWidget {
  const PaymentHomePage({Key key, this.ticketList, this.totalPrice})
      : super(key: key);

  final List<Ticket> ticketList;
  final int totalPrice;

  @override
  _PaymentHomePageState createState() => _PaymentHomePageState();
}

class _PaymentHomePageState extends State<PaymentHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh toán'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: AVSize.getSize(context, 32),
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Center(
                child: Text(
              'Số tiền cần thanh toán là ${currencyFormat(widget.totalPrice, 'Đ')}',
              style: textTheme.bodyText2.copyWith(
                  color: HaLanColor.primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  height: 1.5),
            )),
            color: HaLanColor.bannerColor,
          ),
          Container(
            height: AVSize.getSize(context, 40),
          ),
          Text(
            'Bạn lựa chọn hình thức thanh toán nào?',
            style: textTheme.bodyText1.copyWith(
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(16),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              crossAxisCount: 2,
              children: <Widget>[
                _paymentType(
                    context, Image.asset('assets/qr_code.png'), 'QR Code', () {
                  Navigator.pushNamed(context, RoutesName.paymentQRPage, arguments: <String, dynamic> {
                    Constant.totalPrice: widget.totalPrice,
                    Constant.listTicket: widget.ticketList,
                  });
                }),
                _paymentType(context, Image.asset('assets/atm_card.png'),
                    'Internet Banking', () {
                  Navigator.pushNamed(context, RoutesName.paymentATMPage);
                }),
                _paymentType(
                    context, Image.asset('assets/visa.png'), 'VISA/Master Card',
                    () {
                  Navigator.pushNamed(context, RoutesName.paymentATMPage);
                }),
                _paymentType(
                    context, Image.asset('assets/bank.png'), 'Chuyển khoản',
                    () {
                  Navigator.pushNamed(context, RoutesName.paymentTransferPage);
                }),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _paymentType(
      BuildContext context, Image image, String title, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 163,
        decoration: BoxDecoration(boxShadow: const <BoxShadow>[
          BoxShadow(color: HaLanColor.gray30, spreadRadius: 2)
        ], borderRadius: BorderRadius.circular(8), color: HaLanColor.white),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              image,
              Container(
                height: 16,
              ),
              Text(title,
                  style: textTheme.bodyText1.copyWith(
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
