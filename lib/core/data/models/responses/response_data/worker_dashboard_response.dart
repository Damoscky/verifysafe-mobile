import 'package:verifysafe/core/data/models/responses/response_data/stats.dart';

class WorkerDashboardResponse {
  final Stats? stats;
  final List<EmploymentData>? data;

  WorkerDashboardResponse({this.stats, this.data});

  factory WorkerDashboardResponse.fromJson(Map<String, dynamic> json) {
    return WorkerDashboardResponse(
      stats: json['stats'] != null ? Stats.fromJson(json['stats']) : null,
      data: json['data'] != null
          ? (json['data'] as List)
                .map((e) => EmploymentData.fromJson(e))
                .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stats': stats?.toJson(),
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class EmploymentData {
  final String? id;
  final Employee? employee;
  final Employer? employer;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? employmentType;
  final String? jobRole;
  final String? category;
  final dynamic exit;

  EmploymentData({
    this.id,
    this.employee,
    this.employer,
    this.startDate,
    this.endDate,
    this.employmentType,
    this.jobRole,
    this.category,
    this.exit,
  });

  factory EmploymentData.fromJson(Map<String, dynamic> json) {
    return EmploymentData(
      id: json['id'],
      employee: json['employee'] != null
          ? Employee.fromJson(json['employee'])
          : null,
      employer: json['employer'] != null
          ? Employer.fromJson(json['employer'])
          : null,
      startDate: json['start_date'] != null
          ? DateTime.parse(json['start_date'])
          : null,
      endDate: json['end_date'] != null
          ? DateTime.parse(json['end_date'])
          : null,
      employmentType: json['employment_type'],
      jobRole: json['job_role'],
      category: json['category'],
      exit: json['exit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee': employee?.toJson(),
      'employer': employer?.toJson(),
      'start_date': startDate,
      'end_date': endDate,
      'employment_type': employmentType,
      'job_role': jobRole,
      'category': category,
      'exit': exit,
    };
  }
}

class Employee {
  final String? identifier;
  final String? name;
  final String? email;
  final String? phone;

  Employee({this.identifier, this.name, this.email, this.phone});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      identifier: json['identifier'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'identifier': identifier,
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
}

class Employer {
  final String? name;
  final String? address;

  Employer({this.name, this.address});

  factory Employer.fromJson(Map<String, dynamic> json) {
    return Employer(name: json['name'], address: json['address']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'address': address};
  }
}
