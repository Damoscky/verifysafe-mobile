class Review {
  final String? id;
  final DateTime? date;
  final String? feedback;
  final dynamic rating;
  final dynamic avatar;
  final String? name;
  final String? revieweeType;
  final dynamic jobType;
  final String? code;
  final String? status;

  Review({
    this.id,
    this.date,
    this.feedback,
    this.rating,
    this.avatar,
    this.name,
    this.revieweeType,
    this.jobType,
    this.code,
    this.status,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json["id"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    feedback: json["feedback"],
    rating: json["rating"],
    avatar: json["avatar"],
    name: json["name"],
    revieweeType: json["reviewee_type"],
    jobType: json["job_type"],
    code: json["code"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date?.toIso8601String(),
    "feedback": feedback,
    "rating": rating,
    "avatar": avatar,
    "name": name,
    "reviewee_type": revieweeType,
    "job_type": jobType,
    "code": code,
    "status": status,
  };
}