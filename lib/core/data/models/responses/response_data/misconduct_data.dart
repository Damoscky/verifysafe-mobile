import 'package:verifysafe/core/data/models/misconduct.dart';
import 'package:verifysafe/core/data/models/responses/response_data/pagination_data.dart';
import 'package:verifysafe/core/data/models/responses/response_data/stats.dart';

class MisconductData {
  final Stats? stats;
  final PaginationData<Misconduct>? data;

  MisconductData({
    this.stats,
    this.data,
  });

  factory MisconductData.fromJson(Map<String, dynamic> json) => MisconductData(
    stats: json["stats"] == null ? null : Stats.fromJson(json["stats"]),
    data: json["data"] == null
        ? null
        : PaginationData<Misconduct>.fromJson(
      json["data"],
          (x) => Misconduct.fromJson(x),
    ),
  );

  Map<String, dynamic> toJson() => {
    "stats": stats?.toJson(),
    "data": data?.toJson((x) => x.toJson()),
  };
}