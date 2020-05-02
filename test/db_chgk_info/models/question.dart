import 'package:flutter_test/flutter_test.dart';
import 'package:what_when_where/constants.dart';
import 'package:what_when_where/db_chgk_info/models/dto_models/question_dto.dart';
import 'package:what_when_where/db_chgk_info/models/question.dart';
import 'package:what_when_where/db_chgk_info/models/question_section.dart';
import 'package:what_when_where/db_chgk_info/question_parser/sections/section_audio.dart';
import 'package:what_when_where/db_chgk_info/question_parser/sections/section_giveaway.dart';
import 'package:what_when_where/db_chgk_info/question_parser/sections/section_image.dart';
import 'package:what_when_where/db_chgk_info/question_parser/sections/section_text.dart';

void main() {
  final execute = ({
    QuestionDto dto,
    Question expectedQuestion,
  }) {
    // arrange

    // act
    final question = Question.fromDto(dto);

    // assert
    expect(question, expectedQuestion);
  };

  group('Question audio tests', () {
    const oldFormatAudioValue = 'xxx.mp3';
    const oldFormatAudio = '(aud: $oldFormatAudioValue)';
    const newFormatAudioValue =
        'https://db.chgk.info/sites/default/files/xxx.mp3';
    const newFormatAudio = '(aud: $newFormatAudioValue)';

    const audioDbUrl = '${Constants.databaseUrl}/sounds/db/';

    test(
      'audio, question text, old format',
      () => execute(
        dto: const QuestionDto(question: oldFormatAudio),
        expectedQuestion: const Question(
          display: '',
          question: <QuestionSection>[
            AudioSection.fromValue(value: '$audioDbUrl$oldFormatAudioValue'),
          ],
        ),
      ),
    );

    test(
      'audio, question text, new format',
      () => execute(
        dto: const QuestionDto(question: newFormatAudio),
        expectedQuestion: const Question(
          display: '',
          question: <QuestionSection>[
            AudioSection.fromValue(value: newFormatAudioValue),
          ],
        ),
      ),
    );

    test(
      'audio, question text, in the beginning',
      () => execute(
        dto: const QuestionDto(question: '$newFormatAudio text'),
        expectedQuestion: const Question(
          display: 'text',
          question: <QuestionSection>[
            AudioSection.fromValue(value: newFormatAudioValue),
            TextSection.fromValue(value: 'text'),
          ],
        ),
      ),
    );

    test(
      'audio, question text, in the middle',
      () => execute(
        dto: const QuestionDto(question: 'text1 $newFormatAudio text2'),
        expectedQuestion: const Question(
          display: 'text1 text2',
          question: <QuestionSection>[
            TextSection.fromValue(value: 'text1'),
            AudioSection.fromValue(value: newFormatAudioValue),
            TextSection.fromValue(value: 'text2'),
          ],
        ),
      ),
    );

    test(
      'audio, question text, in the end',
      () => execute(
        dto: const QuestionDto(question: '$newFormatAudio text1'),
        expectedQuestion: const Question(
          display: 'text1',
          question: <QuestionSection>[
            AudioSection.fromValue(value: newFormatAudioValue),
            TextSection.fromValue(value: 'text1'),
          ],
        ),
      ),
    );

    test(
      'audio, question text, several entries, old format',
      () => execute(
        dto: const QuestionDto(
            question: 'text1 $oldFormatAudio '
                'text2 $oldFormatAudio '
                'text3 $oldFormatAudio'),
        expectedQuestion: const Question(
          display: 'text1 text2 text3',
          question: <QuestionSection>[
            TextSection.fromValue(value: 'text1'),
            AudioSection.fromValue(value: '$audioDbUrl$oldFormatAudioValue'),
            TextSection.fromValue(value: 'text2'),
            AudioSection.fromValue(value: '$audioDbUrl$oldFormatAudioValue'),
            TextSection.fromValue(value: 'text3'),
            AudioSection.fromValue(value: '$audioDbUrl$oldFormatAudioValue'),
          ],
        ),
      ),
    );

    test(
      'audio, question text, several entries, new format',
      () => execute(
        dto: const QuestionDto(
            question: 'text1 $newFormatAudio '
                'text2 $newFormatAudio '
                'text3 $newFormatAudio'),
        expectedQuestion: const Question(
          display: 'text1 text2 text3',
          question: <QuestionSection>[
            TextSection.fromValue(value: 'text1'),
            AudioSection.fromValue(value: newFormatAudioValue),
            TextSection.fromValue(value: 'text2'),
            AudioSection.fromValue(value: newFormatAudioValue),
            TextSection.fromValue(value: 'text3'),
            AudioSection.fromValue(value: newFormatAudioValue),
          ],
        ),
      ),
    );

    test(
      'audio, question text, without spaces around (), old format',
      () => execute(
        dto: const QuestionDto(question: 'text1${oldFormatAudio}text2'),
        expectedQuestion: const Question(
          display: 'text1text2',
          question: <QuestionSection>[
            TextSection.fromValue(value: 'text1'),
            AudioSection.fromValue(value: '$audioDbUrl$oldFormatAudioValue'),
            TextSection.fromValue(value: 'text2'),
          ],
        ),
      ),
    );

    test(
      'audio, question text, without spaces around (), new format',
      () => execute(
        dto: const QuestionDto(question: 'text1${newFormatAudio}text2'),
        expectedQuestion: const Question(
          display: 'text1text2',
          question: <QuestionSection>[
            TextSection.fromValue(value: 'text1'),
            AudioSection.fromValue(value: newFormatAudioValue),
            TextSection.fromValue(value: 'text2'),
          ],
        ),
      ),
    );

    test(
      'audio, answer text, new format',
      () => execute(
        dto: const QuestionDto(answer: newFormatAudio),
        expectedQuestion: const Question(
          answer: <QuestionSection>[
            AudioSection.fromValue(value: newFormatAudioValue),
          ],
        ),
      ),
    );

    test(
      'audio, passCriteria text, new format',
      () => execute(
        dto: const QuestionDto(passCriteria: newFormatAudio),
        expectedQuestion: const Question(
          passCriteria: <QuestionSection>[
            AudioSection.fromValue(value: newFormatAudioValue),
          ],
        ),
      ),
    );

    test(
      'audio, comments text, new format',
      () => execute(
        dto: const QuestionDto(comments: newFormatAudio),
        expectedQuestion: const Question(
          comments: <QuestionSection>[
            AudioSection.fromValue(value: newFormatAudioValue),
          ],
        ),
      ),
    );
  });

  group('Question image tests', () {
    const oldFormatImageValue = 'xxx.jpg';
    const oldFormatImage = '(pic: $oldFormatImageValue)';
    const newFormatImageValue =
        'https://db.chgk.info/sites/default/files/xxx.jpg';
    const newFormatImage = '(pic: $newFormatImageValue)';

    const imageDbUrl = '${Constants.databaseUrl}/images/db/';

    test(
      'image, question text, old format',
      () => execute(
        dto: const QuestionDto(question: oldFormatImage),
        expectedQuestion: const Question(
          display: '',
          question: <QuestionSection>[
            ImageSection.fromValue(value: '$imageDbUrl$oldFormatImageValue'),
          ],
        ),
      ),
    );

    test(
      'image, question text, new format',
      () => execute(
        dto: const QuestionDto(question: newFormatImage),
        expectedQuestion: const Question(
          display: '',
          question: <QuestionSection>[
            ImageSection.fromValue(value: newFormatImageValue),
          ],
        ),
      ),
    );

    test(
      'image, question text, in the beginning',
      () => execute(
        dto: const QuestionDto(question: '$newFormatImage text'),
        expectedQuestion: const Question(
          display: 'text',
          question: <QuestionSection>[
            ImageSection.fromValue(value: newFormatImageValue),
            TextSection.fromValue(value: 'text'),
          ],
        ),
      ),
    );

    test(
      'audio, question text, in the middle',
      () => execute(
        dto: const QuestionDto(question: 'text1 $newFormatImage text2'),
        expectedQuestion: const Question(
          display: 'text1 text2',
          question: <QuestionSection>[
            TextSection.fromValue(value: 'text1'),
            ImageSection.fromValue(value: newFormatImageValue),
            TextSection.fromValue(value: 'text2'),
          ],
        ),
      ),
    );

    test(
      'image, question text, in the end',
      () => execute(
        dto: const QuestionDto(question: '$newFormatImage text1'),
        expectedQuestion: const Question(
          display: 'text1',
          question: <QuestionSection>[
            ImageSection.fromValue(value: newFormatImageValue),
            TextSection.fromValue(value: 'text1'),
          ],
        ),
      ),
    );

    test(
      'image, question text, several entries, old format',
      () => execute(
        dto: const QuestionDto(
            question: 'text1 $oldFormatImage '
                'text2 $oldFormatImage '
                'text3 $oldFormatImage'),
        expectedQuestion: const Question(
          display: 'text1 text2 text3',
          question: <QuestionSection>[
            TextSection.fromValue(value: 'text1'),
            ImageSection.fromValue(value: '$imageDbUrl$oldFormatImageValue'),
            TextSection.fromValue(value: 'text2'),
            ImageSection.fromValue(value: '$imageDbUrl$oldFormatImageValue'),
            TextSection.fromValue(value: 'text3'),
            ImageSection.fromValue(value: '$imageDbUrl$oldFormatImageValue'),
          ],
        ),
      ),
    );

    test(
      'image, question text, several entries, new format',
      () => execute(
        dto: const QuestionDto(
            question: 'text1 $newFormatImage '
                'text2 $newFormatImage '
                'text3 $newFormatImage'),
        expectedQuestion: const Question(
          display: 'text1 text2 text3',
          question: <QuestionSection>[
            TextSection.fromValue(value: 'text1'),
            ImageSection.fromValue(value: newFormatImageValue),
            TextSection.fromValue(value: 'text2'),
            ImageSection.fromValue(value: newFormatImageValue),
            TextSection.fromValue(value: 'text3'),
            ImageSection.fromValue(value: newFormatImageValue),
          ],
        ),
      ),
    );

    test(
      'image, question text, without spaces around (), old format',
      () => execute(
        dto: const QuestionDto(question: 'text1${oldFormatImage}text2'),
        expectedQuestion: const Question(
          display: 'text1text2',
          question: <QuestionSection>[
            TextSection.fromValue(value: 'text1'),
            ImageSection.fromValue(value: '$imageDbUrl$oldFormatImageValue'),
            TextSection.fromValue(value: 'text2'),
          ],
        ),
      ),
    );

    test(
      'image, question text, without spaces around (), new format',
      () => execute(
        dto: const QuestionDto(question: 'text1${newFormatImage}text2'),
        expectedQuestion: const Question(
          display: 'text1text2',
          question: <QuestionSection>[
            TextSection.fromValue(value: 'text1'),
            ImageSection.fromValue(value: newFormatImageValue),
            TextSection.fromValue(value: 'text2'),
          ],
        ),
      ),
    );

    test(
      'image, answer text, new format',
      () => execute(
        dto: const QuestionDto(answer: newFormatImage),
        expectedQuestion: const Question(
          answer: <QuestionSection>[
            ImageSection.fromValue(value: newFormatImageValue),
          ],
        ),
      ),
    );

    test(
      'image, passCriteria text, new format',
      () => execute(
        dto: const QuestionDto(passCriteria: newFormatImage),
        expectedQuestion: const Question(
          passCriteria: <QuestionSection>[
            ImageSection.fromValue(value: newFormatImageValue),
          ],
        ),
      ),
    );

    test(
      'image, comments text, new format',
      () => execute(
        dto: const QuestionDto(comments: newFormatImage),
        expectedQuestion: const Question(
          comments: <QuestionSection>[
            ImageSection.fromValue(value: newFormatImageValue),
          ],
        ),
      ),
    );
  });
}