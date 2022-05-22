import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/image_composition.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_game/game/actor/aegis.dart';
import 'package:flutter_flame_game/game/actor/coin.dart';
import 'package:flutter_flame_game/game/actor/enemy.dart';
import 'package:flutter_flame_game/game/game.dart';
import 'package:flutter_flame_game/mainMenu.dart';
import 'package:flutter_flame_game/main_game_runner.dart';
import 'package:provider/provider.dart';
import 'package:tiled/tiled.dart';
import '../../main.dart';
import '../game.dart';

import '../actor/door.dart';
import '../actor/platforms.dart';
import '../actor/player.dart';
import '../actor/coin.dart';

class level extends Component with HasGameRef<PlatformGame> {
  final String LevelName;
  late String currLevel;
  late Player _player;
  late Rect _levelBounds;

  level(this.LevelName) : super();

  BuildContext? get context => gameRef.buildContext;

  @override
  Future<void>? onLoad() async {
    // TODO: implement onLoad
    final level = await TiledComponent.load(LevelName, Vector2.all(32));
    add(level);

    _levelBounds = Rect.fromLTWH(
        0,
        0,
        (level.tileMap.map.width * level.tileMap.map.tileWidth).toDouble(),
        (level.tileMap.map.height * level.tileMap.map.tileHeight).toDouble());

    _spawnActors(level.tileMap);
    Future.delayed(const Duration(milliseconds: 1130), () {
      _player.jump = true;
    });
    _setupCamera();
    return super.onLoad();
  }

  void _spawnActors(RenderableTiledMap tileMap) {
    final gameState =
        Provider.of<GameState>(gameRef.buildContext!, listen: false);
    final platformsLayer = tileMap.getLayer<ObjectGroup>('Platforms');

    for (final platformObject in platformsLayer!.objects) {
      final platform = Platform(
        position: Vector2(platformObject.x, platformObject.y),
        size: Vector2(platformObject.width, platformObject.height),
      );
      add(platform);
    }

    final spawnPointsLayer = tileMap.getLayer<ObjectGroup>('SpawnPoints');
    for (final spawnPoint in spawnPointsLayer!.objects) {
      final positionActor =
          Vector2(spawnPoint.x, spawnPoint.y - spawnPoint.height);

      switch (spawnPoint.type) {
        case 'Player':
          _player = Player(gameRef.playerImage,
              levelBounds: _levelBounds,
              position: positionActor,
              anchor: Anchor.center,
              size: Vector2(32, 32));
          add(_player);

          break;

        case 'Coin':
          final coin = Coin(gameRef.coinImage,
              position: positionActor, size: Vector2(32, 32));
          add(coin);

          break;

        case 'Door':
          //gameRef._currLevel = spawnPoint.properties.first.value;
          final door = Door(gameRef.doorImage,
              position: positionActor,
              size: Vector2(64, 96), onPlayerEnter: () {
            //   if (spawnPoint.properties.first.value == 'mainMenu') {
            //     gameState.health = 300;
            //     FlameAudio.bgm.stop();
            //     gameState.score = 0;
            //     Navigator.of(context!).pushReplacement(
            //         MaterialPageRoute(builder: (context) => mainMenu()));
            // //  } else {
            gameRef.loadLevel(spawnPoint.properties.first.value);
            // }
          });
          add(door);

          break;

        case 'Enemy':
          final enemy = Enemy(gameRef.enemyImage,
              position: positionActor, size: Vector2(32, 32));
          add(enemy);

          break;

        case 'Aegis':
          final aegis = Aegis(gameRef.AegisImage,
              position: positionActor,
              size: Vector2(96, 96), onPlayerEnter: () {
            FlameAudio.bgm.stop();
            gameState.health = 500;
            gameState.score = 0;
            Future.delayed(const Duration(milliseconds: 2500), () {
              Navigator.of(context!).pushReplacement(
                  MaterialPageRoute(builder: (context) => mainMenu()));
            });
          });
          add(aegis);

          break;
      }
    }
  }

  void _setupCamera() {
    gameRef.camera.followComponent(_player);
    gameRef.camera.worldBounds = _levelBounds;
  }
}
