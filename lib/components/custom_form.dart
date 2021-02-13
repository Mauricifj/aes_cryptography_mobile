import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey;
  final List<Widget> children;

  const CustomForm({
    Key key,
    @required GlobalKey<FormState> formKey,
    @required this.children,
  })  : _formKey = formKey,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: children,
        ),
      ),
    );
  }
}
