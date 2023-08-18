import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:pong/pixel/characters/player.dart';
import 'package:pong/pixel/levels/level.dart';

class FirstFlame extends StatelessWidget {
  const FirstFlame({super.key});

  @override
  Widget build(BuildContext context) {
    Flame.device.fullScreen();
    Flame.device.setLandscape();
    Pixel pixel = Pixel();
    return GameWidget<Pixel>(game: pixel);
  }
}

class Pixel extends FlameGame with HasKeyboardHandlerComponents, DragCallbacks {
  late Level level;
  late CameraComponent cam;
  late JoystickComponent joyStick;
  bool hasJoystick = false;
  Player player = Player();

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();
    level = Level(name: 'level01', player: player);
    cam = CameraComponent.withFixedResolution(
        world: level, width: 640, height: 360);
    cam.viewfinder.anchor = Anchor.topLeft;
    addAll([cam, level]);
    if (hasJoystick) {
      joyStick = JoystickComponent(
        knob: SpriteComponent(
          sprite: Sprite(
            images.fromCache('HUD/Knob.png'),
          ),
        ),
        background: SpriteComponent(
          sprite: Sprite(
            images.fromCache('HUD/Joystick.png'),
          ),
        ),
        margin: const EdgeInsets.only(left: 32, bottom: 32),
      );
      add(joyStick);
    }
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (hasJoystick) {
      switch (joyStick.direction) {
        case JoystickDirection.right:
        case JoystickDirection.upRight:
        case JoystickDirection.downRight:
          player.moveDirection = PlayerMoveDirection.right;
          break;
        case JoystickDirection.left:
        case JoystickDirection.upLeft:
        case JoystickDirection.downLeft:
          player.moveDirection = PlayerMoveDirection.left;
          break;
        default:
          player.moveDirection = PlayerMoveDirection.none;
      }
    }
    super.update(dt);
  }
}
