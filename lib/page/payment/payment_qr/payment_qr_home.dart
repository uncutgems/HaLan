import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:avwidget/av_button_widget.dart';
import 'package:avwidget/size_tool.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/routes.dart';
import 'package:halan/base/styles.dart';
import 'package:halan/base/tools.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/page/payment/payment_qr/payment_qr_bloc.dart';
import 'package:halan/widget/fail_widget.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

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
        key: _scaffoldKey,
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
            } else if (state is FailGetDataPaymentQrState) {
              return Center(
                child: FailWidget(
                  message: state.error,
                  onPressed: () {
                    bloc.add(GetDataStringPaymentQrEvent(widget.listTicket));
                  },
                ),
              );
            }
            return Container();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: takeScreenShot,
          backgroundColor: HaLanColor.primaryColor,
          child: const Icon(Icons.camera_alt),
        ),
      ),
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
        if (state.dataString != '')
          QrImage(
            size: AVSize.getSize(context, 160),
            data: state.dataString,
            backgroundColor: HaLanColor.white,
          )
        else
          const Center(
              child: CircularProgressIndicator(
            backgroundColor: HaLanColor.primaryColor,
            valueColor: AlwaysStoppedAnimation<Color>(HaLanColor.white),
          )),
        Container(
          height: AVSize.getSize(context, 16),
        ),
        AVButton(
          color: HaLanColor.primaryColor,
          title: 'Quay về trang chủ',
          onPressed: () {
            Navigator.popUntil(
                context, ModalRoute.withName(RoutesName.homePage));
          },
        ),
      ],
    );
  }

  Future<void> takeScreenShot() async {
    RenderRepaintBoundary boundary = previewContainer.currentContext
        .findRenderObject() as RenderRepaintBoundary;

    if (boundary.debugNeedsPaint) {
      print('Waiting for boundary to be painted.');
      await Future<void>.delayed(const Duration(milliseconds: 20));
      boundary = previewContainer.currentContext.findRenderObject()
          as RenderRepaintBoundary;
    }

    final ui.Image image = await boundary.toImage(pixelRatio: 2.0);
    final ByteData byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);

    ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
  }
}
