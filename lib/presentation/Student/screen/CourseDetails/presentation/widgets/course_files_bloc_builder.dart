import 'package:edu_platt/presentation/Student/screen/CourseDetails/presentation/cubit/course_files_cubit.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/presentation/widgets/file_item_list.dart';
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
          return const SliverToBoxAdapter(child: Text('No courses found'));
        }
        if (state is CourseFilesLoading) {
          return const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()));
        }
        return const SliverToBoxAdapter(child: Text('Something went wrong'));
      },
    );
  }
}
