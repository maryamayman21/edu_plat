// import 'dart:io';
//
// import 'package:edu_platt/presentation/Doctor/features/course_details_utils/file_picker_service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'cubit/course_files_cubit.dart';
// import 'cubit/dialog_cubit.dart';
// import 'cubit/tab_index_cubit.dart';
// import 'cubit/uploading_status.dart';
// import 'data/data_source/courses_details_local_data_source.dart';
// import 'data/data_source/remote_data_source.dart';
// import 'data/repo/course_details_repoImp.dart';
//
// class FilePreview extends StatelessWidget {
//   const FilePreview(
//       {super.key, required this.fileName, required this.filePath, required this.courseCode, required this.index,});
//
//   final String fileName;
//   final String filePath;
//   final String courseCode;
//   final int index;
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//         create: (context) => CourseDetailsCubit(
//       courseCode: courseCode,
//       dialogCubit: context.read<DialogCubit>(),
//       indexCubit: context.read<IndexCubit>(),
//       courseDetailsRepo: CourseDetailsRepoImp(CourseDetailsLocalDataSourceImpl(), CourseDetailsRemoteDataSourceImpl(ApiService()) , NetworkInfoImpl(InternetConnectionChecker.instance)),
//       filePickerService: FilePickerService(),
//       statusCubit: context.read<StatusCubit>(), // Pass status cubit
//     )..downloadFile(filePath , fileName , index),
//       child: Scaffold(
//         appBar: AppBar(title: Text(fileName)),
//         body: Center(
//             child:
//             BlocBuilder<CourseDetailsCubit, CourseDetailsState>(
//             builder: (context, state) {
//               if(state is OnFileSuccess){
//                 File file = state.file;
//                 return SfPdfViewer.file(
//                   file, // Load the PDF from the file
//                 );
//               }
//               return const CircularProgressIndicator();
//
//   },
// ) // PDF viewer widget
//           //   : Container(
//           // decoration: BoxDecoration(
//           //   image: DecorationImage(image: FileImage(File(fileData.path)),
//           //     fit: BoxFit.fill,
//           //   ),
//           // ),)
//           // Image viewer
//         ),
//       ),
//     );
//   }
// }