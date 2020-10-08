import 'package:avwidget/cus_text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:halan/base/color.dart';

class DefaultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: Form(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomerTextFormFieldWidget(
                  title: 'hello',
                  isRequired: true,
                  keyboardType: TextInputType.number,
                  textEditingController: TextEditingController(),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Vui lòng điền mật khẩu';
                    }
                    return null;
                  },

                ),
              ),
              RaisedButton(
                child: Text('Nhấn'),
                onPressed: () {
                    if (_formKey.currentState.validate()) {

                  }
                },
              ),
            ],
          ),
        ));
  }
}
