


import 'package:edu_platt/core/network/api_service.dart';
import 'package:edu_platt/core/network/internet_connection_service.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/cubit/course_details_cubit.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/cubit/dialog_cubit.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/cubit/tab_index_cubit.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/cubit/uploading_status.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/data/data_source/courses_details_local_data_source.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/data/data_source/remote_data_source.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/data/repo/course_details_repoImp.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/domain/entities/course_details_entity.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/widgets/course_file_item.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/widgets/course_header.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/widgets/course_tabs.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/widgets/file_loading_widget.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/widgets/tab_bar_delegate.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/widgets/upload_file_header.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details_utils/dialog_helper_function.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details_utils/file_picker_service.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/presentation/cubit/material_type_cubit.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/presentation/widgets/tabs_bloc_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class CourseDetailsViewBody extends StatelessWidget {
  const CourseDetailsViewBody({super.key, required this.courseCode});

  final String courseCode;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MaterialTypeCubit>(
          create: (context) => MaterialTypeCubit(),
        ),
        BlocProvider<StatusCubit>(
          create: (context) => StatusCubit(),
        ),
        BlocProvider<DialogCubit>(
          create: (context) => DialogCubit(),
        ),
        BlocProvider<CourseDetailsCubit>(
          create: (context) => CourseDetailsCubit(
            courseCode: courseCode,
            dialogCubit: context.read<DialogCubit>(),
            materialTypeCubit: context.read<MaterialTypeCubit>(),
            courseDetailsRepo: CourseDetailsRepoImp(CourseDetailsLocalDataSourceImpl(), CourseDetailsRemoteDataSourceImpl(ApiService()) , NetworkInfoImpl(InternetConnectionChecker())),
            filePickerService: FilePickerService(),
            statusCubit: context.read<StatusCubit>(), // Pass status cubit
          ),
        ),
      ],
      child:
      BlocListener<DialogCubit, dynamic>(
      listener: (context, state)async{
        // final dialogCubit = context.read<DialogCubit>();
       if(state == StatusDialog.SUCCESS){
           Navigator.pop(context);
            showSuccessDialog(context);
         }
       if(state == StatusDialog.LOADING){

         showLoadingDialog(context);
        }
         if(state == StatusDialog.FAILURE){
          Navigator.pop(context);
          showErrorDialog(context);
      }


       // if (state == StatusDialog.CONFIRM) {
         // Show confirmation dialog and wait for user action
        //bool? confirmed = await showConfirmDialog(context);
       //   // Update DialogCubit with the user action result
       //   dialogCubit.confirmAction(confirmed!);
       // }
      },
  child: CustomScrollView(
          slivers: [
          CourseHeader(courseCode: courseCode),
      const SliverToBoxAdapter(child: SizedBox(height: 15)),

            const TabsBlocBuilder(
              hasLab: true,
            ),

      const SliverToBoxAdapter(child: SizedBox(height: 15)),

      ///TODO::REFACTOR
      SliverToBoxAdapter(
          child: BlocConsumer<CourseDetailsCubit, CourseDetailsState>(
            listener: (context, state) {
              if (state is CourseFilesFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage),
                  ),
                );
              }
            },
            builder: (context, state) {

              return UploadFileHeader(
                onTap: BlocProvider
                    .of<CourseDetailsCubit>(context)
                    .saveCourseFile,
              );
            },
          )
      ),
            BlocBuilder<StatusCubit, dynamic>(
              builder: (context, uploadStatus) {
                if (uploadStatus is CourseDetailsEntity) {
                  return SliverToBoxAdapter(child: FileLoadingWidget(courseDetailsEntity: uploadStatus,));
                }
                return const SliverToBoxAdapter(child: SizedBox.shrink()); // Hide if not uploading
              },
            ),



      BlocConsumer<CourseDetailsCubit, CourseDetailsState > (
    listener: (context, state) {
      if (state is CourseFilesFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.errorMessage),
          ),
        );
      }
    },
    builder: (context, state) {
      if (state is CourseFilesSuccess) {
        final courseFiles = state.coursesFiles;
        return
          FileListWidget(
            courseCode: courseCode,
            courseDetailsEntity: courseFiles,
            onDeleteFile:(index)async{
          bool? confirmed = await showConfirmDialog(context);
          if(confirmed !=null && confirmed){
            BlocProvider.of<CourseDetailsCubit>(context).deleteFile(index);
          }

        }  ,
        onUpdateFile: (index){
          BlocProvider.of<CourseDetailsCubit>(context).updateFile(index);
        },

        );
      }
      if (state is CourseFilesNotFound) {
        return const SliverToBoxAdapter(child: Center(child: Text('No courses found')));
      }
      if (state is CourseFilesLoading) {
        return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()));
      }

      return const SliverToBoxAdapter(child: Center(child: Text('Something went wrong')));
    },
    ),
      ],
    ),
),);
  }
}
