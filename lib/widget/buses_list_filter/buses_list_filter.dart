import 'package:avwidget/av_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/size.dart';
import 'package:halan/widget/buses_list_filter/buses_list_filter_bloc.dart';

class BusesListFilter extends StatefulWidget {
  @override
  _BusesListFilterState createState() => _BusesListFilterState();
}

class _BusesListFilterState extends State<BusesListFilter> {
  BusesListFilterBloc bloc = BusesListFilterBloc();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusesListFilterBloc,BusesListFilterState>(
      cubit:bloc ,
      builder:(BuildContext context,BusesListFilterState state) {
        if(state is BusesListFilterInitial) {
          return Container(
            decoration: BoxDecoration(
              color: HaLanColor.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(
                  AppSize.getWidth(context, 24),
                ),
                topLeft: Radius.circular(
                  AppSize.getWidth(context, 24),
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(AppSize.getWidth(context, 16)),
            
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        Center(
                          child: Text(
                            'Bộ lọc',
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(
                                fontSize: AppSize.getWidth(context, 18),
                                color: HaLanColor.black),
                          ),
                        ),
                        Container(height: AppSize.getWidth(context, 16),),
                        Container(height: AppSize.getWidth(context, 1),
                          color: HaLanColor.borderColor,),
                        Container(height: AppSize.getWidth(context, 16),),
                        Text('THỜI GIAN KHỞI HÀNH', style: Theme
                            .of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(color: HaLanColor.primaryColor,
                            fontSize: AppSize.getFontSize(context, 12)),),
                        Container(height: AppSize.getWidth(context, 16),),
                        Row(children: <Widget>[
                          Expanded(
                            child: AVButton(color:state.time==1?HaLanColor.primaryColor: HaLanColor.gray30,
                              onPressed: () {
                                bloc.add(BusesListFilterEventClickTime(1));
                              },
                              title: 'Sáng (6h - 12h)',
                              textColor:state.time==1?HaLanColor.white: HaLanColor.black,
//                      width: AppSize.getWidth(context, 107),
                              fontSize: 12,
                              height: AppSize.getWidth(context, 32),
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(width: AppSize.getWidth(context, 8),),
                          Expanded(
                            child: AVButton(color: state.time==2?HaLanColor.primaryColor: HaLanColor.gray30,
                              onPressed: () {
                                bloc.add(BusesListFilterEventClickTime(2));
                              },
                              title: 'Trưa (12h - 18h)',
                              textColor: state.time==2?HaLanColor.white: HaLanColor.black,
//                      width: AppSize.getWidth(context, 113),
                              fontSize: 12,
                              height: AppSize.getWidth(context, 32),
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(width: AppSize.getWidth(context, 8),),
                          Expanded(
                            child: AVButton(color:state.time==3?HaLanColor.primaryColor: HaLanColor.gray30,
                              onPressed: () {

                                bloc.add(BusesListFilterEventClickTime(3));
                              },
                              title: 'Tối (18h - 6h)',
                              textColor: state.time==3?HaLanColor.white:HaLanColor.black,
//                      width: AppSize.getWidth(context, 97),
                              fontSize: 12,
                              height: AppSize.getWidth(context, 32),
                              fontWeight: FontWeight.normal,
                            ),
                          )
                        ],
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(child: AVButton(textColor: HaLanColor.white,
                        title: 'Đặt lại',
                        onPressed: () {
                          bloc.add(BusesListFilterEventClickTime(-1));
                        },
                        color: HaLanColor.gray60,)),
                      Container(width: AppSize.getWidth(context, 17),),
                      Expanded(child: AVButton(textColor: HaLanColor.white,
                        title: 'Áp dụng',
                        onPressed: () {},
                        color: HaLanColor.primaryColor,))
                    ],
                  ),
                ],
              ),
            ),
          );
        }
        return Container();
      }
    );
  }
}
