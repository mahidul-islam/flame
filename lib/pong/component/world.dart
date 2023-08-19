import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:pong/pong/component/ball.dart';
import 'package:pong/pong/component/paddle.dart';

class PongLevel extends World with KeyboardHandler {
  final Ball ball;
  final Paddle leftPaddle;
  final Paddle rightPaddle;
  PongLevel({
    required this.ball,
    required this.leftPaddle,
    required this.rightPaddle,
  });

  @override
  FutureOr<void> onLoad() {
    addAll([
      ball,
      leftPaddle,
      rightPaddle,
    ]);
    return super.onLoad();
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    super.onKeyEvent(event, keysPressed);
    // LEFT Paddle
    if (keysPressed.contains(LogicalKeyboardKey.keyW)) {
      leftPaddle.paddleMovement = PaddleMovement.up;
    } else if (keysPressed.contains(LogicalKeyboardKey.keyS)) {
      leftPaddle.paddleMovement = PaddleMovement.down;
    }
    // RIGHT Paddle
    else if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      rightPaddle.paddleMovement = PaddleMovement.up;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
      rightPaddle.paddleMovement = PaddleMovement.down;
    }
    // OTHER
    else {
      rightPaddle.paddleMovement = PaddleMovement.none;
      leftPaddle.paddleMovement = PaddleMovement.none;
    }
    return super.onKeyEvent(event, keysPressed);
  }
}
