
import 'dart:io';

import 'package:file_picker/file_picker.dart';


class FilePickerService {
  Future<File?> pickImage({List<String> allowedExtensions = const ['png', 'jpeg', 'jpg']}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
    );

    if (result != null && result.files.single.path != null) {
      return File(result.files.single.path!);
    }

    return null; // No file selected
  }
  Future<FilePickerResult?> pickFile({List<String> allowedExtensions = const ['png', 'jpeg', 'jpg' , 'pdf' , 'doc' , 'docx' , 'ppt' , 'pptx']}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
    );

    if (result != null && result.files.single.path != null) {
      return result;
    }

    return null; // No file selected
  }

  Future<FilePickerResult?> pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result != null && result.files.single.path != null) {
      return result;
    }
  }
}
