import 'package:flutter/material.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/size.dart';

class Countdown extends AnimatedWidget {
  const Countdown({
    Key key,
    this.animation,
    this.controller,
    this.onPressed,
  }) : super(key: key, listenable: animation);
  final Animation<int> animation;
  final AnimationController controller;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final Duration clockTimer = Duration(seconds: animation.value);

    final String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${(clockTimer.inSeconds.remainder(60) % 60).toString().padLeft(2, '0')}';
    if (animation.value > 0) {
      return Row(
        children: <Widget>[
          Container(
            child: Text(
              'Không nhận được mã?',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(fontSize: AppSize.getFontSize(context, 14))
                  .copyWith(fontWeight: FontWeight.w400),
            ),
          ),
          Text(
            ' Gửi lại (${timerText}s)',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(fontSize: AppSize.getFontSize(context, 14))
                .copyWith(fontWeight: FontWeight.w400)
                .copyWith(color: HaLanColor.gray60),
          ),
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          Container(
            child: Text(
              'Mã OTP không chính xác hoăc đã hết hạn',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(fontSize: AppSize.getFontSize(context, 14))
                  .copyWith(fontWeight: FontWeight.w400),
            ),
          ),
          Container(
            height: AppSize.getHeight(context, 4),
          ),
          GestureDetector(
            onTap: onPressed,
            child: Text(
              ' Gửi lại',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(fontSize: AppSize.getFontSize(context, 14))
                  .copyWith(fontWeight: FontWeight.w400)
                  .copyWith(color: HaLanColor.blue),
            ),
          ),
        ],
      );
    }
  }
}
