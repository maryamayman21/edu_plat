import 'package:edu_platt/presentation/Doctor/features/course_details/cubit/tab_index_cubit.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/widgets/course_tabs.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details/widgets/tab_bar_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class TabsBlocBuilder extends StatelessWidget {
  const TabsBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return   //material tabs
      SliverPersistentHeader(
          pinned: true,
          delegate: TabBarDelegate(
            child: BlocBuilder<IndexCubit, int>(
              builder: (context, index) {
                return CourseTabsWidget(
                  onTabChanged: (index) {
                    BlocProvider.of<IndexCubit>(context).updateIndex(index);
                  },
                  currentIndex: index,);
              },
            ),
          )
      );
  }
}
