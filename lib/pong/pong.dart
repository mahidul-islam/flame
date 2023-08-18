import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PongFlame extends StatelessWidget {
  const PongFlame({super.key});

  @override
  Widget build(BuildContext context) {
    Flame.device.fullScreen();
    Flame.device.setLandscape();
    Pong pong = Pong();
    return GameWidget<Pong>(game: pong);
  }
}

class Pong extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  late Paddle leftPaddle;
  late Paddle rightPaddle;
  late Ball ball;

  @override
  FutureOr<void> onLoad() {
    leftPaddle = Paddle(
        size: Vector2(5, 50), position: Vector2(size.x * 0.05, size.y * .5));
    rightPaddle = Paddle(
        size: Vector2(5, 50), position: Vector2(size.x * 0.95, size.y * .5));
    ball = Ball(
        radius: 10,
        position: Vector2(size.x * 0.5, size.y * 0.5),
        boardSize: size);
    addAll([leftPaddle, rightPaddle, ball]);
    return super.onLoad();
  }

  @override
  KeyEventResult onKeyEvent(
      RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    super.onKeyEvent(event, keysPressed);
    // LEFT Paddle
    if (keysPressed.contains(LogicalKeyboardKey.keyW)) {
      leftPaddle.paddleMovement = PaddleMovement.up;
      return KeyEventResult.handled;
    } else if (keysPressed.contains(LogicalKeyboardKey.keyS)) {
      leftPaddle.paddleMovement = PaddleMovement.down;
      return KeyEventResult.handled;
    }
    // RIGHT Paddle
    else if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      rightPaddle.paddleMovement = PaddleMovement.up;
      return KeyEventResult.handled;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
      rightPaddle.paddleMovement = PaddleMovement.down;
      return KeyEventResult.handled;
    }
    // OTHER
    else {
      rightPaddle.paddleMovement = PaddleMovement.none;
      leftPaddle.paddleMovement = PaddleMovement.none;
      return KeyEventResult.handled;
    }
  }
}

enum PaddleMovement { up, down, none }

class Paddle extends RectangleComponent with CollisionCallbacks {
  Paddle({super.size, super.position}) : super(anchor: Anchor.center);
  PaddleMovement paddleMovement = PaddleMovement.none;
  final double speed = 200;

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox());
    return super.onLoad();
  }

  // ShapeHitbox hitbox = ;
  @override
  void update(double dt) {
    if (paddleMovement == PaddleMovement.up) {
      position.y -= speed * dt;
    } else if (paddleMovement == PaddleMovement.down) {
      position.y += speed * dt;
    }
    super.update(dt);
  }
}

class Ball extends CircleComponent with CollisionCallbacks {
  Ball({super.radius, super.position, required this.boardSize})
      : super(anchor: Anchor.center);
  final double speed = 200;
  final Random rnd = Random();
  late Vector2 movement;
  final Vector2 boardSize;

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    movement.x = -movement.x;
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  Future<void> onLoad() {
    movement = getRandomUnitVector();
    add(CircleHitbox());
    return super.onLoad();
  }

  Vector2 getRandomUnitVector() {
    double rad = getRadFromDegree(rnd.nextDouble() * 45);
    return Vector2(cos(rad), sin(rad));
  }

  double getRadFromDegree(double degree) {
    return degree * pi / 180;
  }

  @override
  void update(double dt) {
    if (position.x >= boardSize.x || position.x <= 0) {
      movement.x = -movement.x;
    }
    if (position.y >= boardSize.y || position.y <= 0) {
      movement.y = -movement.y;
    }
    position += movement * speed * dt;
    super.update(dt);
  }
}
