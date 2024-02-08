import 'dart:async';

import 'package:ember_quest/ember_quest.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

class WaterEnemy extends SpriteAnimationComponent with HasGameRef<EmberQuest> {
  final Vector2 gridPosition;
  double xOffset;
  WaterEnemy({
    required this.gridPosition,
    required this.xOffset,
  }) : super(size: Vector2.all(64), anchor: Anchor.bottomLeft);
  final Vector2 velocity = Vector2.zero();

  @override
  FutureOr<void> onLoad() {
    debugMode = true;
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('water_enemy.png'),
      SpriteAnimationData.sequenced(
        amount: 2,
        stepTime: 0.2,
        textureSize: Vector2.all(16),
      ),
    );
    position = Vector2(
      (gridPosition.x * size.x) + xOffset,
      game.size.y - (gridPosition.y * size.y),
    );
    add(RectangleHitbox(collisionType: CollisionType.passive));
    add(
      MoveEffect.by(
        Vector2(-2 * size.x, 0),
        EffectController(
          duration: 3,
          alternate: true,
          infinite: true,
        ),
      ),
    );

    return super.onLoad();
  }

  @override
  void update(double dt) {
    velocity.x = game.objectSpeed;
    position += velocity * dt;
    if (position.x < -size.x) removeFromParent();
    super.update(dt);
  }
}
