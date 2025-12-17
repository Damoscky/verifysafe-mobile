class Identity {
  final dynamic identityName;
  final dynamic associatedDate;
  final dynamic identityNumber;
  final dynamic status;
  final dynamic identityFileUrl;
  final ReviewedBy? reviewedBy;

  Identity({
    this.identityName,
    this.associatedDate,
    this.identityNumber,
    this.status,
    this.identityFileUrl,
    this.reviewedBy
  });

  factory Identity.fromJson(Map<String, dynamic> json) => Identity(
    identityName: json["identity_name"],
    associatedDate: json["associated_date"],
    identityNumber: json["identity_number"],
    status: json["status"],
    identityFileUrl: json["identity_file_url"],
    reviewedBy: json["reviewed_by"] == null ? null : ReviewedBy.fromJson(json["reviewed_by"]),
  );

  Map<String, dynamic> toJson() => {
    "identity_name": identityName,
    "associated_date": associatedDate,
    "identity_number": identityNumber,
    "status": status,
    "identity_file_url": identityFileUrl,
    "reviewed_by": reviewedBy?.toJson(),
  };
}

class ReviewedBy {
  final String? identifier;
  final String? name;

  ReviewedBy({
    this.identifier,
    this.name,
  });

  factory ReviewedBy.fromJson(Map<String, dynamic> json) => ReviewedBy(
    identifier: json["identifier"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "identifier": identifier,
    "name": name,
  };
}