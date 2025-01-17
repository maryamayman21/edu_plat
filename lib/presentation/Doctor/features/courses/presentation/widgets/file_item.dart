import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../../Routes/custom_AppRoutes.dart';
import 'uploadFile_headr.dart'; // Import the FileData model
typedef IntCallback = void Function(int value);

class FileListWidget extends StatelessWidget {
  final List<FileData> files;
  //final VoidCallback onDelete;
  final IntCallback onDelete;


  const FileListWidget({
    Key? key,
    required this.files,
    required this.onDelete,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          final file = files[index];

          return InkWell(
            onTap: (){
              Navigator.pushNamed(context, AppRouters.doctorCourseContentPreview, arguments: file );
            },
            child: ListTile(
              leading: file.path.endsWith('.png') ||
                  file.path.endsWith('.jpg') ||
                  file.path.endsWith('.jpeg')
                  ? ClipRRect(
                 borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                                  File(file.path),
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                  )
                  :  const Icon(Icons.picture_as_pdf, color: Colors.red, size: 40,) ,
              title: Text(file.name),
              shape: Border.all(color: Colors.grey.shade400),
              subtitle: Text(
                'Size: ${(file.size / 1024).ceil()} KB\nDate: ${file.date.toLocal()}',
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => onDelete(index),
              ),
            ),
          );
        },
        childCount: files.length,
      ),
    );
  }
}
