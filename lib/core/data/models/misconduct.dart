import 'package:verifysafe/core/data/models/user.dart';

class Misconduct {
  final String? id;
  final User? reportee;
  final User? reporter;
  final String? comment;
  final String? type;
  final DateTime? date;
  final String? status;
  final List<String>? attachments;
  final bool? isActive;

  Misconduct({
    this.id,
    this.reportee,
    this.reporter,
    this.comment,
    this.type,
    this.date,
    this.status,
    this.attachments,
    this.isActive
  });

  factory Misconduct.fromJson(Map<String, dynamic> json) => Misconduct(
    id: json["id"],
    reportee: json["reportee"] == null ? null : User.fromJson(json["reportee"]),
    reporter: json["reporter"] == null ? null : User.fromJson(json["reporter"]),
    comment: json["comment"],
    type: json["type"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    status: json["status"],
    isActive: json["is_active"],
    attachments: json['attachments'] != null
        ? List<String>.from(json['attachments'])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "reportee": reportee?.toJson(),
    "reporter": reporter?.toJson(),
    "comment": comment,
    "type": type,
    "is_active": isActive,
    "date": date?.toIso8601String(),
    "status": status,
    'attachments': attachments,
  };
}