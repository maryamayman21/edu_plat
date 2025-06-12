import 'package:edu_platt/core/utils/Assets/appAssets.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/presentation/cubit/course_files_cubit.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/presentation/widgets/file_item_list.dart';
import 'package:edu_platt/presentation/sharedWidget/no_wifi_widget.dart';
import 'package:edu_platt/presentation/sharedWidget/text_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class CourseFilesBlocBuilder extends StatelessWidget {
  const CourseFilesBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<CourseFilesCubit, CourseFilesState > (
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
            FileItemList(
              courseDetailsEntity: courseFiles,
            );
        }
        if (state is CourseFilesNotFound) {
          return SliverToBoxAdapter(child: Center(child:
          Image.asset(AppAssets.noDataFound)
          )
          );
        }
        if (state is CourseFilesLoading) {
          return const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()));
        }
        if (state is CourseFilesFailure) {
          if(state.errorMessage == 'No internet connection'){
            return SliverToBoxAdapter(
              child: NoWifiWidget(
                  onPressed:(){
                BlocProvider.of<CourseFilesCubit>(context).fetchCourseFilesRequest();
              }
              ),
            );
          }
          else {
            return SliverToBoxAdapter(child: TextError(errorMessage:  state.errorMessage,
                onPressed:(){
                  BlocProvider.of<CourseFilesCubit>(context).fetchCourseFilesRequest();
                }
            ));
          }
        }
        return const SliverToBoxAdapter(child: Text('Something went wrong'));
      },
    );
  }
}
