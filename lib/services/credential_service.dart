import 'dart:convert';

import 'package:dio/dio.dart';

import 'cryptography_service.dart';
import '../models/credential_request.dart';
import '../models/credential_response.dart';
import '../utils/api_helper.dart';

class CredentialService {
  static Dio _dio;
  static Dio get dio => _dio ?? Dio();

  static Future<CredentialResponse> getCredentials(String establishmentCode) async {
    var json = jsonEncode(CredentialRequest(establishmentCode));
    var data = CryptographyService.encrypt(json);

    APIHelper api = APIHelper(dio: dio);

    var response = await api.get("credentials", queryParameters: {"data": data}).timeout(Duration(seconds: 10));
    return CredentialResponse.fromJson(jsonDecode(CryptographyService.decrypt(response)));
  }
}
