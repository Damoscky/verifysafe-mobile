class ResetPasswordDetail {
  String? token;
  String? verificationToken;
  String? verificationCode;
  String? expiresAt;

  ResetPasswordDetail({
    this.token,
    this.verificationCode,
    this.verificationToken,
    this.expiresAt,
  });

  factory ResetPasswordDetail.fromJson(Map<String, dynamic> json) {
    return ResetPasswordDetail(
      token: json['token'] as String?,
      verificationToken: json['verification_token'] as String?,
      verificationCode: json['verification_code'] as String?,
      expiresAt: json['expires_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      "verification_token":verificationToken,
      'verification_code': verificationCode,
      'expires_at': expiresAt,
    };
  }
}