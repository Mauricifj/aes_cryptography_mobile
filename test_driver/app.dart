import 'package:aes_cryptography_mobile/main.dart' as app;
import 'package:flutter_driver/driver_extension.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';

class MockDio extends Mock implements Dio {}

void main() {
  enableFlutterDriverExtension();

  final mockDio = MockDio();
  when(mockDio.get(any, queryParameters: anyNamed('queryParameters'))).thenAnswer((invocation) => Future.value(Response(
      data:
          "6B4WZFi6cD7f4Vrgl2evgkjUo6k7L78ZKWnU4Qu6ltBJMrJ2zWbt1EZiOfLmotW1sWzLd3QVGhd/npigTXofBgnCK01bFX0gPDOYyBP8Rj/HOiJZUnz6c/1Zo7qISne4CQ3kg38whzED+8+skF22zIyHNcV3R2id/VMzwy/ye3w=",
      statusCode: 200)));

  app.main(mockDio);
}
