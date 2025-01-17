import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../widgets/uploadFile_headr.dart';

class FilePreview extends StatelessWidget {
  const FilePreview({super.key, required this.fileData});
  final FileData fileData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text('${fileData.name}')),
      body: Center(
        child: fileData.extension == 'pdf'
            ? SfPdfViewer.file(
          File(fileData.path), // Load the PDF from the file

        )// PDF viewer widget
            : Container(
              decoration: BoxDecoration(
                 image: DecorationImage(image: FileImage(File(fileData.path)),
                   fit: BoxFit.fill,
                 ),
                 ),)
     // Image viewer
      ),
    );
  }
}
