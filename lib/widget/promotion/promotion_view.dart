import 'package:avwidget/av_button_widget.dart';
import 'package:avwidget/cus_text_form_field_widget.dart';
import 'package:avwidget/size_tool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/styles.dart';
import 'package:halan/base/tool.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/widget/promotion/promotion_bloc.dart';

class PromotionWidget extends StatefulWidget {
  const PromotionWidget(
      {Key key,
      this.userId,
      this.routeId,
      this.totalMoney,
      this.promotionObject})
      : super(key: key);

  final String userId;
  final String routeId;
  final int totalMoney;
  final ValueChanged<PromotionObject> promotionObject;

  @override
  _PromotionWidgetState createState() => _PromotionWidgetState();
}

class _PromotionWidgetState extends State<PromotionWidget> {
  final PromotionWidgetBloc bloc = PromotionWidgetBloc();
  final TextEditingController _couponController = TextEditingController();
  final FocusNode _couponFocus = FocusNode();

  @override
  void dispose() {
    _couponController.dispose();
    _couponFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PromotionWidgetBloc, PromotionWidgetState>(
      cubit: bloc,
      builder: (BuildContext context, PromotionWidgetState state) {

        if (state is SuccessCheckPromotionState) {
          return _body(context, state);
        } else if (state is FailCheckPromotionState) {
          return _body(context, state);
        } else if (state is PromotionWidgetInitial) {
          return _body(context, state);
        } else
          return Container();
      },
      buildWhen: (PromotionWidgetState prev, PromotionWidgetState current) {
        if (current is CallBackPromotionState) {
          widget.promotionObject(current.promotionObject);
          return false;
        } else
          return true;
      },
    );
  }

  Widget _body(BuildContext context, PromotionWidgetState state) {
    final bool isLoading = state is SuccessCheckPromotionState &&
        state.promotionObject.promotionId == '-1';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'M?? khuy???n m??i (n???u c??)',
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
              height: 48,
              color: HaLanColor.blue,
              title: !isLoading ? '??p d???ng' : '',
              trailingIcon: isLoading
                  ? const CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(HaLanColor.white))
                  : Container(),
              onPressed: () {
                bloc.add(CheckPromotionCodeEvent(
                    promotionCode: _couponController.text,
                    userId: 'CUS1844349567182556',
                    routeId: 'RT1203136018083134'));
              },
            ),
          ],
        ),
        if (state is SuccessCheckPromotionState &&
            state.promotionObject.promotionId != '-1')
          Text(promotionMessage(state.promotionObject, 240000),
              style: textTheme.subtitle2.copyWith(
                color: HaLanColor.green,
                fontWeight: FontWeight.normal,
                fontSize: AVSize.getFontSize(context, 12),
              ))
        else if (state is FailCheckPromotionState)
          Text('M?? khuy???n m??i kh??ng h???p l???',
              style: textTheme.subtitle2.copyWith(
                color: HaLanColor.cancelColor,
                fontWeight: FontWeight.normal,
                fontSize: AVSize.getFontSize(context, 12),
              ))
      ],
    );
  }
}

String promotionMessage(PromotionObject promotionObject, int totalPrice) {
  print('kingggggggggggggggggggggggggggggg ${promotionObject.price}');
  if ((promotionObject.price != -1 || promotionObject.percent != -1) &&
      totalPrice > promotionObject.minPriceApply.toInt()) {
    if (promotionObject.price != -1) {
      return 'M?? khuy???n m??i h???p l???, b???n ???????c gi???m ${currencyFormat(promotionObject.price.toInt(), '??')} tr??n t???ng h??a ????n';
    } else
      return 'M?? khuy???n m??i h???p l???, b???n ???????c gi???m ${100 * promotionObject.percent} % tr??n t???ng h??a ????n';
  } else
    return 'B???n c???n mua th??m ${promotionObject.minPriceApply.toInt() - totalPrice} ????? t???n h?????ng khuy???n m??i';
}
