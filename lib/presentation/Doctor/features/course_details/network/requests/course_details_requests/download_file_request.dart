class DownloadFileRequest {
  final String filePath;

  DownloadFileRequest({required this.filePath});

  // Convert object to JSON
  Map<String, dynamic> toJson() {
    return {'filePath': filePath};
  }

  // Create object from JSON
  factory DownloadFileRequest.fromJson(Map<String, dynamic> json) {
    return DownloadFileRequest(filePath: json['filePath']);
  }
}
