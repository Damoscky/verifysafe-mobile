

class Onboarding {
  String? currentStep;
  String? nextStep;
  bool? isComplete;
  int? completionPercentage;
  String? accountStatus;

  Onboarding({
    this.currentStep,
    this.nextStep,
    this.isComplete,
    this.completionPercentage,
    this.accountStatus,
  });

  factory Onboarding.fromJson(Map<String, dynamic> json) {
    return Onboarding(
      currentStep: json['current_step'] as String?,
      nextStep: json['next_step'] as String?,
      isComplete: json['is_complete'] as bool?,
      completionPercentage: json['completion_percentage'] as int?,
      accountStatus: json['account_status'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_step': currentStep,
      'next_step': nextStep,
      'is_complete': isComplete,
      'completion_percentage': completionPercentage,
      'account_status': accountStatus,
    };
  }
}