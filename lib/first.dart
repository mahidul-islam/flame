import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class FirstFlame extends StatelessWidget {
  const FirstFlame({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: MyGame());
  }
}

class MyGame extends FlameGame {}
