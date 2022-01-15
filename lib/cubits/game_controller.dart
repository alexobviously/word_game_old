import 'package:bloc/bloc.dart';
import 'package:word_game/mediator/mediator.dart';
import 'package:word_game/model/word_data.dart';

class GameController extends Cubit<GameState> {
  final Mediator mediator;
  GameController({required int length, required this.mediator}) : super(GameState.initial(length));

  void addLetter(String l) {
    if (state.word.length >= state.length) return;
    emit(state.copyWith(current: WordData.current('${state.word}$l')));
  }

  void backspace() {
    if (state.word.isEmpty) return;
    emit(state.copyWith(current: WordData.current(state.word.substring(0, state.word.length - 1))));
  }

  void enter() async {
    final _result = await mediator.validateWord(state.word);
    if (!_result.valid) return;
    emit(state.copyWith(current: WordData.blank(), guesses: List.from(state.guesses)..add(_result.word!)));
  }

  Stream<int> get numRowsStream => stream.map((e) => e.numRows).distinct();
}

class GameState {
  final int length;
  final List<WordData> guesses;
  final WordData current;

  String get word => current.content;
  bool get wordReady => word.length == length;
  Set<String> get correctLetters => Set<String>.from(guesses.expand((e) => e.correctLetters));
  Set<String> get semiCorrectLetters =>
      Set<String>.from(guesses.expand((e) => e.semiCorrectLetters))..removeWhere((e) => correctLetters.contains(e));
  Set<String> get wrongLetters => Set<String>.from(guesses.expand((e) => e.wrongLetters));
  bool get gameFinished => guesses.isNotEmpty && guesses.last.correctLetters.length == length;
  int get numRows => guesses.length + (gameFinished ? 0 : 1);

  GameState({required this.length, required this.guesses, required this.current});
  factory GameState.initial(int length) => GameState(length: length, guesses: [], current: WordData.blank());

  GameState copyWith({
    int? length,
    List<WordData>? guesses,
    WordData? current,
  }) =>
      GameState(
        length: length ?? this.length,
        guesses: guesses ?? this.guesses,
        current: current ?? this.current,
      );
}
