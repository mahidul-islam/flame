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

  Player({required this.character});

  @override
  FutureOr<void> onLoad() {
    idleAnimation =
        getSpriteAnimation(character: character, state: PlayerStates.Idle);
    runAnimation =
        getSpriteAnimation(character: character, state: PlayerStates.Run);
    animations = {
      PlayerStates.Idle: idleAnimation,
      PlayerStates.Run: runAnimation,
    };

    current = PlayerStates.Idle;
    return super.onLoad();
  }

  SpriteAnimation getSpriteAnimation(
      {required String character, required PlayerStates state}) {
    return SpriteAnimation.fromFrameData(
      game.images
          .fromCache('Main Characters/$character/${state.name} (32x32).png'),
      SpriteAnimationData.sequenced(
        amount: 11,
        stepTime: stepTime,
        textureSize: Vector2.all(32),
      ),
    );
  }
}
