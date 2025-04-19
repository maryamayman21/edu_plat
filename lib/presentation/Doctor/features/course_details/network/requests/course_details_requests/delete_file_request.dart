
class DeleteFileRequest{
  final int id;
  //final String type;

  DeleteFileRequest({required this.id});


  // Convert object to JSON
  Map<String, dynamic> toJson() {
    return {'id': id};
  }

  // Create object from JSON
  // factory DeleteFileRequest.fromJson(Map<String, dynamic> json) {
  //   return DeleteFileRequest(id: json['id']);
  // }
}