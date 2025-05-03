import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/views/pdf_written_exam.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/question_bottom_sheet/date_picker_widget.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/pdf_exam_widgets/course_code_field.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/pdf_exam_widgets/course_title_field.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/pdf_exam_widgets/level_field.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/pdf_exam_widgets/program_field.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/pdf_exam_widgets/question_modal.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/pdf_exam_widgets/semester_field.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/pdf_exam_widgets/time_filed.dart';
import 'package:edu_platt/presentation/Routes/custom_AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class PdfWrittenQuestionScreen extends StatefulWidget {
  const PdfWrittenQuestionScreen({super.key});

  @override
  State<PdfWrittenQuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<PdfWrittenQuestionScreen> {
  final _formKey = GlobalKey<FormState>();
  String _courseTitle = '';
  String _courseCode = '';
  int _timeInHours = 0;
  String _level = '';
  String _semester = '';
  String _program = '';
  DateTime? date = DateTime.now();
  final List<Question> _questions = [];

  void _addQuestion(Question question) {
    setState(() {
      _questions.add(question);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Text('Create PDF written exam',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              CourseTitleField(
                onChanged:  (value) => _courseTitle = value!,
                courseTitle: _courseTitle,
              ),
              CourseCodeField(
                courseCode: _courseCode,
                 onChanged:  (value) => _courseCode = value!,

              ),

              TimeFiled(
                timeInHour: _timeInHours.toString(),
                onChanged: (value) => _timeInHours = int.parse(value!),

              ),
              MyDatePicker(
                date:date ,
                onChanged: (value) => date = value,
                mode: 'date',
              ),
              LevelField(
               level: _level,
                onChanged: (value) => _level = value,
              ),
              SemesterField(
                semester: _semester ,
                onChanged: (value) => _semester = value,
              ),
              ProgramField(
                program: _program,
                onChanged: (value) => _program = value,
              ),
              const SizedBox(height: 24),

              // Questions List
              Text(
                'Questions:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor
                ),
              ),
              const SizedBox(height: 8),

              if (_questions.isEmpty)
                const Text('No questions added yet'),

              Column(
                children: _questions.asMap().entries.map((entry) {
                  final index = entry.key;
                  final question = entry.value;
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ' ${question.text} ${index + 1}', // Add index here
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          if (question.subQuestions.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: question.subQuestions.asMap().entries.map((subEntry) {
                                final subIndex = subEntry.key;
                                final subQuestion = subEntry.value;
                                return Padding(
                                  padding: EdgeInsets.only(left: 16.w, top: 4.h),
                                  child: Text(
                                    '  ${index + 1}.${subIndex + 1} $subQuestion', // Hierarchical numbering
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                        ],
                      ),
                      subtitle: Text(
                        'Points: ${question.points}',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 14.sp,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          setState(() {
                            _questions.removeAt(index); // Use removeAt with the index
                          });
                        },
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Add Question Button
              ElevatedButton(
                onPressed: () async {
                  final question = await showModalBottomSheet<Question>(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => const QuestionModal(

                    ),
                  );
                  if (question != null) {
                    _addQuestion(question);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Add New Question' ,
                  style: TextStyle(
                  color: Colors.white,
                    fontSize: 18,
                ),),
              ),
              const SizedBox(height: 18),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                 // if (_formKey.currentState!.validate() && _questions.isNotEmpty) {
                   // _formKey.currentState!.save();
                    // Here you would typically save the data
                    //Navigate to pdf create written exam screen

                     final int totalMark = calculateTotalMarks(_questions);
                    final  WrittenExamModel writtenExamModel =
                    // WrittenExamModel(
                    //   totalMark: totalMark,
                    //     questions: _questions,
                    //     ExamDuration: _timeInHours.toString(),
                    //     courseTitle: _courseTitle,
                    //     courseCode:_courseCode,
                    //   date: date,
                    //   level: _level,
                    //   program: _program,
                    //   semester: _semester
                    //
                    // );
                    WrittenExamModel(
                      totalMark: 100,
                      questions: [
                        Question(
                          text: "Question",
                          points: 5,
                          subQuestions: [
                            "Explain the difference between processes and threads",
                            "When would you use multithreading vs multiprocessing?"
                          ],
                        ),
                        Question(
                          text: "Question",
                          points: 5,
                          subQuestions: [
                            "Describe how virtual memory works",
                            "What is the purpose of a page table?"
                          ],
                        ),
                        Question(
                          text: "Question",
                          points: 5,
                          subQuestions: [
                            "Explain the four necessary conditions for deadlock",
                            "How does the Banker's Algorithm prevent deadlocks?"
                          ],
                        ),
                        Question(
                          text: "Question",
                          points: 5,
                          subQuestions: [
                            "Compare FCFS and Round Robin scheduling",
                            "What is convoy effect in CPU scheduling?"
                          ],
                        ),
                        Question(
                          text: "Question",
                          points: 5,
                          subQuestions: [
                            "What is a race condition?",
                            "How do semaphores solve synchronization problems?"
                          ],
                        ),
                        Question(
                          text: "Question",
                          points: 5,
                          subQuestions: [
                            "Explain demand paging",
                            "What is the working set model?"
                          ],
                        ),
                        Question(
                          text: "Question",
                          points: 5,
                          subQuestions: [
                            "Describe the structure of a UNIX inode",
                            "What are hard links vs symbolic links?"
                          ],
                        ),
                        Question(
                          text: "Question",
                          points: 5,
                          subQuestions: [
                            "What is a system call?",
                            "Give examples of process control system calls"
                          ],
                        ),
                        Question(
                          text: "Question",
                          points: 5,
                          subQuestions: [
                            "Explain the concept of thrashing",
                            "How does the operating system detect thrashing?"
                          ],
                        ),
                        Question(
                          text: "Question",
                          points: 5,
                          subQuestions: [
                            "What is a zombie process?",
                            "How does the operating system handle orphan processes?"
                          ],
                        ),
                        Question(
                          text: "Question",
                          points: 5,
                          subQuestions: [
                            "Describe the readers-writers problem",
                            "Provide a solution using semaphores"
                          ],
                        ),
                        Question(
                          text: "Question",
                          points: 5,
                          subQuestions: [
                            "What is disk formatting?",
                            "Explain low-level vs high-level formatting"
                          ],
                        ),
                        Question(
                          text: "Question",
                          points: 5,
                          subQuestions: [
                            "Describe the dining philosophers problem",
                            "What are the solutions to prevent deadlock in this scenario?"
                          ],
                        ),
                        Question(
                          text: "Question",
                          points: 5,
                          subQuestions: [
                            "What is a monolithic kernel?",
                            "Compare with microkernel architecture"
                          ],
                        ),
                        Question(
                          text: "Question",
                          points: 5,
                          subQuestions: [
                            "Explain memory-mapped files",
                            "What are their advantages?"
                          ],
                        ),
                        Question(
                          text: "Question",
                          points: 5,
                          subQuestions: [
                            "What is swap space?",
                            "How does the OS manage it?"
                          ],
                        ),
                        Question(
                          text: "Question",
                          points: 5,
                          subQuestions: [
                            "Describe the producer-consumer problem",
                            "Provide a solution using monitors"
                          ],
                        ),
                        Question(
                          text: "Question",
                          points: 5,
                          subQuestions: [
                            "What is RAID?",
                            "Compare different RAID levels"
                          ],
                        ),
                        Question(
                          text: "Question",
                          points: 5,
                          subQuestions: [
                            "Explain the concept of interrupts",
                            "What is the difference between traps and interrupts?"
                          ],
                        ),
                        Question(
                          text: "Question",
                          points: 5,
                          subQuestions: [
                            "What is a real-time operating system?",
                            "Compare hard vs soft real-time systems"
                          ],
                        ),
                      ],
                      ExamDuration: "2",
                      courseTitle: "Operating Systems",
                      courseCode: "COMP 305",
                      date: DateTime.now(),
                      level: "4",
                      program: "Computer Science",
                      semester: "1",
                    );
                  Navigator.pushNamed(context, AppRouters.writtenPdfCreationScreen, arguments: writtenExamModel);

                  // }else{
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     const SnackBar(content: Text('Please review your inputs')),
                  //   );
                  // }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  ' Create PDF',
                  style: TextStyle(fontSize: 18,
                    color: Colors.white
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  int calculateTotalMarks(List<Question> questions) {
    return questions.fold(0, (total, question) => total + question.points);
  }
}
class WrittenExamModel{
  final List<Question> questions;
  final String ExamDuration;
  final String courseTitle;
  final String courseCode;
  final String level;
  final String semester;
  final DateTime? date;
  final String program;
  final int totalMark;

  WrittenExamModel( {required this.questions,required this.totalMark ,required this.ExamDuration, required this.courseTitle, required this.courseCode, required this.program, required this.semester, required this.level, required this.date});
}

