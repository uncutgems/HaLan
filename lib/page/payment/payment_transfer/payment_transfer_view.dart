import 'package:avwidget/size_tool.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/styles.dart';

class PaymentTransferPage extends StatefulWidget {
  @override
  _PaymentTransferPageState createState() => _PaymentTransferPageState();
}

class _PaymentTransferPageState extends State<PaymentTransferPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chuyển khoản trực tiếp'),
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
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Vui lòng chuyển khoản tới một trong các tài khoản dưới đây của nhà xe',
              style: textTheme.bodyText2
                  .copyWith(fontWeight: FontWeight.normal, height: 11 / 7),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                _atmInfo(context, 'BIDV', 30189824100123, 'Nguyễn Thị Lan'),
                Container(
                  height: AVSize.getSize(context, 8),
                ),
                _atmInfo(
                    context, 'Techcombank', 30189824100123, 'Nguyễn Thị Lan'),
              ],
            ),
          ),
          Text(
            'Cú pháp chuyển khoản: ',
            style: textTheme.subtitle2
                .copyWith(fontWeight: FontWeight.w600, height: 11 / 7),
          ),
          RichText(
            text: TextSpan(
                text: '<Số điện thoại đặt vé>',
                style: textTheme.subtitle2.copyWith(
                    fontWeight: FontWeight.w600,
                    height: 11 / 7,
                    color: HaLanColor.red100),
                children: <TextSpan>[
                  TextSpan(
                      text: ' thanh toan',
                      style: textTheme.subtitle2.copyWith(
                          fontWeight: FontWeight.w600, height: 11 / 7)),
                  TextSpan(
                      text: ' <Mã vé>',
                      style: textTheme.subtitle2.copyWith(
                          fontWeight: FontWeight.w600,
                          height: 11 / 7,
                          color: HaLanColor.red100)),
                ]),
          ),
        ],
      ),
    );
  }

  Widget _atmInfo(BuildContext context, String bankName, int cardNumber,
      String cardOwnerName) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), color: HaLanColor.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            bankName,
            style: textTheme.subtitle2.copyWith(
                fontWeight: FontWeight.w600,
                color: HaLanColor.primaryColor,
                height: 11 / 7),
          ),
          Container(
            height: AVSize.getSize(context, 4),
          ),
          Text(
            cardNumber.toString(),
            style: textTheme.subtitle1.copyWith(
                color: HaLanColor.black,
                fontWeight: FontWeight.w600,
                height: 1.5),
          ),
          Container(
            height: AVSize.getSize(context, 4),
          ),
          Row(
            children: <Widget>[
              Text(
                cardOwnerName,
                style: textTheme.subtitle2
                    .copyWith(fontWeight: FontWeight.w600, height: 11 / 7),
              ),
              Expanded(child: Container()),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: cardNumber.toString()));
                },
                child: Container(
                  child: Text(
                    'Sao chép tài khoản',
                    style: textTheme.bodyText2.copyWith(
                        fontSize: 12,
                        color: HaLanColor.blue,
                        height: 5 / 3,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
