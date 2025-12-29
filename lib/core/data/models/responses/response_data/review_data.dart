import 'package:verifysafe/core/data/models/responses/response_data/pagination_data.dart';
import 'package:verifysafe/core/data/models/responses/response_data/stats.dart';
import 'package:verifysafe/core/data/models/review.dart';

class ReviewData {
  final Stats? stats;
  final PaginationData<Review>? data;

  ReviewData({
    this.stats,
    this.data,
  });

  factory ReviewData.fromJson(Map<String, dynamic> json) => ReviewData(
    stats: json["stats"] == null ? null : Stats.fromJson(json["stats"]),
    data: json["data"] == null
        ? null
        : PaginationData<Review>.fromJson(
      json["data"],
          (x) => Review.fromJson(x),
    ),
  );

  Map<String, dynamic> toJson() => {
    "stats": stats?.toJson(),
    "data": data?.toJson((x) => x.toJson()),
  };
}