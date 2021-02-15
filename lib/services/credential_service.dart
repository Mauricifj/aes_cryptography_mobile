import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'cryptography_service.dart';
import '../models/credential_request.dart';
import '../models/credential_response.dart';
import '../utils/api_helper.dart';

class CredentialService {
  final Dio _dio;

  CredentialService({@required Dio dio}) : _dio = dio;

  Future<CredentialResponse> getCredentials(String establishmentCode) async {
    var json = jsonEncode(CredentialRequest(establishmentCode));
    var encrypted = CryptographyService.encrypt(json);

    APIHelper api = APIHelper(dio: _dio);

    var response = await api.get("credentials", queryParameters: {"data": encrypted}).timeout(Duration(seconds: 10));
    return CredentialResponse.fromJson(jsonDecode(CryptographyService.decrypt(response)));
  }
}
