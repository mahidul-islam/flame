import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

enum PaddleMovement { up, down, none }

class Paddle extends RectangleComponent with CollisionCallbacks {
  Paddle({super.size, super.position}) : super(anchor: Anchor.center);
  PaddleMovement paddleMovement = PaddleMovement.none;
  final double speed = 200;

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox());
    return super.onLoad();
  }

  // ShapeHitbox hitbox = ;
  @override
  void update(double dt) {
    if (paddleMovement == PaddleMovement.up) {
      position.y -= speed * dt;
    } else if (paddleMovement == PaddleMovement.down) {
      position.y += speed * dt;
    }
    super.update(dt);
  }
}
