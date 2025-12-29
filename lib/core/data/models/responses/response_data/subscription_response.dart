class SubscriptionResponse {
  final String? id;
  final Subscriber? subscriber;
  final String? reference;
  final dynamic amount;
  final String? plan;
  final DateTime? subscribedAt;
  final DateTime? endDate;
  final String? paymentStatus;
  final CurrentBalance? currentBalance;

  SubscriptionResponse({
    this.id,
    this.subscriber,
    this.reference,
    this.amount,
    this.plan,
    this.subscribedAt,
    this.endDate,
    this.paymentStatus,
    this.currentBalance,
  });

  factory SubscriptionResponse.fromJson(Map<String, dynamic> json) {
    return SubscriptionResponse(
      id: json['id'] as String?,
      subscriber: json['subscriber'] != null
          ? Subscriber.fromJson(json['subscriber'] as Map<String, dynamic>)
          : null,
      reference: json['reference'] as String?,
      amount: json['amount'],
      plan: json['plan'] as String?,
      subscribedAt: json['subscribed_at'] != null
          ? DateTime.parse(json['subscribed_at'])
          : null,
      endDate: json['end_date'] != null
          ? DateTime.parse(json['end_date'])
          : null,
      paymentStatus: json['payment_status'] as String?,
      currentBalance: json['current_balance'] != null
          ? CurrentBalance.fromJson(
              json['current_balance'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subscriber': subscriber?.toJson(),
      'reference': reference,
      'amount': amount,
      'plan': plan,
      'subscribed_at': subscribedAt?.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'payment_status': paymentStatus,
      'current_balance': currentBalance?.toJson(),
    };
  }

  SubscriptionResponse copyWith({
    String? id,
    Subscriber? subscriber,
    String? reference,
    String? amount,
    String? plan,
    DateTime? subscribedAt,
    DateTime? endDate,
    String? paymentStatus,
    CurrentBalance? currentBalance,
  }) {
    return SubscriptionResponse(
      id: id ?? this.id,
      subscriber: subscriber ?? this.subscriber,
      reference: reference ?? this.reference,
      amount: amount ?? this.amount,
      plan: plan ?? this.plan,
      subscribedAt: subscribedAt ?? this.subscribedAt,
      endDate: endDate ?? this.endDate,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      currentBalance: currentBalance ?? this.currentBalance,
    );
  }
}

class Subscriber {
  final String? name;
  final String? stakeholderName;
  final String? userType;

  Subscriber({this.name, this.stakeholderName, this.userType});

  factory Subscriber.fromJson(Map<String, dynamic> json) {
    return Subscriber(
      name: json['name'] as String?,
      stakeholderName: json['stakeholder_name'] as String?,
      userType: json['user_type'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'stakeholder_name': stakeholderName,
      'user_type': userType,
    };
  }

  Subscriber copyWith({
    String? name,
    String? stakeholderName,
    String? userType,
  }) {
    return Subscriber(
      name: name ?? this.name,
      stakeholderName: stakeholderName ?? this.stakeholderName,
      userType: userType ?? this.userType,
    );
  }
}

class CurrentBalance {
  final int? searches;
  final int? workerEntries;
  final int? meteredSearches;
  final int? meteredWorkerEntries;

  CurrentBalance({
    this.searches,
    this.workerEntries,
    this.meteredSearches,
    this.meteredWorkerEntries,
  });

  factory CurrentBalance.fromJson(Map<String, dynamic> json) {
    return CurrentBalance(
      searches: json['searches'] as int?,
      workerEntries: json['worker_entries'] as int?,
      meteredSearches: json['metered_searches'] as int?,
      meteredWorkerEntries: json['metered_worker_entries'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'searches': searches,
      'worker_entries': workerEntries,
      'metered_searches': meteredSearches,
      'metered_worker_entries': meteredWorkerEntries,
    };
  }

  CurrentBalance copyWith({
    int? searches,
    int? workerEntries,
    int? meteredSearches,
    int? meteredWorkerEntries,
  }) {
    return CurrentBalance(
      searches: searches ?? this.searches,
      workerEntries: workerEntries ?? this.workerEntries,
      meteredSearches: meteredSearches ?? this.meteredSearches,
      meteredWorkerEntries: meteredWorkerEntries ?? this.meteredWorkerEntries,
    );
  }
}
