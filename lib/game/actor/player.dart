import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/image_composition.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flame_game/game/actor/platforms.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import '../actor/platforms.dart';

class Player extends SpriteComponent with CollisionCallbacks, KeyboardHandler {
  final Vector2 _velocity = Vector2.zero();

  // can only be 0,-1 or 1 --> -1 is left  :  1 is right  :  0 is stationary
  int _hAxisInput = 0;
  bool _jumpInput = false;
  bool _isOnGround = false;

  //vlaue for gravity and speed determined using trial and error
  // UNFORTUNATELY LOTS OF IT
  final double _moveSpeed = 200;
  final double _gravity = 10;
  final double _jumpSpeed = 320;
  final Vector2 up = Vector2(0, -1);

  Player(
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
    debugMode = true;
    add(CircleHitbox());
    return super.onLoad();
  }

  @override
  void update(double dt) {
    // TODO: implement update
    // checks every microsecond
    // velocity = distance / time
    _velocity.x = _hAxisInput * _moveSpeed;
    _velocity.y += _gravity;

    //set max & min limit(S) so player doesn't fall off of map

    //negative because flutter starts counting pixels from top left corner so negative means
    //going downwards
    //max velocity in y direction because terminal velocity
    _velocity.y = _velocity.y.clamp(-_jumpSpeed, 500);

    if (_jumpInput) {
      if (_isOnGround) {
        _velocity.y = -_jumpSpeed;
        _isOnGround = false;
      }
      _jumpInput = false;
    }
    position.y = this.position.y.clamp(0, 448);

    position += _velocity * dt;

    //is it moving left
    if (_hAxisInput < 0 && scale.x > 0) {
      flipHorizontallyAroundCenter();
    } // else if it is moving right
    else if (_hAxisInput > 0 && scale.x < 0) {
      flipHorizontallyAroundCenter();
    }
    super.update(dt);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    _hAxisInput = 0;

    // see which key is pressed, if it is key A then do -1 i.e; go left else don't move
    // adding instead of assignging value is b/c if both left/right or A&D buttons are pressed togeth
    // they wont break the movement
    _hAxisInput += keysPressed.contains(LogicalKeyboardKey.keyA) ? -1 : 0;
    _hAxisInput += keysPressed.contains(LogicalKeyboardKey.keyD) ? 1 : 0;
    _jumpInput = keysPressed.contains(LogicalKeyboardKey.space) ? true : false;
    return true;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // 'other' checks what it is colliding with and what sort of collision types
    //  and collision parameters it has
    if (other is Platform) {
      if (intersectionPoints.length >= 0) {
        final mid = (intersectionPoints.elementAt(0) +
                intersectionPoints.elementAt(1)) /
            2;

        final collisionNormal = absoluteCenter - mid;
        final separationDistance = (size.x / 2) - collisionNormal.length;
        collisionNormal.normalize();

        if (up.dot(collisionNormal) > 0.9) {
          _isOnGround = true;
        }
        position += collisionNormal.scaled(separationDistance);
      }
    }
    super.onCollision(intersectionPoints, other);
  }

  set hAxisInput(int value) {
    _hAxisInput = value;
  }

  // Setter for jump input.
  set jump(bool jump) {
    _jumpInput = jump;
  }
}
