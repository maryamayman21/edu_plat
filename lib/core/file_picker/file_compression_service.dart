import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'dart:typed_data';

class FileCompressionService {
  // Compress image file and return the compressed file as a byte array



 static Future<Uint8List> uintListToUintList(Uint8List list) async {
    var result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 640,
      minWidth:  480,
      quality: 96,
    );
    print(list.length);
    print(result.length);
    return result;
  }




  static  Future<Uint8List?> compressFileToUintlist(File image) async {
    try {
      // Compress the image in memory
      final result = await FlutterImageCompress.compressWithFile(
        image.path,
        minWidth: 800, // Adjust width if needed
        minHeight: 800, // Adjust height if needed
        quality: 75,  // You can adjust the quality (0-100)
        format: CompressFormat.jpeg,  // Compress as JPEG (change if needed)
      );

      return result;
    } catch (e) {
      print("Error compressing image: $e");
      return null;
    }
  }





  //This method returns a file in memory (not saved to disk)


}

