import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('AES Mobile app', () {
    final establishmentCodeField = find.byValueKey('establishmentCodeField');
    final sendButton = find.byValueKey('sendButton');
    final backButon = find.byValueKey('backButton');

    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });

    test('Given app is ran When valid establishment code is entered Then result page is shown', () async {
      await driver.tap(establishmentCodeField);
      await driver.enterText('123456789');
      await driver.tap(sendButton);

      final clientId = find.text('CLIENT_ID');
      final clientSecret = find.text('CLIENT_SECRET');
      final masterAsSubordinate = find.text('TRUE');
      final establishmentConde = find.text('ESTABLISHMENT_CODE');

      expect(await driver.getText(clientId), 'CLIENT_ID');
      expect(await driver.getText(clientSecret), 'CLIENT_SECRET');
      expect(await driver.getText(masterAsSubordinate), 'TRUE');
      expect(await driver.getText(establishmentConde), 'ESTABLISHMENT_CODE');

      await driver.tap(backButon);
    });

    test('Given app is ran When invalid establishment code is entered Then verify message is shown', () async {
      await driver.tap(establishmentCodeField);
      await driver.enterText('ABCDEFGHI');
      await driver.tap(sendButton);

      final verify = find.text('Please verify your establishment code');

      expect(await driver.getText(verify), 'Please verify your establishment code');
    });
  });
}
