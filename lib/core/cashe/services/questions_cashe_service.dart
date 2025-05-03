import 'package:edu_platt/core/cashe/base_cashe_service.dart';
import 'package:edu_platt/presentation/Student/screen/exam/data/model/submit_question_model.dart';


class QuestionsCacheService {
  static final QuestionsCacheService _instance = QuestionsCacheService._internal();
  final BaseCacheService _baseCacheService = BaseCacheService();

  QuestionsCacheService._internal();
  factory QuestionsCacheService() => _instance;

  final String _keysListKey = 'question_keys';

  Future<void> saveQuestion(SubmitQuestionModel question) async {
    final key = 'question_${question.answerId}';

    await _baseCacheService.save(key, question.toJson());
    await _baseCacheService.appendToListKey(_keysListKey, key);
  }

  Future<SubmitQuestionModel?> getQuestion(int answerId) async {
    final key = 'question_$answerId';
    final data = await _baseCacheService.read(key);
    if (data is Map) {
      return SubmitQuestionModel.fromJson(Map<String, dynamic>.from(data));
    }
    return null;
  }

  Future<List<SubmitQuestionModel>> getAllQuestions() async {
    final keys = await _baseCacheService.getListKeys(_keysListKey) ?? [];
    List<SubmitQuestionModel> questions = [];
        print('keys $keys');
    for (final key in keys) {
      final data = await _baseCacheService.read(key);
      if (data is Map) {
        print('Retrieved from cache: $data');
        questions.add(SubmitQuestionModel.fromJson(Map<String, dynamic>.from(data)));
      } else {
        print('Invalid data for key $key');
      }
    }

    print('Total questions retrieved: ${questions.length}');
    return questions;
  }


  Future<void> clearAllQuestions() async {
    final keys = await _baseCacheService.getListKeys(_keysListKey);
    for (final key in keys) {
      await _baseCacheService.delete(key);
    }
    await _baseCacheService.delete(_keysListKey);
  }
}
