import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/core/utils/validations/date_validation.dart';
import 'package:edu_platt/presentation/Doctor/features/course_details_utils/dialog_helper_function.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/question_bottom_sheet/date_picker_widget.dart';
import 'package:edu_platt/presentation/Student/screen/notes/cubit/notes_cubit.dart';
import 'package:edu_platt/presentation/Student/screen/notes/data/model/note.dart';
import 'package:edu_platt/presentation/Student/screen/notes/presentation/Time_Extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Floatbuttonsheet extends StatefulWidget {
  const Floatbuttonsheet({super.key});

  @override
  State<Floatbuttonsheet> createState() => _FloatbuttonsheetState();
}

class _FloatbuttonsheetState extends State<Floatbuttonsheet> {
  var taskTitleController = TextEditingController();
  var taskDescController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime? SelectDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Form(
key: formKey,
      child: Padding(
        padding: REdgeInsets.all(50.0),
        child: SizedBox(
          height: MediaQuery
              .of(context)
              .size
              .height * .4.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
               Text(
                'Add New Task',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: color.primaryColor),
              ),
              SizedBox(
                height: 20.h,
              ),
               TextFormField(
                 validator: (value) {
                   if (value == null || value.trim().isEmpty) {
                     return 'Can not be empty';
                   }
                   return null;
                 },
                 autovalidateMode: AutovalidateMode.onUserInteraction,
                 controller: taskTitleController,
                decoration: const InputDecoration(hintText: 'Task Title'),
              ),
               TextFormField(
                 validator: (value) {
                   if (value == null || value.trim().isEmpty) {
                     return 'Can not be empty';
                   }
                   return null;
                 },
                 autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: taskDescController ,
                decoration: const InputDecoration(hintText: 'Task Description'),
              ),
              SizedBox(
                height: 10.h,
              ),
              // const Text(
              //   'Select Date',
              //   style: TextStyle(
              //     fontSize: 19,
              //     fontWeight: FontWeight.w500,15+

              //     color: color.primaryColor,
              //   ),
              //   textAlign: TextAlign.center,
              // ),
          MyDatePicker(
            date:SelectDate,
              onChanged: (val){
              SelectDate = val;
            },

                   ),
              // InkWell(
              //   onTap: () {
              //     showSelectedDate();
              //   },
              //   child: Text(
              //     SelectDate?.ToFormateTime?? '',
              //     style: const TextStyle(
              //       fontSize: 15,
              //       fontWeight: FontWeight.w500,
              //       color: Colors.grey,
              //     ),
              //     textAlign: TextAlign.center,
              //   ),
              // ),
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
                          if (!formKey.currentState!.validate()) return;
                          print('selected date : ${SelectDate}');
                          if (isDateTimeInPast(SelectDate?? DateTime.now())) {

                            showErrorDialog(context,  message:  'Date cannot be in the past' );

                          }else {
                            context.read<NotesCubit>().saveNote(Note(
                                title: taskTitleController.text.trim(),
                                description: taskDescController.text.trim(),
                                date: SelectDate ?? DateTime.now()));
                            Navigator.pop(context);
                          }
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
      ),
    );
  }

  void showSelectedDate(){
    MyDatePicker(date:SelectDate,
    onChanged: (val){
      SelectDate = val;
    },

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
