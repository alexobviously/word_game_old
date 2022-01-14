import 'package:flutter/services.dart';
import 'package:word_game/extensions/ready_mixin.dart';

class Dictionary with ReadyManager {
  static const int minimumLength = 4;
  static const int maximumLength = 8;
  Map<int, List<String>> words = {};
  static int startTime = DateTime.now().millisecondsSinceEpoch;

  Dictionary() {
    init();
  }

  int get elapsed => DateTime.now().millisecondsSinceEpoch - startTime;

  @override
  Future<bool> initialise() async {
    for (int i = minimumLength; i <= maximumLength; i++) {
      words[i] = [];
    }
    print('%% [${elapsed}ms] starting');
    String everything = await rootBundle.loadString('assets/words_alpha.txt');
    print('%% [${elapsed}ms] dict file loaded: ${everything.substring(0, 50)}...');
    List<String> allWords = everything.split('\n');
    print('%% [${elapsed}ms] words split: ${allWords.length}');
    for (String w in allWords) {
      if (w.length < minimumLength || w.length > maximumLength) continue;
      words[w.length]!.add(w);
      if (w == 'start') print('found "start"!');
    }
    print('%% [${elapsed}ms] words sorted by length');
    for (int i = minimumLength; i <= maximumLength; i++) {
      print('%%% $i: ${words[i]!.length}');
    }
    setReady();
    return true;
  }

  bool isValidWord(String word) {
    if (word.length < minimumLength || word.length > maximumLength) return false;
    return words[word.length]!.contains(word);
  }
}
