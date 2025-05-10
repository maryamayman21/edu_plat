import 'dart:io';

import 'package:dio/dio.dart';

class UpdateFileRequest{
 final int id;
 final File file;
 final String type;


  UpdateFileRequest( { required this.id, required this.file, required this.type});

 // factory UpdateFileRequest.fromJson(Map<String, dynamic> json) {
 //   return UpdateFileRequest(
 //     index : 0,
 //     id: json['id'],
 //     file: File(json['filePath']), // Assuming filePath is sent from the server
 //     type: json['type'],
 //   );
 // }
 Future<FormData> toFormData()async{
   if (file == null || !File(file!.path).existsSync()){
     throw Exception('File does not exist');
   }
   print('Print got here inside formData');
   FormData formData = FormData.fromMap({
     'Material_Id': id,
     'File':  await MultipartFile.fromFile(file!.path, filename: file!.path.split('/').last),
     'Type': type,
   });
   return formData;
 }

 Future<FormData> toFormDataVideo()async{
   if (file == null || !File(file!.path).existsSync()){
     throw Exception('File does not exist');
   }
   FormData formData = FormData.fromMap({
     'Video':  await MultipartFile.fromFile(file!.path, filename: file!.path.split('/').last),
     'Type': type,
     'VideoId': id
   });
   return formData;
 }


 // Map<String, dynamic> toJson() {
 //   return {
 //     'id': id,
 //     'file': MultipartFile.fromFile(file!.path, filename: file!.path.split('/').last),
 //     'type': type,
 //   };
 // }

}