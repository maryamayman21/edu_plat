import 'dart:io';

import 'package:edu_platt/core/utils/Assets/appAssets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/utils/customDialogs/custom_dialog.dart';
import '../widgets/course_tabs.dart';
import '../widgets/cousre_header.dart';
import '../widgets/file_item.dart';
import '../widgets/uploadFile_headr.dart';

class CourseDetails extends StatefulWidget {
  const CourseDetails({super.key, required this.courseCode});

  final String courseCode;

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  int selectedIndex = 0; // Track the selected tab
  final List<String> courseCategories = ['Material', 'Labs', 'Exams'];


  final Map<int, List<FileData>> tabContent = {
    0: [],
    1: [],
    2: [],
  };
  Future<void> deleteCachedFile(String? filePath) async {
    try {
      final file = File(filePath!);

      // Check if the file exists before attempting to delete it.
      if (await file.exists()) {
        await file.delete();
        print('File deleted successfully: $filePath');
      } else {
        print('File not found: $filePath');
      }
    } catch (e) {
      print('Error deleting file: $e');
    }
  }

  void handleFileUpload(List<FileData> files) {
    setState(() {
      tabContent[selectedIndex]?.addAll(files);
    });
  }
  void handleFileDelete(int index)async {
  bool? isDeleted = await  CustomDialogs.showDeletionDialog(context: context, title: '', content: 'Are you sure you want to delete ${tabContent[selectedIndex]?.first.name}?}');

     if(isDeleted != null && isDeleted){
            await deleteCachedFile( tabContent[selectedIndex]?.elementAt(index).path);

            setState(() {
              print('On delete index : $index');
              print('On delete selected index : $selectedIndex');
              tabContent[selectedIndex]?.removeAt(index);
            });


            CustomDialogs.showSuccessDialog(context: context, title: '', message: 'File deleted successfully!.');


     }

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Header
          CourseHeader(courseCode: widget.courseCode),
          SliverToBoxAdapter(child: SizedBox(height: 15.h)),
          // Tabs
          SliverPersistentHeader(
            pinned: true,
            delegate: TabBarDelegate(
              child: CourseTabs(
                courseCategories: courseCategories,
                selectedIndex: selectedIndex,
                onTabSelected: (index) {
                  setState(() {
                    print(index);
                    selectedIndex = index;
                  });
                },
              ),
            ),
          ),
          // File Upload Section
           SliverToBoxAdapter(
               child: UploadfileHeadr(onFilesUploaded:handleFileUpload ),
           ),
          tabContent[selectedIndex] != null &&  tabContent[selectedIndex]!.isNotEmpty ?
          SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Recently Uploaded',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 21,
                fontFamily: 'Roboto-Mono',
                fontWeight: FontWeight.bold
            ),
                    ),
          ),
      ) : SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Image.asset(AppAssets.noFilesYet),
              )
          ),
          // Dynamic List
          FileListWidget(
            files: tabContent[selectedIndex] ?? [],
            onDelete: (index) => handleFileDelete(index),
          ),
        ],
      ),
    );
  }
}


/// A custom delegate for the pinned tab bar
class TabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  TabBarDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(

      child: Container(
        color: Colors.white, // Background color for the pinned area
        child: child,
      ),
    );
  }

  @override
  double get maxExtent => 52.0; // Height of the tab bar
  @override
  double get minExtent => 52.0; // Height of the tab bar

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true; // No need to rebuild
  }
}
