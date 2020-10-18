import 'package:avwidget/size_tool.dart';
import 'package:flutter/material.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/styles.dart';

class PaymentQRHomePage extends StatefulWidget {
  @override
  _PaymentQRHomePageState createState() => _PaymentQRHomePageState();
}

class _PaymentQRHomePageState extends State<PaymentQRHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh toán qua QR Code'),
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
                  'Số tiền cần thanh toán là',
                  style: textTheme.bodyText2.copyWith(
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
            padding: const EdgeInsets.all(16.0),
            child: Text('Vui lòng sử dụng các phần mềm của Ngân hàng để đọc mã QR Code', style: textTheme.bodyText1.copyWith(fontWeight: FontWeight.w600, height: 11/7),),
          )
        ],
      ),
    );
  }
}
