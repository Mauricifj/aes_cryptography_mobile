import 'package:aes_cryptography_mobile/components/custom_text_field.dart';
import 'package:flutter/material.dart';

import 'result_page.dart';
import '../components/custom_form.dart';
import '../components/error_dialog.dart';
import '../components/loading.dart';
import '../services/credential_service.dart';

const String title = "ESTABLISHMENT CODE";

class RequestPage extends StatefulWidget {
  RequestPage({Key key}) : super(key: key);

  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  bool _loading = false;
  bool _isValid = false;
  TextEditingController _establishmentCodeController;
  final _formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
    _establishmentCodeController = TextEditingController();
  }

  void dispose() {
    _establishmentCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: _loading ? Loading() : CustomForm(formKey: _formKey, children: [textFieldForEstablishmentCode()]),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.send),
        onPressed: _isValid && !_loading ? getCredentials : null,
        backgroundColor: _isValid && !_loading ? Colors.blue : Colors.grey,
      ),
    );
  }

  getCredentials() async {
    setState(() {
      _loading = true;
    });

    var response;
    var establishmentCode = _establishmentCodeController.text;

    try {
      response = await CredentialService.getCredentials(establishmentCode);
    } catch (e) {
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

    setState(() {
      _loading = false;
    });
  }

  Widget textFieldForEstablishmentCode() {
    return CustomTextField(
      label: "ESTABLISHMENT CODE",
      controller: _establishmentCodeController,
      onChanged: (value) {
        _formKey.currentState.validate();
        setState(() {
          _isValid = validate(value);
        });
      },
      validator: (value) {
        if (value.isEmpty || value == null) return "Please enter your establishment code";
        if (!validate(value)) return "Please verify your establishment code";
        return null;
      },
      keyboardType: TextInputType.number,
    );
  }

  bool validate(String establishmentCode) => _establishmentCodeController.text.contains(RegExp(r'^\d+$'));
}
