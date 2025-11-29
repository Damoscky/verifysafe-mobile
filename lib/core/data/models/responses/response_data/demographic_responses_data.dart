/// Country data model
class Country {
  int? id;
  String? name;
  String? iso2;
  String? currency;

  Country({
    this.id,
    this.name,
    this.iso2,
    this.currency,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'] as int?,
      name: json['name'] as String?,
      iso2: json['iso2'] as String?,
      currency: json['currency'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'iso2': iso2,
      'currency': currency,
    };
  }
}

/// State data model
class State {
  int? id;
  String? name;
  int? countryId;

  State({
    this.id,
    this.name,
    this.countryId,
  });

  factory State.fromJson(Map<String, dynamic> json) {
    return State(
      id: json['id'] as int?,
      name: json['name'] as String?,
      countryId: json['country_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'country_id': countryId,
    };
  }
}

/// City data model
class City {
  int? id;
  String? name;
  int? stateId;
  String? stateCode;
  int? countryId;
  State? state;
  Country? country;

  City({
    this.id,
    this.name,
    this.stateId,
    this.stateCode,
    this.countryId,
    this.state,
    this.country,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'] as int?,
      name: json['name'] as String?,
      stateId: json['state_id'] as int?,
      stateCode: json['state_code'] as String?,
      countryId: json['country_id'] as int?,
      state: json['state'] != null ? State.fromJson(json['state']) : null,
      country: json['country'] != null ? Country.fromJson(json['country']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'state_id': stateId,
      'state_code': stateCode,
      'country_id': countryId,
      'state': state?.toJson(),
      'country': country?.toJson(),
    };
  }
}


