import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:pong/pong/pong.dart';

class Ball extends CircleComponent with CollisionCallbacks, HasGameRef<Pong> {
  Ball({super.radius, super.position, required this.boardSize})
      : super(anchor: Anchor.center);
  final double speed = 200;
  final Random rnd = Random();
  late Offset direction;
  final Vector2 boardSize;
  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    double avg = intersectionPoints.map((e) => e.y).reduce((a, b) => a + b) /
        intersectionPoints.length;
    double modifier = (other.position.y - avg) / (other.size.y / 2);
    if (position.x > other.position.x) {
      direction = Offset.fromDirection(-getRadFromDegree(modifier * 60));
    } else {
      /// INPUT RANGE 0 TO 2
      /// OUTPUT RANGE 120 to 240
      /// output = ((input - input_start)/(input_range))
      ///             * output_range + output_start
      double output = ((modifier + 1) / 2) * 120 + 120;
      direction = Offset.fromDirection(getRadFromDegree(output));
    }

    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  Future<void> onLoad() {
    direction = getRandomUnitVector();
    add(CircleHitbox());
    return super.onLoad();
  }

  Offset getRandomUnitVector() {
    return Offset.fromDirection(getRadFromDegree(rnd.nextDouble() * 60));
  }

  double getRadFromDegree(double degree) {
    return degree * pi / 180;
  }

  @override
  void update(double dt) {
    if (position.x >= boardSize.x || position.x <= 0) {
      direction = Offset(-direction.dx, direction.dy);
    }
    if (position.y >= boardSize.y || position.y <= 0) {
      direction = Offset(direction.dx, -direction.dy);
    }
    position += direction.toVector2() * speed * dt;
    super.update(dt);
  }
}
