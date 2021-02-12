import 'package:aes_cryptography_mobile/utils/api_helper.dart';
import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockDio extends Mock implements Dio {}

void main() {
  test('Should return encrypted credentials', () async {
    // ARRANGE
    final mockDio = MockDio();
    final encryptedCredentials =
        "PYhDXK4rvT1uRFEvtDg+F5J9UUWBsLWEOKxa4QBFamsFGYFzDgSH2CJ4SHZDpJFFSOeCLzgY02GJGP/vXbq8Q+dfyUf/hmEiUidphnl2EiUk0L3NiOaljj9791PsjqOUrPxkYOdqLDGQJdONxtauomRwSRCPuBFhISj6bkGqcP8uNbAPd/amd+rS1QOTGQ35rgEHlGXfse8MgPvQMBHCpvwf0czsS15Ps+UkYKnLxDg=";
    final queryParameters = {"data": "encrypted_establishment_code"};
    when(mockDio.get(any, queryParameters: queryParameters))
        .thenAnswer((invocation) async => await Future.value(Response(data: encryptedCredentials, statusCode: 200)));
    final api = APIHelper(dio: mockDio);

    // ACT
    final response = await api.get("credentials", queryParameters: queryParameters);

    // ASSERT
    expect(response, encryptedCredentials);
  });
}
