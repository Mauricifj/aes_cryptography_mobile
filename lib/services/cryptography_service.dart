import 'package:encrypt/encrypt.dart';

class CryptographyService {
  static final _key = Key.fromBase16("892C8E496E1E33355E858B327BC238A939B7601E96159F9E9CAD0519BA5055CD");
  static final _iv = IV.fromBase64("Syv6onGX8yIuMZbmOSPH/Q==");
  static Encrypter get _encrypter => Encrypter(AES(_key, mode: AESMode.cbc, padding: 'PKCS7'));

  static String decrypt(String encrypted) {
    return _encrypter.decrypt(Encrypted.from64(encrypted), iv: _iv);
  }

  static String encrypt(String plainText) {
    return _encrypter.encrypt(plainText, iv: _iv).base64;
  }
}
