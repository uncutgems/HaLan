import 'package:avwidget/av_button_widget.dart';
import 'package:avwidget/size_tool.dart';
import 'package:flutter/material.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/routes.dart';
import 'package:halan/base/styles.dart';
import 'package:halan/base/tool.dart';
import 'package:halan/model/entity.dart';

class PaymentATMPage extends StatefulWidget {
  const PaymentATMPage({Key key, this.ticketList, this.totalPrice})
      : super(key: key);

  final List<Ticket> ticketList;
  final int totalPrice;

  @override
  _PaymentATMPageState createState() => _PaymentATMPageState();
}

class _PaymentATMPageState extends State<PaymentATMPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh toán qua ATM'),
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
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Center(
                child: Text(
              'Số tiền cần thanh toán là ${currencyFormat(widget.totalPrice, 'Đ')}',
              style: textTheme.subtitle1.copyWith(
                  color: HaLanColor.primaryColor,
                  fontWeight: FontWeight.w600,
                  height: 1.5),
            )),
            color: HaLanColor.bannerColor,
          ),
          Container(
            height: AVSize.getSize(context, 24),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              'Chọn ngân hàng bạn muốn dùng để thanh toán',
              style: textTheme.bodyText1
                  .copyWith(fontWeight: FontWeight.w600, height: 11 / 7),
            ),
          ),
          AVButton(
            color: HaLanColor.primaryColor,
            title: 'Quay về trang chủ',
            onPressed: () {
              Navigator.popUntil(
                  context, ModalRoute.withName(RoutesName.busBookingPage));
            },
          ),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              crossAxisCount: 3,
              crossAxisSpacing: 24,
              children: <Widget>[
                _atmCard(context, 'assets/techcombank_logo.png', () {
                  print('techcom');
                }),
                _atmCard(context, 'assets/vietcombank_logo.png', () {
                  print('techcom');
                }),
                _atmCard(context, 'assets/techcombank_logo.png', () {
                  print('techcom');
                }),
                _atmCard(context, 'assets/techcombank_logo.png', () {
                  print('techcom');
                }),
                _atmCard(context, 'assets/techcombank_logo.png', () {
                  print('techcom');
                }),
                _atmCard(context, 'assets/techcombank_logo.png', () {
                  print('techcom');
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _atmCard(
      BuildContext context, String atmImage, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          height: AVSize.getSize(context, 48),
          decoration: BoxDecoration(
            color: HaLanColor.grayATM,
            borderRadius: BorderRadius.circular(4),
            image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: AssetImage(atmImage),
            ),
          ),
        ),
      ),
    );
  }
}
