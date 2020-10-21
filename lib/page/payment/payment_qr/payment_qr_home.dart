import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:avwidget/av_button_widget.dart';
import 'package:avwidget/size_tool.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/styles.dart';
import 'package:halan/base/tools.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/page/payment/payment_qr/payment_qr_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PaymentQRHomePage extends StatefulWidget {
  const PaymentQRHomePage({Key key, this.totalPrice, this.listTicket})
      : super(key: key);

  final int totalPrice;
  final List<Ticket> listTicket;

  @override
  _PaymentQRHomePageState createState() => _PaymentQRHomePageState();
}

class _PaymentQRHomePageState extends State<PaymentQRHomePage> {
  final PaymentQrBloc bloc = PaymentQrBloc();
  static GlobalKey previewContainer = GlobalKey();

  @override
  void initState() {
    bloc.add(GetDataStringPaymentQrEvent(widget.listTicket));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: previewContainer,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Thanh toán qua QR Code'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: BlocBuilder<PaymentQrBloc, PaymentQrState>(
            cubit: bloc,
            builder: (BuildContext context, PaymentQrState state) {
              if (state is SuccessGetDataPaymentQrState) {
                return _body(context, state);
              } else
                return Container();
            },
          )),
    );
  }

  Widget _body(BuildContext context, SuccessGetDataPaymentQrState state) {
    return Column(
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
          height: AVSize.getSize(context, 24),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Vui lòng chụp ảnh màn hình và sử dụng các phần mềm của Ngân hàng để đọc mã QR Code',
            style: textTheme.bodyText1
                .copyWith(fontWeight: FontWeight.w600, height: 11 / 7),
          ),
        ),
        QrImage(
          size: AVSize.getSize(context, 160),
          data: state.dataString,
          backgroundColor: HaLanColor.white,
        ),
        AVButton(
          title: 'Chụp ảnh màn hình',
          onPressed: takeScreenShot,
        ),
      ],
    );
  }

  Future<void> takeScreenShot() async {
    final RenderRepaintBoundary boundary = previewContainer.currentContext
        .findRenderObject() as RenderRepaintBoundary;
    final ui.Image image = await boundary.toImage();
    final String directory = (await getApplicationDocumentsDirectory()).path;
    final ByteData byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData.buffer.asUint8List();
    print(pngBytes);
    final File imgFile = File('$directory/screenshot.png');
    imgFile.writeAsBytes(pngBytes);
  }
}
