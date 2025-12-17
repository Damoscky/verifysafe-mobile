import 'package:verifysafe/core/data/enum/user_type.dart';

class User {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? accountStatus;
  String? avatar;
  String? userType;
  String? residentialAddress;
  String? gender;
  String? maritalStatus;
  //worker
  String? workerIdentifier;
  WorkerInfo? workerInfo;
  Identity? workerIdentity;
  List<WorkHistory>? workHistories;
  String? employmentType;
  String? workerStatus;
  String? workerId;
  //agency
  Agency? agency;
  Location? location;
  //employer
  Employer? employer;
  EmployerServices? services;
  //agency and employer
  Identity? identity;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.accountStatus,
    this.avatar,
    this.userType,
    this.residentialAddress,
    this.gender,
    this.maritalStatus,

    this.workerIdentifier,
    this.workerInfo,
    this.workerIdentity,
    this.workHistories,
    this.employmentType,
    this.workerStatus,
    this.workerId,

    this.agency,
    this.location,

    this.employer,
    this.services,

    this.identity,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      accountStatus: json['account_status'] as String?,
      avatar: json['avatar'] as String?,
      userType: json['user_type'] as String?,
      residentialAddress: json['residential_address'] as String?,
      gender: json['gender'] as String?,
      maritalStatus: json['marital_status'] as String?,

      workerIdentifier: json['worker_identifier'] as String?,
      workerInfo: json['worker_info'] != null
          ? WorkerInfo.fromJson(json['worker_info'])
          : null,
      workerIdentity: json['worker_identity'] != null
          ? Identity.fromJson(json['worker_identity'])
          : null,
      workHistories: json['work_histories'] != null
          ? (json['work_histories'] as List)
                .map((e) => WorkHistory.fromJson(e))
                .toList()
          : null,
      employmentType: json['employment_type'] as String?,
      workerStatus: json['worker_status'] as String?,
      workerId: json['workerID'] as String?,

      agency: json['agency'] != null ? Agency.fromJson(json['agency']) : null,
      location: json['location'] != null
          ? Location.fromJson(json['location'])
          : null,

      employer: json['employer'] != null
          ? Employer.fromJson(json['employer'])
          : null,
      services: json['services'] != null
          ? EmployerServices.fromJson(json['services'])
          : null,

      identity: json['identity'] != null
          ? Identity.fromJson(json['identity'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'account_status': accountStatus,
      'avatar': avatar,
      'user_type': userType,
      'residential_address': residentialAddress,
      'gender': gender,
      'marital_status': maritalStatus,

      'worker_identifier': workerIdentifier,
      'worker_info': workerInfo?.toJson(),
      'worker_identity': workerIdentity?.toJson(),
      'work_histories': workHistories?.map((e) => e.toJson()).toList(),
      'employment_type': employmentType,
      'worker_status': workerStatus,
      'workerID': workerId,

      'agency': agency?.toJson(),
      'location': location?.toJson(),

      'employer': employer?.toJson(),
      'services': services?.toJson(),

      'identity': identity?.toJson(),
    };
  }

  UserType get userEnumType {
    switch (userType) {
      case 'worker':
        return UserType.worker;
      case 'agency':
        return UserType.agency;
      case 'employer':
        return UserType.employer;
      default:
        return UserType.worker;
    }
  }
}

class Agency {
  String? identifier;
  String? name;
  String? businessType;
  String? email;
  String? phone;
  String? address;
  String? agencyId;
  String? createdAt;

  Agency({
    this.identifier,
    this.name,
    this.businessType,
    this.email,
    this.phone,
    this.address,
    this.agencyId,
    this.createdAt,
  });

  factory Agency.fromJson(Map<String, dynamic> json) {
    return Agency(
      identifier: json['identifier'] as String?,
      name: json['name'] as String?,
      businessType: json['business_type'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      agencyId: json['agencyID'] as String?,
      createdAt: json['created_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'identifier': identifier,
      'name': name,
      'business_type': businessType,
      'email': email,
      'phone': phone,
      'address': address,
      'agencyID': agencyId,
      'created_at': createdAt,
    };
  }
}

class Location {
  String? country;
  String? state;
  String? city;

  Location({this.country, this.state, this.city});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      country: json['country'] as String?,
      state: json['state'] as String?,
      city: json['city'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'country': country, 'state': state, 'city': city};
  }
}

class Identity {
  String? identityName;
  String? identityNumber;
  String? status;
  String? identityFileUrl;

  Identity({
    this.identityName,
    this.identityNumber,
    this.status,
    this.identityFileUrl,
  });

  factory Identity.fromJson(Map<String, dynamic> json) {
    return Identity(
      identityName: json['identity_name'] as String?,
      identityNumber: json['identity_number'] as String?,
      status: json['status'] as String?,
      identityFileUrl: json['identity_file_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'identity_name': identityName,
      'identity_number': identityNumber,
      'status': status,
      'identity_file_url': identityFileUrl,
    };
  }
}

class WorkerInfo {
  String? gender;
  String? maritalStatus;
  String? dateOfBirth;
  String? residentialAddress;
  String? createdAt;
  final String? jobCategory;
  final String? jobRole;
  final String? experience;
  final String? language;
  final int? relocatable;
  final String? resumeUrl;

