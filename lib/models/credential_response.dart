class CredentialResponse {
  final String clientId;
  final String clientSecret;
  final bool masterAsSubordinate;
  final String establishmentCode;

  CredentialResponse(this.clientId, this.clientSecret, this.masterAsSubordinate, this.establishmentCode);

  CredentialResponse.fromJson(Map<String, dynamic> json)
      : clientId = json['ClientId'],
        clientSecret = json['ClientSecret'],
        masterAsSubordinate = json['MasterAsSubordinate'],
        establishmentCode = json['EstablishmentCode'];
}
