import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:word_game/cubits/game_controller.dart';
import 'package:word_game/game_keyboard.dart';
import 'package:word_game/word_row.dart';

class GamePage extends StatefulWidget {
  final GameController game;
  const GamePage({Key? key, required this.game}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  GameController get game => widget.game;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: SafeArea(
          child: BlocBuilder<GameController, GameState>(
              bloc: game,
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(MdiIcons.arrowLeft),
                          ),
                          Spacer(),
                          Text(
                            'Game: 5 letters',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ...state.guesses
                                .map(
                                  (e) => WordRow(
                                    length: state.length,
                                    content: e.content,
                                    correct: e.correct,
                                    semiCorrect: e.semiCorrect,
                                    finalised: e.finalised,
                                  ),
                                )
                                .toList(),
                            if (!state.gameFinished) WordRow(length: state.length, content: state.word),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                            child: GameKeyboard(
                          onTap: (x) => game.addLetter(x),
                          onBackspace: () => game.backspace(),
                          onEnter: () => game.enter(),
                          correct: state.correctLetters,
                          semiCorrect: state.semiCorrectLetters,
                          wrong: state.wrongLetters,
                          wordReady: state.wordReady,
                        )),
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