  WorkerInfo({
    this.gender,
    this.maritalStatus,
    this.dateOfBirth,
    this.residentialAddress,
    this.createdAt,
    this.jobCategory,
    this.jobRole,
    this.experience,
    this.language,
    this.relocatable,
    this.resumeUrl,
  });

  factory WorkerInfo.fromJson(Map<String, dynamic> json) {
    return WorkerInfo(
      gender: json['gender'] as String?,
      maritalStatus: json['marital_status'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      residentialAddress: json['residential_address'] as String?,
      createdAt: json['created_at'] as String?,
      jobCategory: json["job_category"],
      jobRole: json["job_role"],
      experience: json["experience"],
      language: json["language"],
      relocatable: json["relocatable"],
      resumeUrl: json["resume_url"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gender': gender,
      'marital_status': maritalStatus,
      'date_of_birth': dateOfBirth,
      'residential_address': residentialAddress,
      'created_at': createdAt,
      "job_category": jobCategory,
      "job_role": jobRole,
      "experience": experience,
      "language": language,
      "relocatable": relocatable,
      "resume_url": resumeUrl,
    };
  }
}

class WorkHistory {
  // Add fields based on your work history structure
  // Since the array is empty in the JSON, you'll need to add fields when you have a sample
  final String? id;
  final String? employerName;
  final String? category;
  final String? jobRole;
  final String? employmentType;
  final DateTime? startDate;
  final DateTime? endDate;

  WorkHistory({
    this.id,
    this.employerName,
    this.category,
    this.jobRole,
    this.employmentType,
    this.startDate,
    this.endDate,
  });

  factory WorkHistory.fromJson(Map<String, dynamic> json) {
    return WorkHistory(
      id: json['id'],
      employerName: json['employer_name'],
      category: json['category'],
      jobRole: json['job_role'],
      employmentType: json['employment_type'],
      startDate: json['start_date'] != null
          ? DateTime.parse(json['start_date'])
          : null,
      endDate: json['end_date'] != null
          ? DateTime.parse(json['end_date'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employer_name': employerName,
      'category': category,
      'job_role': jobRole,
      'employment_type': employmentType,
      'start_date': startDate?.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
    };
  }
}

//EMPLOYER
class EmployerServices {
  int? activeWorkersCount;
  bool? trainingServiceProvided;
  String? placementRegion;
  String? averagePlacementTime;

  EmployerServices({
    this.activeWorkersCount,
    this.trainingServiceProvided,
    this.placementRegion,
    this.averagePlacementTime,
  });

  factory EmployerServices.fromJson(Map<String, dynamic> json) {
    return EmployerServices(
      activeWorkersCount: json['active_workers_count'] as int?,
      trainingServiceProvided: json['training_service_provided'] as bool?,
      placementRegion: json['placement_region'] as String?,
      averagePlacementTime: json['average_placement_time'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'active_workers_count': activeWorkersCount,
      'training_service_provided': trainingServiceProvided,
      'placement_region': placementRegion,
      'average_placement_time': averagePlacementTime,
    };
  }
}

class Employer {
  String? identifier;
  String? name;
  String? businessType;
  String? email;
  String? phone;
  String? address;
  String? contactPerson;
  String? status;
  String? website;
  String? employerId;
  String? createdAt;
  //worker
  String? employerName;
  String? category;
  String? jobRole;
  DateTime? startDate;
  DateTime? endDate;

  Employer({
    this.identifier,
    this.name,
    this.businessType,
    this.email,
    this.phone,
    this.address,
    this.contactPerson,
    this.status,
    this.website,
    this.employerId,
    this.createdAt,
    //worker
    this.employerName,
    this.category,
    this.jobRole,
    this.startDate,
    this.endDate,
  });

  factory Employer.fromJson(Map<String, dynamic> json) {
    return Employer(
      identifier: json['identifier'] as String?,
      name: json['name'] as String?,
      businessType: json['business_type'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      contactPerson: json['contact_person'] as String?,
      status: json['status'] as String?,
      website: json['website'] as String?,
      employerId: json['employerID'] as String?,
      createdAt: json['created_at'] as String?,
      //worker
      employerName: json["employer_name"],
      category: json["category"],
      jobRole: json["job_role"],
      startDate: json["start_date"] != null
          ? DateTime.parse(json["start_date"])
          : null,
      endDate: json["end_date"] != null
          ? DateTime.parse(json["end_date"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'identifier': identifier,
      'name': name,
      'business_type': businessType,
      'email': email,
      'phone': phone,
      'address': address,
      'contact_person': contactPerson,
      'status': status,
      'website': website,
      'employerID': employerId,
      'created_at': createdAt,
      //worker,
      "employer_name": employerName,
      "category": category,
      "job_role": jobRole,
      "start_date": startDate,
      "end_date": endDate,
    };
  }
}
