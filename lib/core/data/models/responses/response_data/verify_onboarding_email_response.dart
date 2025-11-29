class VerifyOnboardingEmailResponse {
  final String? onboardingId;

  VerifyOnboardingEmailResponse({
    this.onboardingId
  });

  factory VerifyOnboardingEmailResponse.fromJson(Map<String, dynamic> json) => VerifyOnboardingEmailResponse(
    onboardingId: json["onboarding_id"]
  );

  toJson()=>{
     "onboarding_id": onboardingId
  };
}