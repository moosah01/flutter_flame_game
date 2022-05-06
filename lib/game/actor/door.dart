import 'package:flame/components.dart';
import 'package:flame/image_composition.dart';
import 'package:flutter/painting.dart';

class Door extends SpriteComponent {
  Door(
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
          srcSize: Vector2(32, 32),
          paint: paint,
          size: size,
          scale: scale,
          angle: angle,
          anchor: anchor,
          priority: priority,
          position: position,
        );
}
