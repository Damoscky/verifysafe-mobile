class Services {
  final int? activeWorkersCount;
  final bool? trainingServiceProvided;
  final dynamic placementRegion;
  final dynamic averagePlacementTime;

  Services({
    this.activeWorkersCount,
    this.trainingServiceProvided,
    this.placementRegion,
    this.averagePlacementTime,
  });

  factory Services.fromJson(Map<String, dynamic> json) => Services(
    activeWorkersCount: json["active_workers_count"],
    trainingServiceProvided: json["training_service_provided"],
    placementRegion: json["placement_region"],
    averagePlacementTime: json["average_placement_time"],
  );

  Map<String, dynamic> toJson() => {
    "active_workers_count": activeWorkersCount,
    "training_service_provided": trainingServiceProvided,
    "placement_region": placementRegion,
    "average_placement_time": averagePlacementTime,
  };
}