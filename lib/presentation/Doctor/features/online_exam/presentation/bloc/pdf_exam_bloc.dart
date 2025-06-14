import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/exam_model.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/option_model.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/model/question_model.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/network/request/fetch_course_data.dart';
import 'package:edu_platt/presentation/Doctor/features/online_exam/data/repo/exam_repository_impl.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'pdf_exam_event.dart';
part 'pdf_exam_state.dart';

class PDFExamBloc extends Bloc<PDFExamEvent, PDFExamState> {
  final DoctorExamRepoImp doctorExamRepoImp;
  PDFExamBloc(
  {
    required this.doctorExamRepoImp
}
      ) : super(PDFExamState.initial()) {
    // on<PDFExamEvent>((event, emit) {
    on<RemoveQuestionEvent>(_handleRemoveQuestionEvent);
    on<UpdateQuestionEvent>(_handleUpdateQuestionEvent);
    on<AddOptionEvent>(_handleAddOptionEvent);
    on<RemoveOptionEvent>(_handleRemoveOptionEvent);
    on<UpdateOptionEvent>(_handleUpdateOptionEvent); // Debounce rapid updates
    on<AddQuestionWithOptionsEvent>(_handleAddQuestionWithOptionsEvent);
    on<SetExamDateEvent>(_handleSetExamDateEvent);
    on<UpdateQuestionMarkEvent>(_handleUpdateQuestionMarkEvent);
    on<CreateExamEvent>(_handleCreateExamEvent);
    on<SetUpExamEvent>(_handleSetUpExamEvent);
    on<FetchCourseDataEvent>(_handleFetchCourseDataEvent);
    on<SetSuccessModeEvent>(_handleSetSuccessModeEvent);

  }


  ///TODO:: HANDLE COURSE INFO REQUEST (COURSE CODE)
  ///TODO:: EMIT LOADING
  ///TODO:: ON SUCCESS : UPDATE STATE AND EMIT SUCCESS -> SHOW QUESTION SCREEN -> PASS MODEL TO PDF SCREEN
  ///TODO:: ON FAILURE : SHOW ERROR WIDGET


  void _handleFetchCourseDataEvent(FetchCourseDataEvent event,
      Emitter<PDFExamState> emit)async{
    emit(state.copyWith(isLoading: true));
    final result = await  doctorExamRepoImp.fetchCourseData(FetchCourseDataRequest(courseCode: event.courseCode));
    // emit(state.copyWith(isLoading: false));
    result.fold(
          (failure) {
        emit(state.copyWith(
            isLoading: false,
            isExamDataFailure: true,
            errorMessage: failure.message,
          isSuccess: false
        ));
      },
          (courseData) {
        emit(state.copyWith(
             exam: state.exam.copyWith(
                 semester: courseData.semester.toString(),
                 program: courseData.program,
                 level: courseData.level.toString(),
                 courseCode: courseData.courseCode,
                 examTitle: courseData.courseTitle,
                 totalMark: courseData.totalMark,
                 timeInHour: courseData.examDuration.toString()),
            isLoading: false,
            isExamDataFailure: false,
            errorMessage:'',
            isExamDataLoaded: true
        ));
      },
    );
  }


  void _handleSetUpExamEvent(
      SetUpExamEvent event,
  Emitter<PDFExamState> emit) async {
    emit(state.copyWith(isLoading: true)); // Set loading state
    final result = await  doctorExamRepoImp.fetchCourses();
    // emit(state.copyWith(isLoading: false));
    result.fold(
          (failure) {
        emit(state.copyWith(
            isLoading: false,
            isFailure: true,
            errorMessage: failure.message
        ));
      },
          (courses) {
        emit(state.copyWith(
          courses: courses,
          isDataLoaded: true,
          isLoading: false,
          isFailure: false, // explicitly reset
            errorMessage:''
        ));
      },
    );
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

  void _handleAddOptionEvent(
      AddOptionEvent event, Emitter<PDFExamState> emit) {
    final currentOptions = state.exam.questions[event.questionIndex].options;
    if (currentOptions.length >= 5) {
      return; // Don't add if there are already 5 or more options
    }

    final updatedQuestions = List<QuestionModel>.from(state.exam.questions);
    updatedQuestions[event.questionIndex] =
        updatedQuestions[event.questionIndex].copyWith(
          options: [
            ...currentOptions,
            OptionModel(text: '')
          ],
        );

    emit(state.copyWith(exam: state.exam.copyWith(questions: updatedQuestions)));
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
       print(state.exam.questions.toString());
    print('UPDATE OPTION EVENT IN BLOC');
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

  void _handleSetExamDateEvent(
      SetExamDateEvent event, Emitter<PDFExamState> emit) {
    emit(state.copyWith(
        exam: state.exam.copyWith(
            examDate: event.examDate,
           )));
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
      final hasEnoughOptions = question.options.length >= 2 && question.options.length < 5;

      final hasEmptyOptionField =
          question.options.any((element) => element.text.isEmpty);

      question.isValid = hasEnoughOptions &&

          !hasEmptyOptionField;

      print('not have empty fields : ${!hasEmptyOptionField}');
      print('Has enough options  : ${hasEnoughOptions}');

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

  void _handleSetSuccessModeEvent(SetSuccessModeEvent event, Emitter<PDFExamState> emit) {
    emit(state.copyWith(isSuccess: false));

  }


}

