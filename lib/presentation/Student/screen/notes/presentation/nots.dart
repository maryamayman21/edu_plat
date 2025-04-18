import 'package:edu_platt/core/utils/Assets/appAssets.dart';
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Student/screen/notes/data/model/note.dart';
import 'package:edu_platt/presentation/Student/screen/notes/presentation/floatButtonSheet.dart';
import 'package:edu_platt/presentation/Student/screen/notes/presentation/taskItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../sharedWidget/buttons/custom_button.dart';
import '../cubit/notes_cubit.dart';



class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          extendBody: true,
          floatingActionButton:
                 FloatingActionButton(
                backgroundColor: color.primaryColor,
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child: const Floatbuttonsheet(),
                          ));
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),

          body: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: color.primaryColor,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30.r),
                        bottomLeft: Radius.circular(30.r))),
                child: TableCalendar(
                  daysOfWeekStyle: const DaysOfWeekStyle(
                    weekdayStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  daysOfWeekHeight: 23.h,
                  focusedDay: _focusedDay,
                  firstDay: DateTime(2000),
                  lastDay: DateTime(2100),
                  calendarFormat: CalendarFormat.week,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  //TODO:: UPDATE THE INCOMING TASKS UPON DATE
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                  headerStyle: HeaderStyle(
                    rightChevronIcon: const Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                    ),
                    leftChevronIcon: const Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                    ),
                    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20.sp),
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                  calendarStyle: const CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    weekendTextStyle: TextStyle(
                      color: Colors.white,
                    ),
                    defaultTextStyle: TextStyle(
                      color: Colors.white, //
                    ),
                    todayTextStyle: TextStyle(
                      color: Colors.black, //
                    ),
                    selectedDecoration: BoxDecoration(
                      color: color.secondColor, //
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              BlocListener<NotesCubit, NotesState>(
      listener: (context, state) {
        // TODO: implement listener
        if(state is NotesFailure){

          ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(
                content: Text('${state.errorMessage}')),
          );
        }
      },
      child: BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        if(state is NotesSuccess ) {
          List<Note> notes = state.notes;
          return Expanded(
            ///TODO:: GET LIST ON SUCCESS FROM DATA SOURCE -> FOR EVERY TASK -> TITLE -> DES-> ONDELETE -> ONUPDATE
              child: ListView.builder(
                itemBuilder: (context, index) =>  Taskitem(note: notes[index],),
                itemCount: notes.length,
              ));
        }else if(state is NotesNotFound){

            return Column(
              children: [
                Image.asset(AppAssets.nnoNotesFound),
        const Text('No Tasks yet.',
        style: TextStyle(
        color: color.primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          fontFamily: 'Roboto-Mono'
        ),
        )
              ],
            );

        }
        else if(state is NotesLoading){
           return const Center(child: CircularProgressIndicator());
         }
    else if(state is NotesFailure){
          return Column(
            children:  [
              Image.asset(AppAssets.noWifiConnection),
               const Text('No internet connection',
                    style: TextStyle(
                     color: Colors.black
                     ),

               ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 40),
                child: CustomButtonWidget(
                  onPressed: () {
                    context.read<NotesCubit>().getAllNotes();
                  },
                  child: const Text('Retry',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              )
            ],
          );
        }
        return const Text('Something went wrong',
        style: TextStyle(
          color: Colors.black
        ),
        );
      },

      ),
      ),
            ],
          ),
        );
  }
}
