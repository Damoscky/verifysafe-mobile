class WorkHistoryModel {
  String? employerName;
  String? category;
  String? jobRole;
  String? phone;
  String? email;
  String? startDate;
  String? endDate;
  String? employmentType;

  WorkHistoryModel({
    this.employerName,
    this.category,
    this.jobRole,
    this.phone,
    this.email,
    this.startDate,
    this.endDate,
    this.employmentType,
  });

  toJson() => {
      "employer_name": employerName,
      "category": category,
      "job_role": jobRole,
      "email": email,
      "phone": phone,
      "start_date": startDate,
      "end_date": endDate,
      "employment_type": employmentType,
    };
}
