import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:pong/pixel/characters/player.dart';

class Level extends World {
  late TiledComponent level;
  late Player player;

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load('level01.tmx', Vector2.all(16));
    player = Player(character: 'Virtual Guy');
    addAll([level, player]);

    return super.onLoad();
  }
}
