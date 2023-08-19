import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:pong/pong/component/world.dart';

import 'component/ball.dart';
import 'component/paddle.dart';

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
  late PongLevel pongLevel;
  late CameraComponent cam;

  @override
  FutureOr<void> onLoad() {
    leftPaddle = Paddle(size: Vector2(5, 50), position: Vector2(30, 180));
    rightPaddle = Paddle(size: Vector2(5, 50), position: Vector2(610, 180));
    ball = Ball(
      radius: 10,
      position: Vector2(320, 180),
      boardSize: Vector2(640, 360),
    );
    pongLevel = PongLevel(
      ball: ball,
      leftPaddle: leftPaddle,
      rightPaddle: rightPaddle,
    );
    cam = CameraComponent.withFixedResolution(
        world: pongLevel, width: 640, height: 360);
    cam.viewfinder.anchor = Anchor.topLeft;

    addAll([cam, pongLevel]);
    return super.onLoad();
  }
}
