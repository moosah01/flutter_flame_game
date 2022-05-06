import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_game/game/actor/player.dart';

class TouchControls extends HudMarginComponent {
  Player? _player;

  TouchControls({
    EdgeInsets? margin,
    Vector2? position,
    Vector2? size,
    Vector2? scale,
    double? angle,
    Anchor? anchor,
    Iterable<Component>? children,
    int? priority,
  }) : super(
          position: position,
          size: size,
          scale: scale,
          angle: angle,
          anchor: anchor,
          children: children,
          priority: priority,
        );

  void connectPlayer(Player player) {
    _player = player;
  }

  Future<void> onLoad() {
    const offset = 20.0;

    final leftButton = HudButtonComponent(
      button: RectangleComponent.square(size: 50),
      margin: const EdgeInsets.only(bottom: offset, left: offset),
      onPressed: () {
        _player?.hAxisInput = -1;
      },
      onReleased: () {
        _player?.hAxisInput = 0;
      },
    );
    add(leftButton);

    final rightButton = HudButtonComponent(
      button: RectangleComponent.square(size: 50),
      position: Vector2(
        leftButton.position.x + leftButton.size.x + 20,
        leftButton.position.y,
      ),
      onPressed: () {
        _player?.hAxisInput = 1;
      },
      onReleased: () {
        _player?.hAxisInput = 0;
      },
    );
    add(rightButton);

    final jumpButton = HudButtonComponent(
      button: RectangleComponent.square(size: 50),
      margin: const EdgeInsets.only(bottom: offset, right: offset),
      onPressed: () {
        _player?.jump = true;
      },
      onReleased: () {
        _player?.jump = false;
      },
    );
    add(jumpButton);

    return super.onLoad();
  }
}
