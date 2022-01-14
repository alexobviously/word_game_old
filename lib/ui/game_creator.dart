import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/cubits/game_manager.dart';
import 'package:word_game/model/game_config.dart';

class GameCreator extends StatefulWidget {
  GameCreator({Key? key}) : super(key: key);

  @override
  _GameCreatorState createState() => _GameCreatorState();
}

class _GameCreatorState extends State<GameCreator> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final gameManager = BlocProvider.of<GameManager>(context);
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(6.0),
        // shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade500,
            offset: const Offset(2, 2),
            blurRadius: 12.0,
          ),
          const BoxShadow(
            color: Colors.white,
            offset: Offset(-2, -2),
            blurRadius: 12.0,
          ),
        ],
      ),
      child: Column(
        children: [
          Text('New Game', style: textTheme.headline5),
          OutlinedButton(onPressed: () => gameManager.createLocalGame(GameConfig(wordLength: 5)), child: Text('Start')),
        ],
      ),
    );
  }
}
