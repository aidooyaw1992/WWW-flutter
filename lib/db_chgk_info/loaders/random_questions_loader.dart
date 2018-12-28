import 'package:what_when_where/db_chgk_info/http_client.dart';
import 'package:what_when_where/db_chgk_info/models/question.dart';
import 'package:what_when_where/db_chgk_info/models/random_questions.dart';

class RandomQuestionsLoader {
  static final _instance = RandomQuestionsLoader._internal();

  RandomQuestionsLoader._internal();

  factory RandomQuestionsLoader() => _instance;

  Future<Iterable<Question>> get() async {
    var map = await HttpClient().get(Uri(path: '/xml/random'));
    var randomQuestions = RandomQuestions.fromJson(map);
    return randomQuestions?.search ?? Iterable<Question>.empty();
  }
}