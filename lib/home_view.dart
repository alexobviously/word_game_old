import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/app/colours.dart';
import 'package:word_game/cubits/game_controller.dart';
import 'package:word_game/game_keyboard.dart';
import 'package:word_game/mediator/mediator.dart';
import 'package:word_game/mediator/offline_mediator.dart';
import 'package:word_game/model/word_data.dart';
import 'package:word_game/word_row.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final Mediator mediator;
  late final GameController gc;

  @override
  void initState() {
    mediator = OfflineMediator(answer: 'links');
    gc = GameController(length: 5, mediator: mediator);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<GameController, GameState>(
                  bloc: gc,
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Cheap Wordle Clone',
                            style: Theme.of(context).textTheme.headline4,
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
                              onTap: (x) => gc.addLetter(x),
                              onBackspace: () => gc.backspace(),
                              onEnter: () => gc.enter(),
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
            ],
          ),
        ),
      ),
    );
  }
}
