// ignore_for_file: constant_identifier_names

import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:pong/pixel/first.dart';

enum PlayerStates { Idle, Run }

enum PlayerMoveDirection { left, right, none }

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<Pixel>, KeyboardHandler {
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runAnimation;
  final double stepTime = 0.05;
  final String character;
  final Vector2? initPosition;
  Vector2 velocity = Vector2.zero();
  PlayerMoveDirection moveDirection = PlayerMoveDirection.none;

  bool isFacingRight = true;
  final double playerSpeed = 100;

  Player({this.character = 'Virtual Guy', this.initPosition});

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    bool isLeftKeyPressed =
        keysPressed.contains(LogicalKeyboardKey.arrowLeft) ||
            keysPressed.contains(LogicalKeyboardKey.keyA);
    bool isRightKeyPressed =
        keysPressed.contains(LogicalKeyboardKey.arrowRight) ||
            keysPressed.contains(LogicalKeyboardKey.keyD);
    if (isLeftKeyPressed && isRightKeyPressed) {
      moveDirection = PlayerMoveDirection.none;
    } else if (isLeftKeyPressed) {
      moveDirection = PlayerMoveDirection.left;
    } else if (isRightKeyPressed) {
      moveDirection = PlayerMoveDirection.right;
    } else {
      moveDirection = PlayerMoveDirection.none;
    }
    return super.onKeyEvent(event, keysPressed);
  }

  @override
  FutureOr<void> onLoad() {
    if (initPosition != null) {
      position = initPosition!;
    }
    idleAnimation = getSpriteAnimation(
        character: character, state: PlayerStates.Idle, amount: 11);
    runAnimation = getSpriteAnimation(
        character: character, state: PlayerStates.Run, amount: 12);
    animations = {
      PlayerStates.Idle: idleAnimation,
      PlayerStates.Run: runAnimation,
    };

    current = PlayerStates.Idle;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (moveDirection == PlayerMoveDirection.left) {
      current = PlayerStates.Run;
      if (isFacingRight) {
        flipHorizontallyAroundCenter();
        isFacingRight = false;
      }
      velocity = Vector2(-playerSpeed, 0);
    } else if (moveDirection == PlayerMoveDirection.right) {
      current = PlayerStates.Run;
      if (!isFacingRight) {
        flipHorizontallyAroundCenter();
        isFacingRight = true;
      }

      velocity = Vector2(playerSpeed, 0);
    } else if (moveDirection == PlayerMoveDirection.none) {
      current = PlayerStates.Idle;
      velocity = Vector2.zero();
    }
    position += velocity * dt;
    super.update(dt);
  }

  SpriteAnimation getSpriteAnimation(
      {required String character,
      required PlayerStates state,
      required int amount}) {
    return SpriteAnimation.fromFrameData(
      game.images
          .fromCache('Main Characters/$character/${state.name} (32x32).png'),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: stepTime,
        textureSize: Vector2.all(32),
      ),
    );
  }
}
