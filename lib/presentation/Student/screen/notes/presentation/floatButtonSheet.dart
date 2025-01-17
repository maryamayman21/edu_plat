import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Student/screen/notes/presentation/Time_Extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/cashe/services/notes_cache_service.dart';
import '../../../../Auth/service/token_service.dart';
import '../cubit/notes_cubit.dart';
import '../data/model/note.dart';
import '../data/notes_repository/notes_repository.dart';
import '../data/notes_web_service/notes_web_service.dart';


class Floatbuttonsheet extends StatefulWidget {
  const Floatbuttonsheet({super.key});

  @override
  State<Floatbuttonsheet> createState() => _FloatbuttonsheetState();
}

class _FloatbuttonsheetState extends State<Floatbuttonsheet> {
  var taskTitleController = TextEditingController();
  var taskDescController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  DateTime SelectDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.all(50.0),
      child: Container(
        height: MediaQuery
            .of(context)
            .size
            .height * .4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Add New Task',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: color.primaryColor),
            ),
            SizedBox(
              height: 20.h,
            ),
             TextField(
               controller: taskTitleController,
              decoration: const InputDecoration(hintText: 'Task Title'),
            ),
             TextField(
              controller: taskDescController ,
              decoration: const InputDecoration(hintText: 'Task Description'),
            ),
            SizedBox(
              height: 30.h,
            ),
            const Text(
              'Select Date',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w500,
                color: color.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            InkWell(
              onTap: () {
                showMyData();
              },
              child: Text(
                SelectDate.ToFormate,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Container(
                padding: REdgeInsets.symmetric(vertical: 1, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: color.primaryColor,
                ),
                child: BlocBuilder<NotesCubit, NotesState>(
                  builder: (context, state) {
                    return IconButton(
                      onPressed: () {
                        ///TODO :: CREATE TASK AND UPLOAD AND CACHE

                        context.read<NotesCubit>().saveNote(Note(
                            title: taskTitleController.text.trim(),
                            description: taskDescController.text.trim(),
                            date: SelectDate));
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.check,
                        size: 30.sp,
                        color: Colors.white,
                      ),
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }

  void showMyData() async {
    SelectDate = await showDatePicker(
      context: context,
      initialDate: SelectDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    ) ??
        SelectDate;
    setState(() {});
  }
}
