import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/exam_model.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/question_model.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/option_model.dart';

part 'online_exam_event.dart';
part 'online_exam_state.dart';

class OnlineExamBloc extends Bloc<OnlineExamEvent, OnlineExamState> {
  OnlineExamBloc() : super(OnlineExamState.initial()) {
    // Event Handlers
    on<RemoveQuestionEvent>(_handleRemoveQuestionEvent);
    on<UpdateQuestionEvent>(_handleUpdateQuestionEvent);
    on<AddOptionEvent>(_handleAddOptionEvent);
    on<RemoveOptionEvent>(_handleRemoveOptionEvent);
    on<UpdateOptionEvent>(_handleUpdateOptionEvent); // Debounce rapid updates
    on<SelectCorrectAnswerEvent>(_handleSelectCorrectAnswerEvent);
    on<AddQuestionWithOptionsEvent>(_handleAddQuestionWithOptionsEvent);
    on<SetExamDateEvent>(_handleSetExamDateEvent);
    on<SetExamCourseCodeEvent>(_handleSetExamCourseCodeEvent);
    on<UpdateQuestionDurationEvent>(_handleUpdateQuestionDurationEvent);
    on<UpdateQuestionMarkEvent>(_handleUpdateQuestionMarkEvent);
    on<CreateExamEvent>(_handleCreateExamEvent);
  }

  // Helper Methods
  Duration _calculateTotalDuration(List<QuestionModel> questions) {
    return questions.fold(
      Duration.zero,
          (previousDuration, question) => previousDuration + question.questionDuration,
    );
  }

  int _calculateTotalDegrees(List<QuestionModel> questions) {
    return questions.fold(
      0,
          (previousDegrees, question) => previousDegrees + question.degree,
    );
  }

  ExamModel _validateExam(ExamModel exam) {
    bool isExamValid = true;

    for (var question in exam.question) {
      final hasEnoughOptions = question.options.length >= 2;
      final hasValidDegree = question.degree > 0;
      final hasCorrectAnswer = question.options.any((element) => element.isCorrectAnswer);
      final hasEmptyOptionField = question.options.any((element) => element.text.isEmpty);

      question.isValid = hasEnoughOptions && hasValidDegree && hasCorrectAnswer && !hasEmptyOptionField;

      if (!question.isValid) {
        isExamValid = false;
      }
    }

    return exam.copyWith(isValid: isExamValid);
  }

  // Debouncer for rapid events
  // EventTransformer<Event> debounce<Event>(Duration duration) {
  //   return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  // }

  // Event Handlers
  void _handleRemoveQuestionEvent(RemoveQuestionEvent event, Emitter<OnlineExamState> emit) {
    final updatedQuestions = List<QuestionModel>.from(state.exam.question)..removeAt(event.index);
    final examDuration = _calculateTotalDuration(updatedQuestions);
    final totalDegrees = _calculateTotalDegrees(updatedQuestions);
    final noOfQuestions = updatedQuestions.length;

    emit(state.copyWith(
      exam: state.exam.copyWith(
        question: updatedQuestions,
        totalDegrees: totalDegrees,
        noOfQuestions: noOfQuestions,
        examDuration: examDuration,
      ),
    ));
  }

  void _handleUpdateQuestionEvent(UpdateQuestionEvent event, Emitter<OnlineExamState> emit) {
    final updatedQuestions = List<QuestionModel>.from(state.exam.question);
    updatedQuestions[event.index] = updatedQuestions[event.index].copyWith(question: event.question);

    emit(state.copyWith(exam: state.exam.copyWith(question: updatedQuestions)));
  }

  void _handleAddOptionEvent(AddOptionEvent event, Emitter<OnlineExamState> emit) {
    final updatedQuestions = List<QuestionModel>.from(state.exam.question);
    updatedQuestions[event.questionIndex] = updatedQuestions[event.questionIndex].copyWith(
      options: [...updatedQuestions[event.questionIndex].options, OptionModel(text: '')],
    );

    emit(state.copyWith(exam: state.exam.copyWith(question: updatedQuestions)));
  }

  void _handleRemoveOptionEvent(RemoveOptionEvent event, Emitter<OnlineExamState> emit) {
    final updatedQuestions = List<QuestionModel>.from(state.exam.question);
    final updatedOptions = List<OptionModel>.from(updatedQuestions[event.questionIndex].options);

    if (event.optionIndex >= 0 && event.optionIndex < updatedOptions.length) {
      updatedOptions.removeAt(event.optionIndex);
    }

    updatedQuestions[event.questionIndex] = updatedQuestions[event.questionIndex].copyWith(
      options: updatedOptions,
      isValid: updatedOptions.isNotEmpty,
    );

    emit(state.copyWith(exam: state.exam.copyWith(question: updatedQuestions)));
  }

