import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;

  const CustomTextField({this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        keyboardType: TextInputType.number,
        controller: controller,
        decoration: InputDecoration(
          labelText: 'Establishment Code',
          contentPadding: EdgeInsets.all(16.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () => controller.clear(),
          ),
        ),
      ),
    );
  }
}