import 'package:injectable/injectable.dart';
import 'package:what_when_where/db_chgk_info/loaders/random_questions_loader.dart';
import 'package:what_when_where/db_chgk_info/models/dto_models/random_questions_dto.dart';
import 'package:what_when_where/db_chgk_info/models/question.dart';
import 'package:what_when_where/db_chgk_info/models/random_questions.dart';
import 'package:what_when_where/db_chgk_info/parsers/xml2json_parser.dart';
import 'package:what_when_where/services/background.dart';

abstract class IRandomQuestionsRepository {
  Future<Iterable<Question>> get();
}

@lazySingleton
@RegisterAs(IRandomQuestionsRepository)
class RandomQuestionsRepository implements IRandomQuestionsRepository {
  final IRandomQuestionsLoader _loader;
  final IXmlToJsonParser _parser;
  final IBackgroundRunnerService _backgroundService;

  const RandomQuestionsRepository({
    IRandomQuestionsLoader loader,
    IXmlToJsonParser parser,
    IBackgroundRunnerService backgroundService,
  })  : _loader = loader,
        _parser = parser,
        _backgroundService = backgroundService;

  @override
  Future<Iterable<Question>> get() async {
    final dto = await _loader.get();
    final result = await _backgroundService
        .run<Iterable<Question>, List<dynamic>>(
            _questionsFromRandomQuestionsDto, [dto]);
    return result;
  }
}

Iterable<Question> _questionsFromRandomQuestionsDto(List<dynamic> args) {
  final dto = args[0] as RandomQuestionsDto;

  return RandomQuestions.fromDto(dto).questions;
}