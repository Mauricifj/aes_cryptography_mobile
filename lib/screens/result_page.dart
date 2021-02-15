import 'package:flutter/material.dart';

import '../components/information_column.dart';
import '../models/credential_response.dart';

const String title = "CREDENTIALS RESULT";

class ResultPage extends StatefulWidget {
  final CredentialResponse result;

  ResultPage({Key key, this.result}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InformationColumn(title: "CLIENT ID:", information: widget.result.clientId),
            InformationColumn(title: "CLIENT SECRET:", information: widget.result.clientSecret),
            InformationColumn(title: "MASTER AS SUBORDINATE:", information: widget.result.masterAsSubordinate.toString().toUpperCase()),
            InformationColumn(title: "ESTABLISHMENT CODE:", information: widget.result.establishmentCode),
            ElevatedButton(
              key: Key("backButton"),
              child: Text("BACK"),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      ),
    );
  }
}
