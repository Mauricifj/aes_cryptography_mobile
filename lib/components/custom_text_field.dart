import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String Function(String) validator;
  final Function(String) onChanged;
  final String label;
  final TextInputType keyboardType;

  const CustomTextField({this.label, @required this.controller, this.onChanged, this.validator, this.keyboardType = TextInputType.text});

  bool hasOnlyDigits(String establishmentCode) => establishmentCode.contains(RegExp(r'^\d+$'));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        onChanged: onChanged,
        validator: validator,
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          contentPadding: EdgeInsets.all(16.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              controller.clear();
              Form.of(context)?.validate();
            },
          ),
        ),
      ),
    );
  }
}
