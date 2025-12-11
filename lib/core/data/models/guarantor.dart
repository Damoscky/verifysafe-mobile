class Guarantor {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? relationship;
  final String? country;
  final dynamic state;
  final dynamic city;
  final String? address;
  final String? status;
  final bool? isActive;
  final DateTime? requestedAt;
  final DateTime? approvedAt;
  final bool? canNudge;

  Guarantor({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.relationship,
    this.country,
    this.state,
    this.city,
    this.address,
    this.status,
    this.isActive,
    this.requestedAt,
    this.approvedAt,
    this.canNudge,
  });

  factory Guarantor.fromJson(Map<String, dynamic> json) => Guarantor(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    relationship: json["relationship"],
    country: json["country"],
    state: json["state"],
    city: json["city"],
    address: json["address"],
    status: json["status"],
    isActive: json["is_active"],
    requestedAt: json["requested_at"] == null ? null : DateTime.parse(json["requested_at"]),
    approvedAt: json["approved_at"] == null ? null : DateTime.parse(json["approved_at"]),
    canNudge: json["can_nudge"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "relationship": relationship,
    "country": country,
    "state": state,
    "city": city,
    "address": address,
    "status": status,
    "is_active": isActive,
    "requested_at": requestedAt?.toIso8601String(),
    "approved_at": approvedAt?.toIso8601String(),
    "can_nudge": canNudge,
  };
}