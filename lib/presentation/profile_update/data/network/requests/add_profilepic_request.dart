import 'dart:io';

import 'package:dio/dio.dart';

class UploadProfilePicRequest{
  File? image;

  UploadProfilePicRequest({required this.image});


  Future<FormData> toFormData()async{
    if (image == null || !File(image!.path).existsSync()){
      throw Exception('File does not exist');
    }
    FormData formData = FormData.fromMap({
      "profilePicturee":  await MultipartFile.fromFile(image!.path, filename: image!.path.split('/').last),
    });
    return formData;
  }

}