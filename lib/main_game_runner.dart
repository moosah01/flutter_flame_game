import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flutter_flame_game/game/game.dart';
import 'package:provider/provider.dart';

final _game = PlatformGame();

class MyAppGame extends StatelessWidget {
  const MyAppGame({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameState>(
        create: (context) => GameState(),
        child: MaterialApp(
          title: 'FlutterDemo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Scaffold(
            body: Stack(children: <Widget>[
              GameWidget<PlatformGame>(
                game: PlatformGame(),
                initialActiveOverlays: const [
                  HudOverlayScore.id,
                  HudOverlayHealth.id
                ],
                overlayBuilderMap: {
                  HudOverlayScore.id: (context, game) =>
                      ChangeNotifierProvider<GameState>.value(
                        value: Provider.of<GameState>(context),
                        child: Positioned(
                            top: 25,
                            right: 40,
                            child: HudOverlayScore(gameRef: game)),
                      ),
                  // HudOverlayHealth.id: (context, game) =>
                  //     ChangeNotifierProvider<GameState>.value(
                  //       value: Provider.of<GameState>(context),
                  //       child: Positioned(
                  //           top: 25,
                  //           left: 20,
                  //           child: HudOverlayHealth(gameRef: game)),
                  //     ),
                },
              ),
            ]),
          ),
        ));
    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: GameWidget(game: kDebugMode ? PlatformGame() : _game),
    // );
  }
}

class GameState extends ChangeNotifier {
  int _score = 0;
  int _health = 300;
  int get score => _score;
  set score(int score) {
    _score = score;
    notifyListeners();
  }

  int get health => _health;
  set health(int health) {
    _health = health;
    notifyListeners();
  }
}

class HudOverlayScore extends StatelessWidget {
  static const String id = 'HudOverlay';
  final PlatformGame gameRef;

  const HudOverlayScore({Key? key, required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(
      builder: (context, gameState, child) {
        return Center(
          child: Text('X ${gameState.score}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
              )),
        );
      },
    );
  }
}

class HudOverlayHealth extends StatelessWidget {
  static const String id = 'HudOverlay';
  final PlatformGame gameRef;

  const HudOverlayHealth({Key? key, required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(
      builder: (context, gameState, child) {
        return Center(
          child: Text('X ${gameState.health}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
              )),
        );
      },
    );
  }
}
