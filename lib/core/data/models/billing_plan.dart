
class BillingPlan {
  final String? id;
  final String? name;
  final String? description;
  final bool? isMetered;
  final bool? isFree;
  final bool? isPopular;
  final bool? isEnterprise;
  final List<Price>? prices;

  BillingPlan({
    this.id,
    this.name,
    this.description,
    this.isMetered,
    this.isFree,
    this.isPopular,
    this.isEnterprise,
    this.prices,
  });

  factory BillingPlan.fromJson(Map<String, dynamic> json) {
    return BillingPlan(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      isMetered: json['is_metered'] as bool?,
      isFree: json['is_free'] as bool?,
      isPopular: json['is_popular'] as bool?,
      isEnterprise: json['is_enterprise'] as bool?,
      prices: json['prices'] != null
          ? (json['prices'] as List)
              .map((price) => Price.fromJson(price as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'is_metered': isMetered,
      'is_free': isFree,
      'is_popular': isPopular,
      'is_enterprise': isEnterprise,
      'prices': prices?.map((price) => price.toJson()).toList(),
    };
  }

  BillingPlan copyWith({
    String? id,
    String? name,
    String? description,
    bool? isMetered,
    bool? isFree,
    bool? isPopular,
    bool? isEnterprise,
    List<Price>? prices,
  }) {
    return BillingPlan(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      isMetered: isMetered ?? this.isMetered,
      isFree: isFree ?? this.isFree,
      isPopular: isPopular ?? this.isPopular,
      isEnterprise: isEnterprise ?? this.isEnterprise,
      prices: prices ?? this.prices,
    );
  }
}

class Price {
  final String? id;
  final String? interval;
  final String? price;
  final String? discountPercentage;
  final int? workerEntriesLimit;
  final int? searchesLimit;

  Price({
    this.id,
    this.interval,
    this.price,
    this.discountPercentage,
    this.workerEntriesLimit,
    this.searchesLimit,
  });

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      id: json['id'] as String?,
      interval: json['interval'] as String?,
      price: json['price'] as String?,
      discountPercentage: json['discount_percentage'] as String?,
      workerEntriesLimit: json['worker_entries_limit'] as int?,
      searchesLimit: json['searches_limit'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'interval': interval,
      'price': price,
      'discount_percentage': discountPercentage,
      'worker_entries_limit': workerEntriesLimit,
      'searches_limit': searchesLimit,
    };
  }

  Price copyWith({
    String? id,
    String? interval,
    String? price,
    String? discountPercentage,
    int? workerEntriesLimit,
    int? searchesLimit,
  }) {
    return Price(
      id: id ?? this.id,
      interval: interval ?? this.interval,
      price: price ?? this.price,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      workerEntriesLimit: workerEntriesLimit ?? this.workerEntriesLimit,
      searchesLimit: searchesLimit ?? this.searchesLimit,
    );
  }
}