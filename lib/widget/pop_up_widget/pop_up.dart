import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/size.dart';
import 'package:halan/base/styles.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/widget/fail_widget.dart';
import 'package:halan/widget/pop_up_widget/pop_up_bloc.dart';

class PopUpWidget extends StatefulWidget {
  @override
  _PopUpWidgetState createState() => _PopUpWidgetState();
}

class _PopUpWidgetState extends State<PopUpWidget> {
  PopUpBloc popUpBloc = PopUpBloc();

  @override
  void initState() {
    popUpBloc.add(GatDataPopUpEvent());
    super.initState();
  }

  @override
  void dispose() {
    popUpBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopUpBloc, PopUpState>(
      cubit: popUpBloc,
      builder: (BuildContext context, PopUpState state) {
        if (state is DisplayPopUpState) {
          return popUpPromotion(context, state);
        } else if (state is LoadingPopUpState) {
          return _loading(context);
        } else if (state is FailPopUpState) {
          Center(
            child: FailWidget(
              message: state.errorMessage,
              onPressed: () {
                popUpBloc.add(GatDataPopUpEvent());
              },
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget popUpPromotion(BuildContext context, DisplayPopUpState state) {
    print('${state.promotionList.length}');
    return Padding(
      padding: EdgeInsets.only(
        top: AppSize.getWidth(context, 0),
        bottom: AppSize.getHeight(context, 32),
      ),
      child: Column(
        children: <Widget>[
          CarouselSlider.builder(
            itemCount: state.promotionList.length,
            options: CarouselOptions(
                scrollDirection: Axis.horizontal,
                enableInfiniteScroll: true,
                enlargeCenterPage: true,
                viewportFraction: 0.9,
                aspectRatio: 16 / 9,
                autoPlay: true,
                height: AppSize.getWidth(context, 193),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                onPageChanged: (int index, CarouselPageChangedReason reason) {
//                    bloc.add(ChangedPagePopularFilmEvent(index, filmList));
                }),
            itemBuilder: (BuildContext context, int index) {
              final PopUp popUp = state.promotionList[index];
              return GestureDetector(
                onTap: () {
//              popUp.id == null ? print('not yet') : null;
                  print('${state.promotionList.length}');
                },
                child: Container(
                  height: AppSize.getWidth(context, 193),
                  decoration: popUpBoxDecoration.copyWith(
                    image: popUp.link != null
                        ? DecorationImage(
                            image: NetworkImage(
                              popUp.link,
                            ),
                            fit: BoxFit.fitWidth,
                          )
                        : null,
                  ),
                  child: popUp.id == null
                      ? const Center(child: CircularProgressIndicator())
                      : null,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _loading(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSize.getWidth(context, 16)),
      child: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(HaLanColor.primaryColor),
        ),
      ),
    );
  }
}
