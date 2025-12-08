class ReferenceModel {
  String? name;
  String? email;
  String? phone;
  String? relationship;
  String? stateId;
  String? cityId;
  String? address;
  String? referenceType;

  ReferenceModel({
    this.name,
    this.email,
    this.phone,
    this.relationship,
    this.stateId,
    this.cityId,
    this.address,
    this.referenceType,
  });

  toJson() => {
    "name": name,
    "email": email,
    "phone": phone,
    "relationship": relationship,
    "state_id": stateId,
    "city_id": cityId,
    "address": address,
    "type": referenceType,
  };
}
