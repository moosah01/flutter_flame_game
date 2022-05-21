import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/image_composition.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_flame_game/game/actor/player.dart';
import 'package:flame/game.dart';
import 'package:flutter_flame_game/game/game.dart';
import 'package:provider/provider.dart';
import '../../main_game_runner.dart';

import '../../main.dart';

class Coin extends SpriteComponent
    with CollisionCallbacks, HasGameRef<PlatformGame> {
  Coin(
    Image image, {
    //   Vector2? srcPosition,
    //   Vector2? srcSize,
    Paint? paint,
    Vector2? position,
    Vector2? size,
    Vector2? scale,
    double? angle,
    Anchor? anchor,
    int? priority,
  }) : super.fromImage(
          image,
          srcPosition: Vector2.zero(),
          srcSize: Vector2.all(32),
          paint: paint,
          size: size,
          scale: scale,
          angle: angle,
          anchor: anchor,
          priority: priority,
          position: position,
        );

  @override
  Future<void>? onLoad() {
    // TODO: implement onLoad
    add(CircleHitbox()..collisionType = CollisionType.passive);
    add(MoveByEffect(
        Vector2(0, -10),
        EffectController(
          alternate: true,
          infinite: true,
          duration: 0.8,
          curve: Curves.ease,
        )));

    return super.onLoad();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollisionStart
    if (other is Player) {
      //add(RemoveEffect());
      FlameAudio.play('collectCoin.mp3');
      final gameState =
          Provider.of<GameState>(gameRef.buildContext!, listen: false);
      gameState.score += 10;
      add(OpacityEffect.fadeOut(LinearEffectController(0.3))
        ..onFinishCallback = () {
          add(RemoveEffect());
        });
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