  void _handleUpdateOptionEvent(UpdateOptionEvent event, Emitter<OnlineExamState> emit) {
    final updatedQuestions = List<QuestionModel>.from(state.exam.question);
    final options = List<OptionModel>.from(updatedQuestions[event.questionIndex].options);
    options[event.optionIndex] = OptionModel(text: event.option);

    updatedQuestions[event.questionIndex] = updatedQuestions[event.questionIndex].copyWith(
      options: options,
      isValid: event.option.isNotEmpty,
    );

    emit(state.copyWith(exam: state.exam.copyWith(question: updatedQuestions)));
  }

  void _handleSelectCorrectAnswerEvent(SelectCorrectAnswerEvent event, Emitter<OnlineExamState> emit) {
    final updatedQuestions = List<QuestionModel>.from(state.exam.question);
    final updatedOptions = updatedQuestions[event.questionIndex].options
        .asMap()
        .map((index, option) => MapEntry(index, option.copyWith(isCorrectAnswer: index == event.optionIndex)))
        .values
        .toList();

    updatedQuestions[event.questionIndex] = updatedQuestions[event.questionIndex].copyWith(options: updatedOptions);

    emit(state.copyWith(exam: state.exam.copyWith(question: updatedQuestions)));
  }

  void _handleAddQuestionWithOptionsEvent(AddQuestionWithOptionsEvent event, Emitter<OnlineExamState> emit) {
    final updatedOptions = event.options.asMap().entries.map((entry) {
      final index = entry.key;
      final optionText = entry.value;
      return OptionModel(
        text: optionText,
        isCorrectAnswer: index == event.correctAnswerIndex,
      );
    }).toList();

    final updatedQuestions = [
      ...state.exam.question,
      QuestionModel(
        question: event.questionText,
        options: updatedOptions,
        degree: event.questionDegree,
        questionDuration: event.duration,
      ),
    ];

    final examDuration = _calculateTotalDuration(updatedQuestions);
    final totalDegrees = _calculateTotalDegrees(updatedQuestions);
    final noOfQuestions = updatedQuestions.length;

    emit(state.copyWith(
      exam: state.exam.copyWith(
        question: updatedQuestions,
        totalDegrees: totalDegrees,
        noOfQuestions: noOfQuestions,
        examDuration: examDuration,
      ),
    ));
  }

  void _handleSetExamDateEvent(SetExamDateEvent event, Emitter<OnlineExamState> emit) {
    emit(state.copyWith(exam: state.exam.copyWith(examDate: event.examDate)));
  }

  void _handleSetExamCourseCodeEvent(SetExamCourseCodeEvent event, Emitter<OnlineExamState> emit) {
    emit(state.copyWith(exam: state.exam.copyWith(courseCode: event.courseCode)));
  }

  void _handleUpdateQuestionDurationEvent(UpdateQuestionDurationEvent event, Emitter<OnlineExamState> emit) {
    final updatedQuestions = List<QuestionModel>.from(state.exam.question);
    updatedQuestions[event.questionIndex] = updatedQuestions[event.questionIndex].copyWith(duration: event.questionDuration);
    final examDuration = _calculateTotalDuration(updatedQuestions);

    emit(state.copyWith(exam: state.exam.copyWith(question: updatedQuestions, examDuration: examDuration)));
  }

  void _handleUpdateQuestionMarkEvent(UpdateQuestionMarkEvent event, Emitter<OnlineExamState> emit) {
    final updatedQuestions = List<QuestionModel>.from(state.exam.question);
    updatedQuestions[event.questionIndex] = updatedQuestions[event.questionIndex].copyWith(degree: event.mark, isValid: event.mark! > 0);
    final totalDegrees = _calculateTotalDegrees(updatedQuestions);

    emit(state.copyWith(exam: state.exam.copyWith(question: updatedQuestions, totalDegrees: totalDegrees)));
  }

  void _handleCreateExamEvent(CreateExamEvent event, Emitter<OnlineExamState> emit) {
    final updatedExam = _validateExam(state.exam);
    emit(state.copyWith(exam: updatedExam));
  }
}