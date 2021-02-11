import 'package:flutter/material.dart';

class InformationColumn extends StatelessWidget {
  final String title;
  final String information;

  const InformationColumn({this.title, this.information});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[100],
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.all(
            Radius.circular(5.0) //                 <--- border radius here
        ),
      ),
      // color: Colors.blue[50],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(information, style: TextStyle(color: Colors.black87),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
