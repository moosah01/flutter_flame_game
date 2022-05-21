import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_game/game/actor/player.dart';
import 'package:provider/provider.dart';
import '../../main_game_runner.dart';
import '../main.dart';

class TouchControls extends HudMarginComponent {
  Player? _player;
  late final SpriteComponent jumpIcon;
  late final SpriteComponent rightButtonIcon;
  late final SpriteComponent leftButtonIcon;
  late final SpriteComponent scoreImage;
  late final SpriteComponent healthImage;
  late final SpriteComponent pauseButton;
  late TextComponent healthTextComponent;
  final style1 = TextStyle(
    color: BasicPalette.white.color,
    fontSize: 35,
  );

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

  Future<void> onLoad() async {
    final regular = TextPaint(style: style1);
    const offset = 25.0;
    jumpIcon = SpriteComponent(
        size: Vector2.all(50), sprite: await Sprite.load("JumpIcon.png"));
    rightButtonIcon = SpriteComponent(
        size: Vector2.all(50), sprite: await Sprite.load("RightButton.png"));
    leftButtonIcon = SpriteComponent(
        size: Vector2.all(50), sprite: await Sprite.load("LeftButton.png"));

    scoreImage = SpriteComponent(
        size: Vector2.all(50),
        sprite: await Sprite.load("Coin.png"),
        position: Vector2(480, 15));

    add(scoreImage);

    healthImage = SpriteComponent(
        size: Vector2.all(50),
        sprite: await Sprite.load("CoinFront.png"),
        position: Vector2(20, 15));

    add(healthImage);

    // healthText = TextComponent(
    //     text: "X 5", position: Vector2(550, 15), textRenderer: regular)
    //   ..x = 570
    //   ..y = 22;
    // add(healthText);

    healthTextComponent = TextComponent(text: 'X ')..position = Vector2(80, 25);
    add(healthTextComponent);

    final leftButton = HudButtonComponent(
      button: leftButtonIcon,
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
      button: rightButtonIcon,
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
      button: jumpIcon,
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

  @override
  void update(double dt) {
    if (gameRef.buildContext != null) {
      final gameState =
          Provider.of<GameState>(gameRef.buildContext!, listen: false);
      healthTextComponent.text = 'HP ${gameState.health}';
    }
    super.update(dt);
  }
}
