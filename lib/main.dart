import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'screens/request_page.dart';
import 'services/credential_service.dart';

void main(dio) {
  CredentialService _credentialService = CredentialService(dio: dio ?? Dio());
  runApp(MyApp(_credentialService));
}

class MyApp extends StatelessWidget {
  final CredentialService credentialService;

  MyApp(this.credentialService);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AES Mobile',
      theme: ThemeData.dark(),
      home: RequestPage(credentialService: credentialService),
    );
  }
}
