import 'package:verifysafe/core/data/models/guarantor.dart';
import 'package:verifysafe/core/data/models/responses/response_data/stats.dart';

class GuarantorData {
  final Stats? stats;
  final List<Guarantor>? data;

  GuarantorData({
    this.stats,
    this.data,
  });

  factory GuarantorData.fromJson(Map<String, dynamic> json) => GuarantorData(
    stats: json["stats"] == null ? null : Stats.fromJson(json["stats"]),
    data: json["data"] == null ? [] : List<Guarantor>.from(json["data"]!.map((x) => Guarantor.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "stats": stats?.toJson(),
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}