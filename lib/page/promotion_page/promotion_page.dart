import 'package:avwidget/popup_loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/size.dart';
import 'package:halan/main.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/page/promotion_page/promotion_bloc.dart';
import 'package:halan/page/select_place/select_place_page.dart';
import 'package:halan/widget/fail_widget.dart';
class PromotionPage extends StatefulWidget {
  @override
  _PromotionPageState createState() => _PromotionPageState();
}

class _PromotionPageState extends State<PromotionPage> {
  PromotionBloc bloc = PromotionBloc();

  @override
  void initState() {
    bloc.add(PromotionEventGetPromotions());
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PromotionBloc, PromotionState>(
      cubit: bloc,
//      buildWhen: (PromotionState prev, PromotionState state){
//
//         if (state is PromotionStateDismissLoading){
//          Navigator.pop(context);
//        }
//        return true;
//      },
      builder: (BuildContext context, PromotionState state) {
        if (state is PromotionInitial) {
          return promotionScreen(context, state);
        }
        else if (state is PromotionStateFail){
          return Scaffold(
            backgroundColor: HaLanColor.backgroundColor,
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              backgroundColor: HaLanColor.backgroundColor,
              title: Text(
                'Chương trình khuyến mãi',
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontSize: AppSize.getFontSize(context, 18),
                    color: HaLanColor.black),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: HaLanColor.black,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Center(child: FailWidget(message: state.error,onPressed: (){
              bloc.add(PromotionEventGetPromotions());
            },),)
          );
        }
        else if(state is PromotionStateLoading){
          return promotionScreen(context, state);
        }
        return Container();
      },
    );
  }

  Widget promotionScreen(BuildContext context, PromotionState state) {
    Widget body;
    if (state is PromotionInitial) {
      body = promotionCards(context, state);
    }
    else if(state is PromotionStateLoading){
      body = const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      backgroundColor: HaLanColor.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: HaLanColor.backgroundColor,
        title: Text(
          'Chương trình khuyến mãi',
          style: Theme.of(context).textTheme.bodyText2.copyWith(
              fontSize: AppSize.getFontSize(context, 18),
              color: HaLanColor.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: HaLanColor.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.filter),onPressed: (){
//            showModalBottomSheet<dynamic>(context: context, builder: (BuildContext context){
//              return BusesListFilter();
//            },
//              shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.circular(24.0),
//              ),
//            );
          Navigator.of(context).push<dynamic>(SwipeRoute(page:SelectPlacePage()));
          },)
        ],
      ),
      body: body
    );
  }

  Widget promotionCards(BuildContext context, PromotionInitial state) {
    if (state.promotionList.isEmpty) {
      return Center(child: Text('Xin lỗi hiện không có ưu đãi nào',style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: AppSize.getFontSize(context, 20),color: HaLanColor.black),));
    } else {
      return ListView(
        padding: EdgeInsets.all(AppSize.getWidth(context, 16)),
        children: promotionCard(context, state),
      );
    }
  }

  List<Widget> promotionCard(BuildContext context, PromotionInitial state) {
    final List<Widget> result = <Widget>[];
    for (final PopUp popUp in state.promotionList) {
      result.add(Padding(
        padding: EdgeInsets.only(bottom:AppSize.getWidth(context, 16)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSize.getWidth(context, 8)),
          child: Image(
            image: NetworkImage(popUp.link),
//          height: AppSize.getWidth(context, 146),
//        width: AppSize.getWidth(context, 343),
          ),
        ),
      ));
    }
    return result;
  }
}
