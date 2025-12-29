import 'package:verifysafe/core/data/models/responses/response_data/pagination_data.dart';
import 'package:verifysafe/core/data/models/responses/response_data/subscription_response.dart';

class BillingDashboardResponse {
  final Stats? stats;
  final PaginationData? data;

  BillingDashboardResponse({this.stats, this.data});

  factory BillingDashboardResponse.fromJson(Map<String, dynamic> json) {
    return BillingDashboardResponse(
      stats: json['stats'] != null ? Stats.fromJson(json['stats']) : null,
      data: json['data'] != null
          ? PaginationData<SubscriptionResponse>.fromJson(
              json['data'],
              (e) => SubscriptionResponse.fromJson(e),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'stats': stats?.toJson(), 'data': data?.toJson((e) => e.toJson())};
  }
}

class Stats {
  final dynamic amountGenerated;
  final dynamic transactionCount;

  Stats({this.amountGenerated, this.transactionCount});

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      amountGenerated: json['amount_generated'],
      transactionCount: json['transaction_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount_generated': amountGenerated,
      'transaction_count': transactionCount,
    };
  }


  // Helper methods
  double get amountAsDouble {
    if (amountGenerated == null || amountGenerated!.isEmpty) return 0.0;
    return double.tryParse(amountGenerated?.toString() ?? '0') ?? 0.0;
  }

  String get formattedAmount {
    final amount = amountAsDouble;
    return amount.toStringAsFixed(2);
  }

  bool get hasTransactions => (transactionCount ?? 0) > 0;

  @override
  String toString() {
    return 'Stats(amountGenerated: $amountGenerated, transactionCount: $transactionCount)';
  }
}
