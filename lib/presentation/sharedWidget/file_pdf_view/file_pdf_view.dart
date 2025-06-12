import 'package:edu_platt/core/network/api_service.dart';
import 'package:edu_platt/core/network/internet_connection_service.dart';
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Student/screen/home/data/remote_data_source/remote_data_source.dart';
import 'package:edu_platt/presentation/Student/screen/home/data/repo/home_repoImp.dart';
import 'package:edu_platt/presentation/Student/screen/home/presentation/cubit/student_files_cubit.dart';
import 'package:edu_platt/presentation/Student/screen/home/presentation/file_item_listview.dart';
import 'package:edu_platt/presentation/sharedWidget/text_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';


class PdfFileScreen extends StatelessWidget {

   final String fileType;
  const PdfFileScreen({Key? key, required this.fileType,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) =>StudentFilesCubit(
    homeRepoImp:
      HomeRepoImp(HomeRemoteDataSourceImp(  apiService:   ApiService()) ,
          NetworkInfoImpl(InternetConnectionChecker())
  ),
  )..fetchCourseCard(fileType),
  child: Scaffold(
    appBar: AppBar(
      title: Text(
      fileType,
        style: TextStyle(
          fontSize: 22.sp, // Slightly smaller for better balance
          fontWeight: FontWeight.bold,
          color: color.primaryColor,
        ),
      ),
      centerTitle: true,
    ),
      body: BlocBuilder<StudentFilesCubit, StudentFilesState>(
           builder: (context, state){
             if(state is StudentFilesLoading){
               return const Center(child: CircularProgressIndicator());
             }
             else if(state is StudentFilesSuccess){
               return FileListWidget(
                 files: state.files,
               );
             }
             else if(state is StudentFilesFailure){
                 return TextError(errorMessage: state.errorMessage,
                     onPressed:(){
                       context.read<StudentFilesCubit>().fetchCourseCard(fileType);
                     }
                 );
             }
             else {
               return  TextError(errorMessage:'Something went wrong',
                   onPressed:(){
                     context.read<StudentFilesCubit>().fetchCourseCard(fileType);
                   }
               );
             }
  },
),
    ),
);
  }
}