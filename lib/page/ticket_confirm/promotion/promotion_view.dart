import 'package:avwidget/av_button_widget.dart';
import 'package:avwidget/cus_text_form_field_widget.dart';
import 'package:avwidget/size_tool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/styles.dart';
import 'package:halan/page/promotion_page/promotion_bloc.dart';

class PromotionWidget extends StatefulWidget {
  @override
  _PromotionWidgetState createState() => _PromotionWidgetState();
}

class _PromotionWidgetState extends State<PromotionWidget> {
  final PromotionBloc bloc = PromotionBloc();
  final TextEditingController _couponController = TextEditingController();
  final FocusNode _couponFocus = FocusNode();

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PromotionBloc, PromotionState>(
      cubit: bloc,
      builder: (BuildContext context, PromotionState state) {
        if (state is PromotionInitial) {
          return _body(context, state);
        } else
          return Container();
      },
    );
  }

  Widget _body(BuildContext context, PromotionInitial state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Mã khuyến mãi (nếu có)',
          style: textTheme.subtitle2.copyWith(
              color: HaLanColor.black,
              fontWeight: FontWeight.w500,
              fontSize: AVSize.getFontSize(context, 14)),
        ),
        Container(
          height: AVSize.getSize(context, 10),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: CustomerTextFormFieldWidget(
                textEditingController: _couponController,
                keyboardType: TextInputType.text,
                focusNode: _couponFocus,
              ),
            ),
            Container(
              width: AVSize.getSize(context, 8),
            ),
            AVButton(
              width: 94,
              height: 48,
              color: HaLanColor.blue,
              title: 'Áp dụng',
              onPressed: () {
                print('coupon');
              },
            ),
          ],
        ),
      ],
    );
  }
}
