import 'package:verifysafe/core/data/models/user.dart';


class Worker {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? accountStatus;
  final String? avatar;
  final String? userType;
  final String? residentialAddress;
  final String? gender;
  final String? maritalStatus;
  final String? workerIdentifier;
  final WorkerInfo? workerInfo;
  final Identity? workerIdentity;
  final List<dynamic>? workHistories;
  final dynamic employmentType;
  final String? workerStatus;
  final String? workerId;

  Worker({
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
  });

  factory Worker.fromJson(Map<String, dynamic> json) => Worker(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    accountStatus: json["account_status"],
    avatar: json["avatar"],
    userType: json["user_type"],
    residentialAddress: json["residential_address"],
    gender: json["gender"],
    maritalStatus: json["marital_status"],
    workerIdentifier: json["worker_identifier"],
    workerInfo: json["worker_info"] == null ? null : WorkerInfo.fromJson(json["worker_info"]),
    workerIdentity: json["worker_identity"] == null ? null : Identity.fromJson(json["worker_identity"]),
    workHistories: json["work_histories"] == null ? [] : List<dynamic>.from(json["work_histories"]!.map((x) => x)),
    employmentType: json["employment_type"],
    workerStatus: json["worker_status"],
    workerId: json["workerID"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "account_status": accountStatus,
    "avatar": avatar,
    "user_type": userType,
    "residential_address": residentialAddress,
    "gender": gender,
    "marital_status": maritalStatus,
    "worker_identifier": workerIdentifier,
    "worker_info": workerInfo?.toJson(),
    "worker_identity": workerIdentity?.toJson(),
    "work_histories": workHistories == null ? [] : List<dynamic>.from(workHistories!.map((x) => x)),
    "employment_type": employmentType,
    "worker_status": workerStatus,
    "workerID": workerId,
  };
}