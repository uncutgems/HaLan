import 'package:flutter/material.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/size.dart';
import 'package:halan/base/tool.dart';
import 'package:halan/model/entity.dart';

class TransshipmentSelections extends StatefulWidget {
  const TransshipmentSelections({Key key, this.point, this.transshipmentPoint}) : super(key: key);

  final Point point;
  final ValueChanged<Point> transshipmentPoint;
  @override
  _TransshipmentSelectionsState createState() => _TransshipmentSelectionsState();
}

class _TransshipmentSelectionsState extends State<TransshipmentSelections> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(child:Text('Chọn điểm trung chuyển',style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.bold,fontSize: AppSize.getFontSize(context, 18)),),),
//        Container(height: AppSize.getWidth(context, 16),),
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(AppSize.getWidth(context, 16)),
            children: transshipmentPoint(context)
          ),
        ),
      ],
    );
  }
  List<Widget> transshipmentPoint(BuildContext context){
    final List<Widget> result = <Widget>[];
    for (final Point point in widget.point.listTransshipmentPoint){
      result.add(GestureDetector(
        onTap: (){
          widget.transshipmentPoint(point);
        },
        child: Padding(
          padding:  EdgeInsets.only(bottom:AppSize.getWidth(context, 16)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Icon(Icons.location_on,),
                  Container(width: AppSize.getWidth(context, 16),),
                  Text(point.name,style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: AppSize.getFontSize(context, 14)),),
                ],
              ),

              Text(currencyFormat(point.transshipmentPrice.toInt(), ' VNĐ'),style:Theme.of(context).textTheme.bodyText2.copyWith(fontSize: AppSize.getFontSize(context, 14),color: HaLanColor.red100,fontWeight: FontWeight.bold) ,)
            ],
          ),
        ),
      ));
    }
    return result;
  }
}
