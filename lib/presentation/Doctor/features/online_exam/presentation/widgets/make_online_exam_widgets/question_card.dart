 import 'dart:ffi';

import 'package:duration_picker/duration_picker.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/question_model.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/bloc/online_exam_bloc.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/labled_text_field.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/option_widget.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/presentation/widgets/make_online_exam_widgets/question_duration_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class QuestionCard extends StatelessWidget {
  const QuestionCard({
    super.key,
    required this.question,
    required this.qIndex,
  });

  final QuestionModel question;
  final int qIndex;

  @override
  Widget build(BuildContext context) {
    return Card(
      //borderOnForeground: true,

      color: Theme.of(context).primaryColor.withOpacity(0.9),
      child: Column(
        children: [
          ListTile(
            title: Text(
              question.question.isNotEmpty ? question.question : 'New Question',
              style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(22),
                fontWeight: FontWeight.w700,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () {
                context.read<OnlineExamBloc>().add(RemoveQuestionEvent(qIndex));
              },
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: question.options.length,
            itemBuilder: (context, oIndex) {
              print('option in UI : ${question.options[oIndex].text}');
              return OptionTile(
                qIndex: qIndex,
                oIndex: oIndex,
                optionText: question.options[oIndex].text,
                correctOption: question.options[oIndex].isCorrectAnswer,
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.add_circle_outline,
                color: Colors.white, size: ScreenUtil().setWidth(24)),
            onPressed: () {
              context.read<OnlineExamBloc>().add(AddOptionEvent(qIndex));
            },
          ),
          Row(
            children: [
              Expanded(
                child: LabeledTextField(
                  controller: TextEditingController(text: question.degree.toString()),
                  label: 'Mark',
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    context.read<OnlineExamBloc>().add(UpdateQuestionMarkEvent(int.parse(value.isEmpty ? '0' : value) , qIndex));
                  },
                  hintText: 'Mark',
                ),
              ),
              Expanded(
                child: QuestionDurationWidget(
                  questionIndex: qIndex,
                  questionDuration: question!.questionDuration,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}