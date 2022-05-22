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
import 'package:flutter_flame_game/mainMenu.dart';
import '../../main.dart';

class Aegis extends SpriteComponent
    with CollisionCallbacks, HasGameRef<PlatformGame> {
  Function? onPlayerEnter;
  Aegis(
    Image image, {
    //   Vector2? srcPosition,
    //   Vector2? srcSize,
    this.onPlayerEnter,
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
    if (other is Player) {
      FlameAudio.bgm.stop();
      FlameAudio.play('gameWin.mp3');
      final effect =
          ScaleEffect.by(Vector2.all(2), EffectController(duration: 2.0));
      add(effect);
      final effect1 =
          MoveToEffect(Vector2(3486, 200), EffectController(duration: 1.0));
      add(effect1);
      onPlayerEnter?.call();
    }

    super.onCollision(intersectionPoints, other);
  }
}
