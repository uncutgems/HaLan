import 'package:flutter/material.dart';

typedef OnDone = void Function(String text);
typedef PinBoxDecoration = BoxDecoration Function(Color borderColor);

class PinCodeTextField extends StatefulWidget {
  const PinCodeTextField(
      {Key key,
        this.maxLength= 4,
        this.controller,
        this.hideCharacter= false,
        this.highlight=false,
        this.highlightColor,
        this.pinBoxDecoration,
        this.onDone,
        this.defaultBorderColor= Colors.transparent,
        this.width= 40.0,
        this.height= 40.0,
        this.textSize= 20.0,
        this.textColor= Colors.white})
      : super(key: key);
  final int maxLength;
  final TextEditingController controller;
  final bool hideCharacter;
  final bool highlight;
  final Color highlightColor;
  final Color defaultBorderColor;
  final PinBoxDecoration pinBoxDecoration;
  final OnDone onDone;
  final double width;
  final double height;
  final Color textColor;
  final double textSize;



  @override
  State<StatefulWidget> createState() {
    return PinCodeTextFieldState();
  }
}

class PinCodeTextFieldState extends State<PinCodeTextField> {
  FocusNode focusNode =  FocusNode();
  String text = '';
  int currentIndex = 0;
  List<String> strList = <String>[];
  bool hasFocus = false;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.maxLength; i++) {
      strList.add('');
    }

    focusNode.addListener(() {
      setState(() {
        hasFocus = focusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            if (hasFocus) {
              FocusScope.of(context).requestFocus(FocusNode());
              Future<void>.delayed(const Duration(milliseconds: 100), () {
                FocusScope.of(context).requestFocus(focusNode);
              });
            } else {
              FocusScope.of(context).requestFocus(focusNode);
            }
          },
          child: _buildPinCodeRow(context),
        ),
        Container(
          width: 0.1,
          child: TextField(
            autofocus: true,
            focusNode: focusNode,
            controller: widget.controller,
            keyboardType: TextInputType.number,
            style: const TextStyle(
              color: Colors.transparent,
            ),
            decoration: const InputDecoration(
              fillColor: Colors.transparent,
              border: InputBorder.none,
            ),
            cursorColor: Colors.transparent,
            maxLength: widget.maxLength,
            onChanged: _onTextChanged,
          ),
        ),
      ],
    );
  }

  void _onTextChanged(String text) {
    setState(() {
      this.text = text;
      if (text.length < currentIndex) {
        strList[text.length] = '';
      } else {
        strList[text.length - 1] =
            widget.hideCharacter ? '\u25CF' : text[text.length - 1];
      }
      currentIndex = text.length;
    });
    if (text.length == widget.maxLength) {
      FocusScope.of(context).requestFocus(FocusNode());
      widget.onDone(text);
    }
  }

  Widget _buildPinCodeRow(BuildContext context) {
    final List<Widget> pinCodes = List<Widget>.generate(widget.maxLength, (int i) {
      return _buildPinCode(i, context);
    });

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      verticalDirection: VerticalDirection.down,
      children: pinCodes,
    );
  }

  Widget _buildPinCode(int i, BuildContext context) {
    Color borderColor;
    BoxDecoration boxDecoration;
    if (widget.highlight &&
        hasFocus &&
        (i == text.length ||
            (i == text.length - 1 && text.length == widget.maxLength))) {
      borderColor = widget.highlightColor;
    } else {
      borderColor = widget.defaultBorderColor;
    }
    if (widget.pinBoxDecoration == null) {
      boxDecoration = BoxDecoration(
          border: Border.all(
            color: borderColor,
            width: 2.0,
          ),
          borderRadius: const BorderRadius.all( Radius.circular(5.0)));
    } else {
      boxDecoration = widget.pinBoxDecoration(borderColor);
    }
    return Padding(
      padding: const EdgeInsets.only(
        left: 0.0,
        right: 8.0,
      ),
      child: Container(
        child: Center(
          child: Text(
            strList[i],
            style: TextStyle(
              color: widget.textColor,
              fontSize: widget.textSize,
            ),
          ),
        ),
        decoration: boxDecoration,
        width: (MediaQuery.of(context).size.width - 82) / widget.maxLength,
        height: widget.height,
      ),
    );
  }
}

class RoundEditText extends StatelessWidget {
  const RoundEditText(
      this._fillColor,
      this._textColor,
      this._radius,
      this._hintText,
      this._controller,
      this._textSize,
      this._keyboardType,
      this._flex,
      this._onChanged,
      this._enable,
      );
  final Color _fillColor;
  final Color _textColor;
  final double _radius;
  final String _hintText;
  final TextEditingController _controller;
  final double _textSize;
  final ValueChanged _onChanged;
  final TextInputType _keyboardType;
  final int _flex;
  final bool _enable;



  @override
  Widget build(BuildContext context) {
    return  Expanded(
        flex: _flex,
        child:  TextField(
          controller: _controller,
          style:  TextStyle(
            fontSize: _textSize,
            color: _textColor,
            fontWeight: FontWeight.normal,
          ),
          onChanged: _onChanged,
          enabled: _enable,
          keyboardType: _keyboardType,
          decoration:  InputDecoration(
            contentPadding: const EdgeInsets.only(
                top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
            hintText: _hintText,
            hintStyle:  TextStyle(
              fontSize: _textSize,
              color: _textColor,
            ),
            fillColor: _fillColor,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(_radius),
              borderSide: const BorderSide(color: Colors.white),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(_radius),
              borderSide: const BorderSide(color: Colors.white),
            ),
          ),
        ));
  }
}
