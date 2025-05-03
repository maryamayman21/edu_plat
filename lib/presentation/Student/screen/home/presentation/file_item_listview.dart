import 'package:edu_platt/presentation/Routes/custom_AppRoutes.dart';
import 'package:edu_platt/presentation/Student/screen/home/data/model/file_model.dart';
import 'package:edu_platt/presentation/Student/screen/home/domain/entity/file_entity.dart';
import 'package:flutter/material.dart';
import 'file_item_widget.dart';


class FileListWidget extends StatelessWidget {
  final List<FileEntity> files;


  const FileListWidget({
    Key? key,
    required this.files,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (files.isEmpty) {
      return const Center(
        child: Text(
          'No files available',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: files.length,
      itemBuilder: (context, index) {
        final file = files[index];
        return FileItemWidget(
          fileName: file.fileName,
          onTap: (){
            Navigator.pushNamed(context,AppRouters.pdfViewerScreen, arguments: {
              'pdfUrl' : file.filePath,
              'pdfName' : file.fileName
            } );
          }
        );
      },
    );
  }
}
