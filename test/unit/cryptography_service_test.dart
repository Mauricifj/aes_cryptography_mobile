import 'dart:convert';

import 'package:test/test.dart';

import 'package:aes_cryptography_mobile/models/credential_response.dart';
import 'package:aes_cryptography_mobile/services/cryptography_service.dart';

void main() {
  test('Given example text When encrypt and decrypt are called Then the same example text is received', () {
    // ARRANGE
    String text = "example_test";

    // ACT
    String encrypted = CryptographyService.encrypt(text);
    String decrypted = CryptographyService.decrypt(encrypted);

    // ASSERT
    expect(decrypted, text);
  });

  test('Given encrypted credential When decrypt is called Then the same credential is received', () {
    // ARRANGE
    String encrypted =
        "6B4WZFi6cD7f4Vrgl2evgkjUo6k7L78ZKWnU4Qu6ltBJMrJ2zWbt1EZiOfLmotW1sWzLd3QVGhd/npigTXofBgnCK01bFX0gPDOYyBP8Rj/HOiJZUnz6c/1Zo7qISne4CQ3kg38whzED+8+skF22zIyHNcV3R2id/VMzwy/ye3w=";

    // ACT
    String decrypted = CryptographyService.decrypt(encrypted);
    final response = CredentialResponse.fromJson(jsonDecode(decrypted));

    // ASSERT
    expect(response.clientId, "CLIENT_ID");
    expect(response.clientSecret, "CLIENT_SECRET");
    expect(response.masterAsSubordinate, true);
    expect(response.establishmentCode, "ESTABLISHMENT_CODE");
  });
}
