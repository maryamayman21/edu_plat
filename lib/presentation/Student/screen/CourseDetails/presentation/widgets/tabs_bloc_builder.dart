import 'package:edu_platt/presentation/Doctor/features/course_details/cubit/tab_index_cubit.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/widgets/course_tabs.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/widgets/tab_bar_delegate.dart';
import 'package:edu_platt/presentation/Student/screen/CourseDetails/presentation/cubit/material_type_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class TabsBlocBuilder extends StatelessWidget {
  const TabsBlocBuilder({super.key, required this.hasLab});
  final bool hasLab;
  @override
  Widget build(BuildContext context) {
    return   //material tabs
      SliverPersistentHeader(
          pinned: true,
          delegate: TabBarDelegate(
            child: BlocBuilder<MaterialTypeCubit, Map<String, dynamic>>(
              builder: (context, map) {
                return CourseTabsWidget(
                  hasLab: hasLab,
                  onTabChanged: (type) {
                    BlocProvider.of<MaterialTypeCubit>(context).updateType(type);
                  },
                  currentIndex: map['currentIndex'],);
              },
            ),
          )
      );
  }
}
