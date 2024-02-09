import 'dart:async';

import 'package:ember_quest/ember_quest.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/widgets.dart';

class Star extends SpriteComponent with HasGameRef<EmberQuest> {
  final Vector2 gridPosition;
  double xOffset;
  final Vector2 velocity = Vector2.zero();
  Star({
    required this.gridPosition,
    required this.xOffset,
  }) : super(
          anchor: Anchor.center,
          size: Vector2.all(64),
        );

  @override
  FutureOr<void> onLoad() {
    sprite = Sprite(game.images.fromCache('star.png'));
    position = Vector2(
      (gridPosition.x * size.x) + xOffset + (size.x / 2),
      game.size.y - (gridPosition.y * size.y) - (size.y / 2),
    );
    add(RectangleHitbox(collisionType: CollisionType.passive));
    add(
      SizeEffect.by(
        Vector2(-24, -24),
        EffectController(
            duration: .75,
            reverseDuration: .5,
            infinite: true,
            curve: Curves.easeOut),
      ),
    );
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (position.x < -size.x || game.health <= 0) {
      removeFromParent();
    }
    velocity.x = game.objectSpeed;
    position += velocity * dt;
    if (position.x < -size.x) removeFromParent();
    super.update(dt);
  }
}
