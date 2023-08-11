import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:pong/pixel/characters/player.dart';

class Level extends World {
  late TiledComponent level;
  late Player player;

  String name;
  Level({required this.name});

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load('$name.tmx', Vector2.all(16));
    final ObjectGroup? spawnPointsLayer =
        level.tileMap.getLayer<ObjectGroup>('SpawnPoints');
    Vector2? playerPosition;
    for (int i = 0; i < (spawnPointsLayer?.objects.length ?? 0); i++) {
      if (spawnPointsLayer?.objects[i].class_ == 'Player') {
        playerPosition = Vector2(spawnPointsLayer?.objects[i].x ?? 0,
            spawnPointsLayer?.objects[i].y ?? 0);
      }
    }
    player = Player(
      character: 'Virtual Guy',
      initPosition: playerPosition,
    );
    addAll([level, player]);
    return super.onLoad();
  }
}
