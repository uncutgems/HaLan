import 'package:avwidget/av_button_widget.dart';
import 'package:avwidget/size_tool.dart';
import 'package:flutter/material.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/routes.dart';
import 'package:halan/base/styles.dart';

class PaymentSuccessPage extends StatefulWidget {
  @override
  _PaymentSuccessPageState createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh toán'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Bạn đã đặt vé thành công',
                style: textTheme.subtitle1.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                )),
            Image.asset('assets/bus.png'),
            Text('Chúc mừng quý khách đã đặt vé thành công',
                style: textTheme.subtitle1.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                )),
            Container(
              height: AVSize.getSize(context, 16),
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                decoration: BoxDecoration(
                    color: HaLanColor.gray20,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: HaLanColor.borderColor,
                        width: 1,
                        style: BorderStyle.solid)),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Mã đặt chỗ: 09208HDQIO',
                      style: textTheme.headline3
                          .copyWith(fontSize: 24, color: HaLanColor.red100),
                    ),
                    const Divider(
                      color: HaLanColor.borderColor,
                    ),
                    _rowInfo(context, 'Tên', 'Lê Tuấn Linh'),
                    _rowInfo(context, 'Số điện thoại', '0123456789'),
                    _rowInfo(context, 'Email', 'tuanlinh@anvui.vn'),
                    _rowInfo(context, 'Tuyến',
                        'BX nước ngầm - BX Cửa lò (Quốc lộ 1)'),
                    _rowInfo(context, 'Giờ xuất bến', '8h30 - 27/02/2020'),
                    _rowInfo(context, 'Điểm đón',
                        'Trung chuyển tại 172 Trần Duy Hưng'),
                    _rowInfo(context, 'Thời gian đón', '7h30 - 27/02/2020'),
                    _rowInfo(context, 'Điểm trả',
                        'Tòa nhà Comatce 62 Ngụy Như Kon Tum, Hà Nội'),
                    const Divider(
                      color: HaLanColor.borderColor,
                      thickness: 1,
                    ),
                    _rowInfo(context, 'Tổng tiền vé', '460.000 Đ'),
                    _rowInfo(context, 'Phải thanh toán', '460.000 Đ'),
                  ],
                ),
              ),
            ),
            Container(
              height: AVSize.getSize(context, 16),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: AVButton(color: HaLanColor.primaryColor, title: 'Về trang chủ', onPressed: () {
                    Navigator.popAndPushNamed(context, RoutesName.busBookingPage);
                  },),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _rowInfo(BuildContext context, String title, String content) {
    return Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Container(
        width: AVSize.getSize(context, 96),
        child: Text(
          title,
          textAlign: TextAlign.start,
          style: textTheme.bodyText2.copyWith(
              fontSize: AVSize.getFontSize(context, 12),
              color: HaLanColor.gray70,
              height: 2,
              fontWeight: FontWeight.w600),
        ),
      ),
      Container(
        width: AVSize.getSize(context, 6),
      ),
      Container(
        width: AVSize.getSize(context, 200),
        child: Text(
          content,
          style: textTheme.bodyText2.copyWith(
              fontSize: AVSize.getFontSize(context, 12),
              color: HaLanColor.black,
              height: 2,
              fontWeight: FontWeight.w600),
        ),
      )
    ]);
  }
}
