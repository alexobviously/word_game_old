import 'package:word_game/mediator/mediator.dart';
import 'package:word_game/model/word_data.dart';

class OfflineMediator implements Mediator {
  final String answer;
  OfflineMediator({required this.answer});

  @override
  Future<WordValidationResult> validateWord(String word) async {
    if (word.length != answer.length) return WordValidationResult.invalid();
    List<int> correct = [];
    List<int> semiCorrect = [];
    for (int i = 0; i < word.length; i++) {
      String letter = word[i];
      int index = answer.indexOf(letter);
      if (index != -1) {
        if (index == i) {
          correct.add(i);
        } else {
          semiCorrect.add(i);
        }
      }
    }
    return WordValidationResult(
      valid: true,
      word: WordData(
        content: word,
        correct: correct,
        semiCorrect: semiCorrect,
        finalised: true,
      ),
    );
  }
}
