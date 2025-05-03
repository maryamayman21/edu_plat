import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/question_model.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/bloc/pdf_exam_bloc.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/labled_text_field.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/pdf_exam_widgets/mcq_option_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class McqQuestionCard extends StatelessWidget {
  const McqQuestionCard({
    super.key,
    required this.question,
    required this.qIndex, required this.isWrittenExam,
  });

  final QuestionModel question;
  final int qIndex;
  final bool isWrittenExam;
  @override
  Widget build(BuildContext context) {
    return Card(
      //borderOnForeground: true,

      color: Theme.of(context).primaryColor.withOpacity(0.9),
      child: Column(
        children: [
          ListTile(
            title: Text(
              question.question.isNotEmpty ? question.question : 'Question ${qIndex + 1}',
              style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(22),
                fontWeight: FontWeight.w700,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () {
                context.read<PDFExamBloc>().add(RemoveQuestionEvent(qIndex));
              },
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: question.options.length,
            itemBuilder: (context, oIndex) {
              return McqOptionTile(
                qIndex: qIndex,
                oIndex: oIndex,
                optionText: question.options[oIndex].text,
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.add_circle_outline,
                color: Colors.white, size: ScreenUtil().setWidth(24)),
            onPressed: () {
              context.read<PDFExamBloc>().add(AddOptionEvent(qIndex));
            },
          ),
          isWrittenExam ?
          LabeledTextField(
            controller: TextEditingController(text: question.degree.toString()),
            label: 'Mark',
            keyboardType: TextInputType.number,
            onChanged: (value) {
              context.read<PDFExamBloc>().add(UpdateQuestionMarkEvent(int.parse(value.isEmpty ? '0' : value) , qIndex));
            },
            hintText: 'Mark',
          )  : const SizedBox.shrink()
        ],
      ),
    );
  }
}