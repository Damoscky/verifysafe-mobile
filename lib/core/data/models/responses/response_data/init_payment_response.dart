class InitPaymentResponse {
  final String? authorizationUrl;
  final String? accessCode;
  final String? reference;

  InitPaymentResponse({this.authorizationUrl, this.accessCode, this.reference});

  factory InitPaymentResponse.fromJson(Map<String, dynamic> json) {
    return InitPaymentResponse(
      authorizationUrl: json['authorization_url'] as String?,
      accessCode: json['access_code'] as String?,
      reference: json['reference'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'authorization_url': authorizationUrl,
      'access_code': accessCode,
      'reference': reference,
    };
  }

  InitPaymentResponse copyWith({
    String? authorizationUrl,
    String? accessCode,
    String? reference,
  }) {
    return InitPaymentResponse(
      authorizationUrl: authorizationUrl ?? this.authorizationUrl,
      accessCode: accessCode ?? this.accessCode,
      reference: reference ?? this.reference,
    );
  }

  @override
  String toString() {
    return 'InitPaymentResponse(authorizationUrl: $authorizationUrl, accessCode: $accessCode, reference: $reference)';
  }
}
