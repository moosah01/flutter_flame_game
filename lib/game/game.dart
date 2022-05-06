import 'package:flame/flame.dart';
import 'package:flame/image_composition.dart';
import 'package:flame/input.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flame/game.dart';
import 'package:flutter_flame_game/game/level/level.dart';
import 'package:flutter_flame_game/game/touch_controls.dart';
//import 'touch_controls.dart';

class PlatformGame extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents, HasTappables {
  level? _currentLevel;
  late Image playerImage;
  late Image coinImage;
  late Image turretImage;
  late Image enemyImage;
  late Image spriteSheet;
  late Image doorImage;
  late TouchControls touchControls;
  // late TouchControls touchControls;

  @override
  Future<void>? onLoad() async {
    // TODO: implement onLoad

    await Flame.device.fullScreen();
    await Flame.device.setLandscape();

    playerImage = await images.load('Player.png');
    coinImage = await images.load('Coin.png');
    enemyImage = await images.load('Enemy.png');
    spriteSheet = await images.load('Spritesheet.png');
    doorImage = await images.load('Door.png');

    camera.viewport = FixedResolutionViewport(Vector2(1280, 576));

    // touchControls = TouchControls(position: Vector2.zero(), priority: 1);
    //  add(touchControls);
    touchControls = TouchControls(position: Vector2.zero(), priority: 1);
    add(touchControls);

    loadLevel('Level1.tmx');

    return super.onLoad();
  }

  void loadLevel(String LevelName) {
    _currentLevel?.removeFromParent();
    _currentLevel = level(LevelName);
    add(_currentLevel!);
  }
}
