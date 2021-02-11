
import 'package:flutter/material.dart';

import 'result_page.dart';
import '../components/custom_text_field.dart';
import '../components/error_dialog.dart';
import '../components/loading.dart';
import '../services/credential_service.dart';
import '../utils/server_exception.dart';

const String title = "ESTABLISHMENT CODE";

class RequestPage extends StatefulWidget {
  RequestPage({Key key}) : super(key: key);

  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  bool _loading = false;
  bool isTextFieldEmpty = true;
  TextEditingController _controller;

  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(onChangedTextField);
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onChangedTextField() {
    setState(() {
      isTextFieldEmpty = _controller.text.isEmpty;
    });
  }

  bool validate(String establishmentCode) => establishmentCode.contains(RegExp(r'^\d+$'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: _loading ? Loading() : CustomTextField(controller: _controller),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.send),
        onPressed: _loading || isTextFieldEmpty ? null : getCredentials,
        backgroundColor: _loading || isTextFieldEmpty ? Colors.grey : Colors.blue,
      ),
    );
  }

  getCredentials() async {
    setState(() {
      _loading = true;
    });

    var response;
    var establishmentCode = _controller.text;

    if (validate(establishmentCode)) {
      try {
        response = await CredentialService.getCredentials(establishmentCode);
      } on ServerException catch (exception) {
        showErrorDialog(message: exception.parsedResponse, context: context);
      } catch (e) {
        print(e.toString());
        showErrorDialog(
          title: "Error",
          message: "Something went wrong\nTry again later",
          context: context,
        );
      }

      if (response != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultPage(result: response),
          ),
        );
      }
    } else {
      showErrorDialog(
        title: "INVALID",
        message: "Verify your establishment code and try again",
        context: context,
      );
    }

    setState(() {
      _loading = false;
    });
  }
}
