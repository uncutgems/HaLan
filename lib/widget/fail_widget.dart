import 'package:flutter/material.dart';
import 'package:halan/base/color.dart';

class FailWidget extends StatefulWidget {
  const FailWidget({Key key, @required this.message, @required this.onPressed})
      : super(key: key);

  final String message;
  final VoidCallback onPressed;

  @override
  _FailWidgetState createState() => _FailWidgetState();
}

class _FailWidgetState extends State<FailWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.message ?? 'Không có chuyến đi nào',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          RaisedButton(
              color: HaLanColor.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: HaLanColor.primaryColor)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Icon(
                    Icons.refresh,
                    color: HaLanColor.primaryColor,
                  ),
                  Text(
                    'Thử lại',
                    style: Theme.of(context).textTheme.subtitle2.copyWith(color: HaLanColor.primaryColor),
                  )
                ],
              ),
              onPressed: widget.onPressed),
        ],
      ),
    );
  }
}
