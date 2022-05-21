import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/image_composition.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flame_game/game/actor/player.dart';

class Door extends SpriteComponent with CollisionCallbacks {
  Function? onPlayerEnter;
  Door(
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
          srcSize: Vector2(32, 32),
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
    add(RectangleHitbox()..collisionType = CollisionType.passive);
    return super.onLoad();
  }

  //similar to onCollision method but triggers on first collision only
  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollisionStart
    if (other is Player) {
      onPlayerEnter?.call();
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
