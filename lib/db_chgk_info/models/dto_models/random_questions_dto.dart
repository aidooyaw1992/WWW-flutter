import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:what_when_where/db_chgk_info/models/dto_models/json_converters/questions_list_converter.dart';
import 'package:what_when_where/db_chgk_info/models/dto_models/question_dto.dart';

part 'random_questions_dto.freezed.dart';
part 'random_questions_dto.g.dart';

@freezed
abstract class RandomQuestionsDto with _$RandomQuestionsDto {
  const factory RandomQuestionsDto({
    @JsonKey(name: 'question')
    @QuestionsListConverter()
        List<QuestionDto> search,
  }) = _RandomQuestionsDto;

  factory RandomQuestionsDto.fromJson(Map<String, dynamic> json) =>
      _$RandomQuestionsDtoFromJson(json);
}
