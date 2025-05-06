import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/exam_model.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/option_model.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/question_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'pdf_exam_event.dart';
part 'pdf_exam_state.dart';

class PDFExamBloc extends Bloc<PDFExamEvent, PDFExamState> {
  PDFExamBloc() : super(PDFExamState.initial()) {
    // on<PDFExamEvent>((event, emit) {
    on<RemoveQuestionEvent>(_handleRemoveQuestionEvent);
    on<UpdateQuestionEvent>(_handleUpdateQuestionEvent);
    on<AddOptionEvent>(_handleAddOptionEvent);
    on<RemoveOptionEvent>(_handleRemoveOptionEvent);
    on<UpdateOptionEvent>(_handleUpdateOptionEvent); // Debounce rapid updates
    on<AddQuestionWithOptionsEvent>(_handleAddQuestionWithOptionsEvent);
    on<SetExamDataEvent>(_handleSetExamDataEvent);
    on<UpdateQuestionMarkEvent>(_handleUpdateQuestionMarkEvent);
    on<CreateExamEvent>(_handleCreateExamEvent);
    // });
  }

  void _handleRemoveQuestionEvent(
      RemoveQuestionEvent event, Emitter<PDFExamState> emit) {
    final updatedQuestions = List<QuestionModel>.from(state.exam.questions)
      ..removeAt(event.index);
    emit(state.copyWith(
      exam: state.exam.copyWith(
        questions: updatedQuestions,
      ),
    ));
  }

  void _handleUpdateQuestionEvent(
      UpdateQuestionEvent event, Emitter<PDFExamState> emit) {
    final updatedQuestions = List<QuestionModel>.from(state.exam.questions);
    updatedQuestions[event.index] =
        updatedQuestions[event.index].copyWith(question: event.question);

    emit(
        state.copyWith(exam: state.exam.copyWith(questions: updatedQuestions)));
  }

  void _handleAddOptionEvent(AddOptionEvent event, Emitter<PDFExamState> emit) {
    final updatedQuestions = List<QuestionModel>.from(state.exam.questions);
    updatedQuestions[event.questionIndex] =
        updatedQuestions[event.questionIndex].copyWith(
      options: [
        ...updatedQuestions[event.questionIndex].options,
        OptionModel(text: '')
      ],
    );

    emit(
        state.copyWith(exam: state.exam.copyWith(questions: updatedQuestions)));
  }

  void _handleRemoveOptionEvent(
      RemoveOptionEvent event, Emitter<PDFExamState> emit) {
    final updatedQuestions = List<QuestionModel>.from(state.exam.questions);
    final updatedOptions =
        List<OptionModel>.from(updatedQuestions[event.questionIndex].options);

    if (event.optionIndex >= 0 && event.optionIndex < updatedOptions.length) {
      updatedOptions.removeAt(event.optionIndex);
    }

    updatedQuestions[event.questionIndex] =
        updatedQuestions[event.questionIndex].copyWith(
      options: updatedOptions,
      isValid: updatedOptions.isNotEmpty,
    );

    emit(
        state.copyWith(exam: state.exam.copyWith(questions: updatedQuestions)));
  }

  void _handleUpdateOptionEvent(
      UpdateOptionEvent event, Emitter<PDFExamState> emit) {
    final updatedQuestions = List<QuestionModel>.from(state.exam.questions);
    final options =
        List<OptionModel>.from(updatedQuestions[event.questionIndex].options);
    options[event.optionIndex] = OptionModel(text: event.option);

    updatedQuestions[event.questionIndex] =
        updatedQuestions[event.questionIndex].copyWith(
      options: options,
      isValid: event.option.isNotEmpty,
    );

    emit(
        state.copyWith(exam: state.exam.copyWith(questions: updatedQuestions)));
  }

  void _handleAddQuestionWithOptionsEvent(
      AddQuestionWithOptionsEvent event, Emitter<PDFExamState> emit) {
    final updatedOptions = event.options.asMap().entries.map((entry) {
      final index = entry.key;
      final optionText = entry.value;
      return OptionModel(
        text: optionText,
      );
    }).toList();

    final updatedQuestions = [
      ...state.exam.questions,
      QuestionModel(
        question: event.questionText,
        options: updatedOptions,
        degree: event.questionDegree,
      ),
    ];

    emit(state.copyWith(
      exam: state.exam.copyWith(
        questions: updatedQuestions,
      ),
    ));
  }

  void _handleSetExamDataEvent(
      SetExamDataEvent event, Emitter<PDFExamState> emit) {
    emit(state.copyWith(
        exam: state.exam.copyWith(
            examDate: event.examDate,
            semester: event.semester,
            program: event.program,
            level: event.level,
            courseCode: event.courseCode,
            examTitle: event.courseTitle,
            totalMark: event.totalMark,
            timeInHour: event.timeInHour)));
  }

  void _handleUpdateQuestionMarkEvent(
      UpdateQuestionMarkEvent event, Emitter<PDFExamState> emit) {
    final updatedQuestions = List<QuestionModel>.from(state.exam.questions);
    updatedQuestions[event.questionIndex] =
        updatedQuestions[event.questionIndex]
            .copyWith(degree: event.mark, isValid: event.mark! > 0);
    emit(state.copyWith(
        exam: state.exam.copyWith(
      questions: updatedQuestions,
    )));
  }

  PDFExamModel _validateExam(PDFExamModel exam) {
    bool isExamValid = true;

    for (var question in exam.questions) {
      final hasEnoughOptions = question.options.length >= 2;

      final hasEmptyOptionField =
          question.options.any((element) => element.text.isEmpty);

      question.isValid = hasEnoughOptions &&
          //  hasValidDegree &&
          !hasEmptyOptionField;

      if (!question.isValid) {
        isExamValid = false;
      }
    }

    return exam.copyWith(isValid: isExamValid);
  }

  void _handleCreateExamEvent(
      CreateExamEvent event, Emitter<PDFExamState> emit) async {
    final updatedExam = _validateExam(state.exam);
    if (updatedExam.isValid) {
      emit(state.copyWith(isSuccess: true, exam: updatedExam));
    } else {
      emit(state.copyWith(exam: updatedExam));
    }
  }
}
