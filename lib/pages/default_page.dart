import 'package:flutter/material.dart';
import 'package:halan/base/color.dart';

class DefaultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return const Scaffold(
      backgroundColor: AppColor.backgroundColor,
    );
  }
}
