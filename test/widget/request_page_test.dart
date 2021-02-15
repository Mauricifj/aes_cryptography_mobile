import 'package:aes_cryptography_mobile/components/information_column.dart';
import 'package:aes_cryptography_mobile/models/credential_response.dart';
import 'package:aes_cryptography_mobile/screens/request_page.dart';
import 'package:aes_cryptography_mobile/screens/result_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks/mocks.dart';

void main() {
  testWidgets('Given user in request page When valid establishment code is entered Then result page is shown',
      (WidgetTester tester) async {
    // ASSEMBLE
    final MockCredentialService mockCredentialService = MockCredentialService();
    when(mockCredentialService.getCredentials(any)).thenAnswer(
        (invocation) => Future.value(CredentialResponse("CLIENT_ID", "CLIENT_SECRET", true, "ESTABLISHMENT_CODE")));

    final establishmentCodeField = find.byKey(ValueKey("establishmentCodeField"));
    final sendButton = find.byKey(ValueKey("sendButton"));

    // ACT
    await tester.pumpWidget(MaterialApp(home: RequestPage(credentialService: mockCredentialService)));
    await tester.enterText(establishmentCodeField, "123456789");
    await tester.pump();
    await tester.tap(sendButton);
    await tester.pumpAndSettle();

    // ASSERT
    expect(find.byType(ResultPage), findsOneWidget);
    expect(find.byType(InformationColumn), findsNWidgets(4));
    expect(find.text("CLIENT_ID"), findsOneWidget);
    expect(find.text("CLIENT ID:"), findsOneWidget);
    expect(find.text("CLIENT_SECRET"), findsOneWidget);
    expect(find.text("CLIENT SECRET:"), findsOneWidget);
    expect(find.text("MASTER AS SUBORDINATE:"), findsOneWidget);
    expect(find.text("TRUE"), findsOneWidget);
    expect(find.text("ESTABLISHMENT_CODE"), findsOneWidget);
    expect(find.text("ESTABLISHMENT CODE:"), findsOneWidget);
  });

  testWidgets('Given user in request page When invalid establishment code is entered Then verify message is shown',
      (WidgetTester tester) async {
    // ASSEMBLE
    final MockCredentialService mockCredentialService = MockCredentialService();
    when(mockCredentialService.getCredentials(any)).thenAnswer(
        (invocation) => Future.value(CredentialResponse("CLIENT_ID", "CLIENT_SECRET", true, "ESTABLISHMENT_CODE")));

    final establishmentCodeField = find.byKey(ValueKey("establishmentCodeField"));

    // ACT
    await tester.pumpWidget(MaterialApp(home: RequestPage(credentialService: mockCredentialService)));
    await tester.enterText(establishmentCodeField, "ABCDEFGHI");
    await tester.pump();

    // ASSERT
    expect(find.text("Please verify your establishment code"), findsOneWidget);
  });
}
