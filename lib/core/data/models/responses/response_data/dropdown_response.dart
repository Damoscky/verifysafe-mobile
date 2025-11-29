class DropdownResponse {
  List<String>? businessType;
  List<String>? jobCategory;
  List<String>? jobRole;
  List<String>? placementRegion;
  List<String>? averagePlacementTime;
  List<String>? relationships;

  DropdownResponse({
    this.businessType,
    this.jobCategory,
    this.jobRole,
    this.placementRegion,
    this.averagePlacementTime,
    this.relationships,
  });

  factory DropdownResponse.fromJson(Map<String, dynamic> json) {
    return DropdownResponse(
      businessType: json['business_type'] != null
          ? List<String>.from(json['business_type'])
          : null,
      jobCategory: json['job_category'] != null
          ? List<String>.from(json['job_category'])
          : null,
      jobRole: json['job_role'] != null
          ? List<String>.from(json['job_role'])
          : null,
      placementRegion: json['placement_region'] != null
          ? List<String>.from(json['placement_region'])
          : null,
      averagePlacementTime: json['average_placement_time'] != null
          ? List<String>.from(json['average_placement_time'])
          : null,
      relationships: json['relationships'] != null
          ? List<String>.from(json['relationships'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'business_type': businessType,
      'job_category': jobCategory,
      'job_role': jobRole,
      'placement_region': placementRegion,
      'average_placement_time': averagePlacementTime,
      'relationships': relationships,
    };
  }
}