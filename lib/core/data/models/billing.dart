class Billing {
  final String? currentPlan;
  final String? planInterval;
  final dynamic amountPaid;
  final DateTime? subscribedAt;
  final DateTime? endDate;
  final String? status;
  final bool? isCancelled;
  final int? workerEntriesBalance;
  final int? searchesBalance;
  final int? workerEntriesLimit;
  final int? searchesLimit;

  Billing({
    this.currentPlan,
    this.planInterval,
    this.amountPaid,
    this.subscribedAt,
    this.endDate,
    this.status,
    this.isCancelled,
    this.workerEntriesBalance,
    this.searchesBalance,
    this.workerEntriesLimit,
    this.searchesLimit,
  });

  factory Billing.fromJson(Map<String, dynamic> json) {
    return Billing(
      currentPlan: json['current_plan'] as String?,
      planInterval: json['plan_interval'] as String?,
      amountPaid: json['amount_paid'],
      subscribedAt: json['subscribed_at'] != null
          ? DateTime.parse(json['subscribed_at'])
          : null,
      endDate: json['end_date'] != null
          ? DateTime.parse(json['end_date'])
          : null,
      status: json['status'] as String?,
      isCancelled: json['is_cancelled'] as bool?,
      workerEntriesBalance: json['worker_entries_balance'] as int?,
      searchesBalance: json['searches_balance'] as int?,
      workerEntriesLimit: json['worker_entries_limit'] as int?,
      searchesLimit: json['searches_limit'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_plan': currentPlan,
      'plan_interval': planInterval,
      'amount_paid': amountPaid,
      'subscribed_at': subscribedAt?.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'status': status,
      'is_cancelled': isCancelled,
      'worker_entries_balance': workerEntriesBalance,
      'searches_balance': searchesBalance,
      'worker_entries_limit': workerEntriesLimit,
      'searches_limit': searchesLimit,
    };
  }

  Billing copyWith({
    String? currentPlan,
    String? planInterval,
    String? amountPaid,
    DateTime? subscribedAt,
    DateTime? endDate,
    String? status,
    bool? isCancelled,
    int? workerEntriesBalance,
    int? searchesBalance,
    int? workerEntriesLimit,
    int? searchesLimit,
  }) {
    return Billing(
      currentPlan: currentPlan ?? this.currentPlan,
      planInterval: planInterval ?? this.planInterval,
      amountPaid: amountPaid ?? this.amountPaid,
      subscribedAt: subscribedAt ?? this.subscribedAt,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
      isCancelled: isCancelled ?? this.isCancelled,
      workerEntriesBalance: workerEntriesBalance ?? this.workerEntriesBalance,
      searchesBalance: searchesBalance ?? this.searchesBalance,
      workerEntriesLimit: workerEntriesLimit ?? this.workerEntriesLimit,
      searchesLimit: searchesLimit ?? this.searchesLimit,
    );
  }

  // Helper methods
  bool get isActive => status?.toLowerCase() == 'active' && isCancelled != true;

  bool get hasSearchesRemaining => (searchesBalance ?? 0) > 0;

  bool get hasWorkerEntriesRemaining => (workerEntriesBalance ?? 0) > 0;

  int get searchCountRemaining {
    final limit = searchesLimit ?? 0;
    final balance = searchesBalance ?? 0;
    return limit - balance;
  }

  double get searchesUsagePercentage {
    final limit = searchesLimit ?? 0;
    final balance = searchesBalance ?? 0;
    if (limit == 0) return 0;
    return ((limit - balance) / limit) * 100;
  }

  double get workerEntriesUsagePercentage {
    final limit = workerEntriesLimit ?? 0;
    final balance = workerEntriesBalance ?? 0;
    if (limit == 0) return 0;
    return ((limit - balance) / limit) * 100;
  }

  @override
  String toString() {
    return 'Billing(plan: $currentPlan, interval: $planInterval, status: $status, searchesBalance: $searchesBalance/$searchesLimit, workerEntriesBalance: $workerEntriesBalance/$workerEntriesLimit)';
  }
}
