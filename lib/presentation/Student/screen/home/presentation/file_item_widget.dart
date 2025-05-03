import 'package:edu_platt/presentation/Student/screen/home/data/model/file_model.dart';
import 'package:flutter/material.dart';

class FileItemWidget extends StatelessWidget {
  final String  fileName;
  final VoidCallback? onTap;
  const FileItemWidget({
    Key? key,
    required this.fileName,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.insert_drive_file_rounded, color: Colors.blue),
      title: Text(fileName),
      onTap: onTap,
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }
}
