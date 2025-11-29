class BasicInfoRespnseData {
  String? verificationToken;
  String? tokenExpiresAt;
  bool? emailVerified;
  String? verificationCode;
  String? onboardingId;

  BasicInfoRespnseData({
    this.verificationToken,
    this.tokenExpiresAt,
    this.emailVerified,
    this.verificationCode,
    this.onboardingId
  });

  factory BasicInfoRespnseData.fromJson(Map<String, dynamic> json) {
    return BasicInfoRespnseData(
      verificationToken: json['verification_token'] as String?,
      tokenExpiresAt: json['token_expires_at'] as String?,
      emailVerified: json['email_verified'] as bool?,
      verificationCode: json['verification_code'] as String?,
      onboardingId: json['onboarding_id'] as String?
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'verification_token': verificationToken,
      'token_expires_at': tokenExpiresAt,
      'email_verified': emailVerified,
      'verification_code': verificationCode,
      'onboarding_id':onboardingId
    };
  }
}