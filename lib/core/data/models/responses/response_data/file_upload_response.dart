class FileUploadResponse {
  String? title;
  double? size;
  String? url;
  String? ext;
  String? retrievalId;

  FileUploadResponse({
    this.title,
    this.size,
    this.url,
    this.ext,
    this.retrievalId,
  });

  factory FileUploadResponse.fromJson(Map<String, dynamic> json) {
    return FileUploadResponse(
      title: json['title'] as String?,
      size: json['size'] != null 
          ? (json['size'] is int 
              ? (json['size'] as int).toDouble() 
              : json['size'] as double?)
          : null,
      url: json['url'] as String?,
      ext: json['ext'] as String?,
      retrievalId: json['retrieval_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'size': size,
      'url': url,
      'ext': ext,
      'retrieval_id': retrievalId,
    };
  }
}