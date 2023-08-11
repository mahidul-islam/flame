import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:pong/pixel/levels/level.dart';

class FirstFlame extends StatelessWidget {
  const FirstFlame({super.key});

  @override
  Widget build(BuildContext context) {
    Flame.device.fullScreen();
    Flame.device.setLandscape();
    return GameWidget(game: Pixel());
  }
}

class Pixel extends FlameGame {
  late Level level;
  late CameraComponent cam;

  @override
  FutureOr<void> onLoad() {
    images.loadAllImages();
    level = Level(name: 'level02');
    cam = CameraComponent.withFixedResolution(
        world: level, width: 640, height: 360);
    cam.viewfinder.anchor = Anchor.topLeft;
    addAll([cam, level]);
    return super.onLoad();
  }
}
