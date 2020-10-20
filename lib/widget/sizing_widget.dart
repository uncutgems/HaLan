import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

typedef OnWidgetSizeChange = void Function(Size size);

class MeasureSize extends StatefulWidget {
  const MeasureSize({
    Key key,
    @required this.onChange,
    @required this.child,
  }) : super(key: key);
  final Widget child;
  final OnWidgetSizeChange onChange;

  @override
  _MeasureSizeState createState() => _MeasureSizeState();
}

class _MeasureSizeState extends State<MeasureSize> {
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
    return Container(
      key: widgetKey,
      child: widget.child,
    );
  }

  GlobalKey widgetKey = GlobalKey();
  Size oldSize;

  void postFrameCallback(dynamic _) {
    final BuildContext context = widgetKey.currentContext;
    if (context == null) return;

    final Size newSize = context.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    widget.onChange(newSize);
  }
}
