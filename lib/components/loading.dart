import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final message;

  const Loading({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(), 
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(message ?? "Loading"),
          ),
        ],
      ),
    );
  }
}
