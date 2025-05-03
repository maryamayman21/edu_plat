import 'package:edu_platt/core/utils/Assets/appAssets.dart';
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/question_model.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/bloc/pdf_exam_bloc.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/pdf_exam_widgets/add_mcq_pdf_question.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/pdf_exam_widgets/questions_listview.dart';
import 'package:edu_platt/presentation/Routes/custom_AppRoutes.dart';
import 'package:edu_platt/presentation/sharedWidget/buttons/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class PdfExamQuestions extends StatefulWidget {
  const PdfExamQuestions({super.key, required this.isWrittenExam});
 final bool isWrittenExam;
  @override
  State<PdfExamQuestions> createState() => _PdfExamQuestionsState();
}

class _PdfExamQuestionsState extends State<PdfExamQuestions> {
  DateTime selectedDate = DateTime.now();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
     print(context.read<PDFExamBloc>().state.exam.courseCode,
     );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Set Exam Questions',
            style: TextStyle(
              fontSize: 22.sp, // Slightly smaller for better balance
              fontWeight: FontWeight.bold,
              color: color.primaryColor,
            ),
          )),
      body: BlocListener<PDFExamBloc, PDFExamState>(
      listener: (context, state) {
        if (state.isSuccess) {
       Navigator.pushNamed(context, AppRouters.writtenPdfCreationScreen, arguments: {'examModel' : state.exam, 'isWrittenExam' : widget.isWrittenExam});
    // TODO: implement listener
        }
      },
      child: BlocBuilder<PDFExamBloc, PDFExamState>(
        builder: (context, state) {
          return BlocSelector<PDFExamBloc, PDFExamState,
              List<QuestionModel>>(
            selector: (state) => state.exam.questions,
            builder: (context, questions) {
              if (questions.isEmpty) {
                return _buildEmptyStateUI(context);
              } else {
                return _buildNonEmptyStateUI(context);
              }
            },
          );
        },
      ),
    ),
    );
  }

  Widget _buildEmptyStateUI(BuildContext context) {
    return Column(
      children: [
        Expanded(child: Image.asset(AppAssets.nnoNotesFound)),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomElevatedButton(
            onPressed: () => _showQuestionBottomSheet(context),
            text: '+ New Question',
          ),
        ),
      ],
    );
  }

  Widget _buildNonEmptyStateUI(BuildContext context) {
    return Stack(
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text('Number of questions : ${context.read<PDFExamBloc>().state.exam.questions.length}',
                  style: TextStyle(
                    fontSize: 16.sp, // Slightly smaller for better balance
                    fontWeight: FontWeight.bold,
                    color: color.primaryColor,
                  ),
                ),
              ),
              Expanded(
                child: QuestionWidgetListView(
                  isWrittenExam: widget.isWrittenExam,
                  questions: context.read<PDFExamBloc>().state.exam.questions,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomElevatedButton(
                  onPressed: () => _showQuestionBottomSheet(context),
                  text: '+ New Question',
                ),
                CustomElevatedButton(
                  onPressed: () {

                    //Navigate to pdf creation view
                    context.read<PDFExamBloc>().add(const CreateExamEvent());


                  },
                  text: 'Create PDF Exam',
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  void _showQuestionBottomSheet(BuildContext context) {
    final pdfExamBloc = context.read<PDFExamBloc>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (modalContext) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: AddMcqQuestionWidget(
              isWrittenExam: widget.isWrittenExam,
              pdfExamBloc:pdfExamBloc,
            ),
          ),
        );
      },
    );
  }
}
