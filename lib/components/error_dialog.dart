import 'package:flutter/material.dart';

void showErrorDialog({title, @required message, @required BuildContext context}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Row(
        children: [
          Icon(Icons.error),
          Text(title ?? "Something went wrong"),
        ],
      ),
      content: Text("$message"),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}