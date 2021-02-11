import 'dart:io';

import 'package:aes_cryptography_mobile/utils/api_helper.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class DioAdapterMock extends Mock implements DefaultHttpClientAdapter {}

void main() {
  final Dio dio = Dio();

  setUp(() {
    dio.httpClientAdapter = setupDioAdapterMock(dio);
  });

  test('Should return encrypted credentials', () async {
    // ARRANGE
    final encrypted =
        "PYhDXK4rvT1uRFEvtDg+F5J9UUWBsLWEOKxa4QBFamsFGYFzDgSH2CJ4SHZDpJFFSOeCLzgY02GJGP/vXbq8Q+dfyUf/hmEiUidphnl2EiUk0L3NiOaljj9791PsjqOUrPxkYOdqLDGQJdONxtauomRwSRCPuBFhISj6bkGqcP8uNbAPd/amd+rS1QOTGQ35rgEHlGXfse8MgPvQMBHCpvwf0czsS15Ps+UkYKnLxDg=";
    final httpResponse = ResponseBody.fromString(encrypted, 200);
    final api = APIHelper(dio: dio);

    when(dio.httpClientAdapter.fetch(any, any, any)).thenAnswer((_) async => httpResponse);

    // ACT
    final response = await api.get("credentials", queryParameters: {"data": "encrypted_establishment_code"});

    // ASSERT
    expect(response, equals(encrypted));
  });
}

DioAdapterMock setupDioAdapterMock(Dio dio) {
  DioAdapterMock dioAdapterMock = DioAdapterMock();
  // bypass CERTIFICATE_VERIFY_FAILED
  dioAdapterMock.onHttpClientCreate = (HttpClient client) {
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return client;
  };
  return dioAdapterMock;
}