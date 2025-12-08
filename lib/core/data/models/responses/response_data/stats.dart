class Stats {
  final int? total;
  //worker
  final int? current;
  final int? previous;
  //Employer
  final int? active;
  final int? past;
  //agency
  final int? totalCount;
  final int? acceptedCount;
  final int? pendingCount;
  final num? percentageChange;

  Stats({
    this.total,
    this.current,
    this.previous,
    this.active,
    this.past,
    this.totalCount,
    this.acceptedCount,
    this.pendingCount,
    this.percentageChange,
  });

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      total: json['total'],
      current: json['current'],
      previous: json['previous'],
      active: json['active'],
      past: json['past'],
      totalCount: json['total_count'],
      acceptedCount: json['accepted_count'],
      pendingCount: json['pending_count'],
      percentageChange: json['percentage_change'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'current': current,
      'previous': previous,
      'active': active,
      'past': past,
      'total_count': totalCount,
      'accepted_count': acceptedCount,
      'pending_count': pendingCount,
      'percentage_change': percentageChange,
    };
  }
}

class AgencyStats {
  final Stats? workers;
  final Stats? employers;

  AgencyStats({this.workers, this.employers});

  factory AgencyStats.fromJson(Map<String, dynamic> json) {
    return AgencyStats(
      workers: json['workers'] != null ? Stats.fromJson(json['workers']) : null,
      employers: json['employers'] != null
          ? Stats.fromJson(json['employers'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'workers': workers?.toJson(), 'employers': employers?.toJson()};
  }
}
