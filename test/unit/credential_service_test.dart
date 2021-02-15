import 'package:aes_cryptography_mobile/utils/api_helper.dart';
import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../mocks/mocks.dart';

void main() {
  test(
      'Given encrypted credential request When get credential is called Then encrypted credential is received',
      () async {
    // ARRANGE
    final mockDio = MockDio();
    final encryptedCredentials =
        "PYhDXK4rvT1uRFEvtDg+F5J9UUWBsLWEOKxa4QBFamsFGYFzDgSH2CJ4SHZDpJFFSOeCLzgY02GJGP/vXbq8Q+dfyUf/hmEiUidphnl2EiUk0L3NiOaljj9791PsjqOUrPxkYOdqLDGQJdONxtauomRwSRCPuBFhISj6bkGqcP8uNbAPd/amd+rS1QOTGQ35rgEHlGXfse8MgPvQMBHCpvwf0czsS15Ps+UkYKnLxDg=";
    when(mockDio.get(any, queryParameters: anyNamed("queryParameters")))
        .thenAnswer((invocation) => Future.value(Response(data: encryptedCredentials, statusCode: 200)));
    final api = APIHelper(dio: mockDio);

    // ACT
    final response = await api.get("credentials", queryParameters: {"data": "encrypted_credential_request"});

    // ASSERT
    expect(response, encryptedCredentials);
  });
}
