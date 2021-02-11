class ServerException {
  final originalException;
  final parsedResponse;

  ServerException(this.originalException, this.parsedResponse);
}