import 'package:test/test.dart';
import 'package:aes_cryptography_mobile/services/cryptography_service.dart';

void main() {
  test('Should encrypt and decrypt text', () {
    // ARRANGE
    String text = "abcdef";

    // ACT
    String encrypted = CryptographyService.encrypt(text);

    // ASSERT
    expect(CryptographyService.decrypt(encrypted), text);
  });
}
