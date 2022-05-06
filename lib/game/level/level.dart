import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter_flame_game/game/actor/coin.dart';
import 'package:flutter_flame_game/game/actor/enemy.dart';
import 'package:flutter_flame_game/game/game.dart';
import 'package:tiled/tiled.dart';
import '../game.dart';

import '../actor/door.dart';
import '../actor/platforms.dart';
import '../actor/player.dart';
import '../actor/coin.dart';

class level extends Component with HasGameRef<PlatformGame> {
  final String LevelName;
  late Player _player;

  level(this.LevelName) : super();

  @override
  Future<void>? onLoad() async {
    // TODO: implement onLoad

    final level = await TiledComponent.load(LevelName, Vector2.all(32));
    add(level);

    _spawnActors(level.tileMap);

    return super.onLoad();
  }

  void _spawnActors(RenderableTiledMap tileMap) {
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
      switch (spawnPoint.type) {
        case 'Player':
          final _player = Player(gameRef.playerImage,
              position: Vector2(spawnPoint.x, spawnPoint.y),
              anchor: Anchor.center,
              size: Vector2(32, 32));
          add(_player);

          break;

        case 'Coin':
          final coin = Coin(gameRef.coinImage,
              position: Vector2(spawnPoint.x, spawnPoint.y),
              size: Vector2(32, 32));
          add(coin);

          break;

        case 'Door':
          final door = Door(gameRef.doorImage,
              position: Vector2(spawnPoint.x, spawnPoint.y),
              size: Vector2(64, 96));
          add(door);

          break;

        case 'Enemy':
          final enemy = Enemy(gameRef.enemyImage,
              position: Vector2(spawnPoint.x, spawnPoint.y),
              size: Vector2(32, 32));
          add(enemy);

          break;
      }
    }
  }

  void _setupCamera() {
    gameRef.camera.followComponent(_player);
  }
}
