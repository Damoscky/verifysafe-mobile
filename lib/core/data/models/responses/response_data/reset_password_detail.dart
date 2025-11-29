class ResetPasswordDetail {
  String? token;
  String? verificationCode;
  String? expiresAt;

  ResetPasswordDetail({
    this.token,
    this.verificationCode,
    this.expiresAt,
  });

  factory ResetPasswordDetail.fromJson(Map<String, dynamic> json) {
    return ResetPasswordDetail(
      token: json['token'] as String?,
      verificationCode: json['verification_code'] as String?,
      expiresAt: json['expires_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'verification_code': verificationCode,
      'expires_at': expiresAt,
    };
  }
}