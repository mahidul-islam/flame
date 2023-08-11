// ignore_for_file: constant_identifier_names

import 'dart:async';

import 'package:flame/components.dart';
import 'package:pong/pixel/first.dart';

enum PlayerStates { Idle, Run }

class Player extends SpriteAnimationGroupComponent with HasGameRef<Pixel> {
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runAnimation;
  final double stepTime = 0.05;
  final String character;
  final Vector2? initPosition;

  Player({required this.character, required this.initPosition});

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

    current = PlayerStates.Run;
    return super.onLoad();
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
