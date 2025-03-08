import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';


class UploadfileHeadr extends StatefulWidget {
  const UploadfileHeadr({super.key, required this.onFilesUploaded});
  final Function(List<FileData>) onFilesUploaded;

  @override
  State<UploadfileHeadr> createState() => _UploadfileHeadrState();
}

class _UploadfileHeadrState extends State<UploadfileHeadr>
    with SingleTickerProviderStateMixin {
  late AnimationController loadingController;
  File? _file;
  PlatformFile? _platformFile;
  selectFile() async {
    final file = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpeg', 'jpg', 'pdf'],
      allowMultiple: true,

    );
    if (file != null) {
      _file = File(file.files.single.path!);
      _platformFile = file.files.first;
      final List<FileData> files = file.files.map((file) {
        return FileData(
          extension: file.extension!  ,
          name: file.name,
          size: file.size,
          path: file.path!,
          date: DateTime.now(),
        );
      }).toList();
      loadingController.reset();
      loadingController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _platformFile = null;
            _file = null;
          });
          widget.onFilesUploaded(files);
          files.clear();
        }
      });
    }
    loadingController.forward();
  }

  @override
  void initState() {
    loadingController = AnimationController(
        vsync: this,
        duration: const Duration(
          seconds: 3,
        ))
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    loadingController.dispose(); // Clean up the animation controller.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        GestureDetector(
          onTap: selectFile,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(14),
              dashPattern: [10, 4],
              strokeCap: StrokeCap.round,
              color: Colors.green.shade400,
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                    color: Colors.green.shade50.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.folder_open_rounded,
                      color: Colors.green,
                      size: 40,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Upload files',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        _platformFile != null
            ? Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selected files',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 21,
                          fontFamily: 'Roboto-Mono',
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            offset: const Offset(0, 1),
                            blurRadius: 3,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          _platformFile!.extension == 'pdf'?
                          const Icon(Icons.picture_as_pdf, color: Colors.red, size: 40,) :
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child:
                            Image.file(
                              _file!,
                              width: 50,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _platformFile!.name,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${(_platformFile!.size / 1024).ceil()} KB',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: 5,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.green.shade50,
                                ),
                                child: LinearProgressIndicator(
                                  value: loadingController.value,
                                ),
                              )
                            ],
                          )),
                          const SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    )
                  ],
                ),
              )
            : Container(),
        // SizedBox(height: 150,),
      ],
    );
  }
}

class FileData {
  final String name;
  final int size;
  final String path;
  final DateTime date;
  final String extension;

  FileData(
       {required this.extension,
    required this.name,
    required this.size,
    required this.path,
    required this.date,
  });
}
