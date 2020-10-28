
import 'package:avwidget/av_alert_dialog_widget.dart';
import 'package:avwidget/av_button_widget.dart';
import 'package:avwidget/avwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halan/base/routes.dart';
import 'package:halan/base/size.dart';
import 'package:halan/page/splash/splash_bloc.dart';
class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  SplashBloc splashBloc = SplashBloc();
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {

    splashBloc.add(SplashEventGetData());
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    final CurvedAnimation curvedAnimation =
        CurvedAnimation(parent: animationController, curve: Curves.slowMiddle);
    animation = Tween<double>(begin: -700, end: 700).animate(curvedAnimation)
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          animationController.reset();
          animationController.forward();
        } else {}
      });
    animationController.forward();
//    Timer(
//        const Duration(seconds: 5),
//        () => Navigator.pushNamed(
//              context,
//              RoutesName.homePage,
//            ));
    super.initState();
  }

  @override
  void dispose() {
    if (animationController != null) {
      animationController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashBloc, SplashState>(
        cubit: splashBloc,
        buildWhen: (SplashState prev,SplashState state){
          if(state is SplashStateFail){
            showDialog<dynamic>(context: context,builder: (BuildContext context){
              return AVAlertDialogWidget(
                title: 'Chú ý',
                content: state.error,
                context: context,
                bottomWidget: AVButton(
                  title:'Thử lại',
                  onPressed: (){
                    Navigator.pop(context);
                    splashBloc.add(SplashEventGetData());
                  },
                ),
              );
            });
            return false;
          }
          else if(state is SplashStateForward){
            Navigator.pushReplacementNamed(context, RoutesName.busBookingPage);
            return false;
          }
          return true;
        },
        builder: (BuildContext context, SplashState state) {
          if (state is SplashInitial) {
            return _mainScreen(context);
          }
          return const Material();
        });
  }

  Widget _mainScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: AVColor.white,
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              height: AppSize.getHeight(context, 80),
            ),
            SvgPicture.asset(
              'assets/halan_logo.svg',
              height: AppSize.getWidth(context, 98),
              width: AppSize.getWidth(context, 220),
            ),
            Container(
              height: AppSize.getHeight(context, 60),
            ),
            AnimatedBuilder(
              animation: animation,
              builder: (BuildContext context, Widget child) {
                return Stack(
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/building.svg',
                      height: AppSize.getWidth(context, 320),
                      width: AppSize.getWidth(context, 467),
                    ),
                    Positioned(
                      top: AppSize.getWidth(context, 189),
                      left: animation.value,
                      child: Container(
                          height: AppSize.getWidth(context, 130),
                          width: AppSize.getWidth(context, 265),
                          child: const Image(
                              image: AssetImage('assets/car1.png'))),
                    )
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
