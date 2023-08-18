import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

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

class Pong extends FlameGame with HasKeyboardHandlerComponents {
  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();

    return super.onLoad();
  }
}
