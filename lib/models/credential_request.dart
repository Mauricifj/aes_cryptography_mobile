class CredentialRequest {
  final String establishmentCode;

  CredentialRequest(this.establishmentCode);

  Map<String, dynamic> toJson() => {
    'EstablishmentCode': establishmentCode
  };
}
