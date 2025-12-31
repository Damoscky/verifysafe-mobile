import 'package:verifysafe/core/data/models/user.dart';

class SearchHistoryData {
  String? id;
  String? action;
  User? workerData;
  SearchHistoryData({this.id, this.action, this.workerData});

  factory SearchHistoryData.fromJson(Map<String, dynamic> json) =>
      SearchHistoryData(
        id: json['id'],
        action: json['action'],
        workerData: json['worker_data'] != null
            ? User.fromJson(json['worker_data'])
            : null,
      );

  toJson() => {"id": id, "action": action, "worker_data": workerData?.toJson()};
}
