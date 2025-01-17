import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/core/utils/customDialogs/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubit/notes_cubit.dart';
import '../data/model/note.dart';

class Taskitem extends StatefulWidget {
  const Taskitem({super.key, required this.note});
 final Note note;
  @override
  State<Taskitem> createState() => _TaskitemState();
}

class _TaskitemState extends State<Taskitem> {
  bool isCompleted = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.all(6.0),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: Row(
            children: [
              Container(
                width: 3.w,
                height: 65.h,
                decoration: BoxDecoration(
                  color: color.primaryColor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ///TODO::DATA MODELING
                    Text(
                      widget.note.title,
                      style: TextStyle(
                        color:  widget.note.isDone ? color.secondColor : Colors.black,
                      ),
                    ),
                    Text( widget.note.description,
                        style: TextStyle(
                            color:
                            widget.note.isDone ? color.secondColor : Colors.grey)),
                  ],
                ),
              ),
              Row(
                children: [
                  widget.note.isDone
                      ? Text(
                          'Done',
                          style: TextStyle(
                            color: color.secondColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        )
                      : Container(
                          padding:
                          REdgeInsets.symmetric(vertical: 1, horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: color.primaryColor,
                      ),
                      child: BlocBuilder<NotesCubit, NotesState>(
                       builder: (context, state) {
                           return IconButton(
                            onPressed: () {
                              ///TODO :: UPDATE SERVER AND CACHE
                              context.read<NotesCubit>().updateNote(true, widget.note.id);
                              setState(() {
                                isCompleted = !isCompleted;
                              });
                            },
                            icon: Icon(
                          Icons.check,
                          size: 25.sp,
                          color: Colors.white,
                        ),
                      );
  },
)),
                  BlocBuilder<NotesCubit, NotesState>(
                  builder: (context, state) {
                      return IconButton(
                      onPressed: () async {
                        ///TODO:: DELETE FROM CACHE AND SERVER
                        bool? result = await CustomDialogs.showDeletionDialog(
                          context: context,
                          title: "Delete Task?",
                          content: "Are you sure you want to delete this note?",
                          confirmText: "Delete",
                          cancelText: "Cancel",
                        );

                        if (result == true) {
                          print("Task deleted");
                          context.read<NotesCubit>().deleteNote(widget.note.id);
                        }


                        ///TODO::: CHECK STATES HERE
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Color(0xff615e5e),
                      ));
  },
)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
