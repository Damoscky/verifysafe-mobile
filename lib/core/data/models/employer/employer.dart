class Employer {
  final String? identifier;
  final String? name;
  final dynamic businessType;
  final String? email;
  final String? phone;
  final dynamic address;
  final dynamic contactPerson;
  final String? status;
  final dynamic website;
  final String? employerId;
  final DateTime? createdAt;

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
  });

  factory Employer.fromJson(Map<String, dynamic> json) => Employer(
    identifier: json["identifier"],
    name: json["name"],
    businessType: json["business_type"],
    email: json["email"],
    phone: json["phone"],
    address: json["address"],
    contactPerson: json["contact_person"],
    status: json["status"],
    website: json["website"],
    employerId: json["employerID"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "identifier": identifier,
    "name": name,
    "business_type": businessType,
    "email": email,
    "phone": phone,
    "address": address,
    "contact_person": contactPerson,
    "status": status,
    "website": website,
    "employerID": employerId,
    "created_at": createdAt?.toIso8601String(),
  };
}