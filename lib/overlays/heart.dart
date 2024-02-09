import 'dart:async';

import 'package:ember_quest/ember_quest.dart';
import 'package:flame/components.dart';

enum HeartState {
  available,
  unavailable,
}

class HeartHealthComponent extends SpriteGroupComponent<HeartState>
    with HasGameRef<EmberQuest> {
  final int heartNumber;

  HeartHealthComponent({
    required this.heartNumber,
    required super.position,
    required super.size,
  });

  late Sprite _availableSprite;
  late Sprite _unavailableSprite;
  @override
  FutureOr<void> onLoad() async {
    // final availableSprite =
    //     await game.loadSprite('heart.png', srcSize: Vector2.all(32));

    // final unavailableSprite =
    //     await game.loadSprite('heart_half.png', srcSize: Vector2.all(32));

    _availableSprite = Sprite(game.images.fromCache('heart.png'));
    _unavailableSprite = Sprite(game.images.fromCache('heart_half.png'));

    sprites = {
      HeartState.available: _availableSprite,
      HeartState.unavailable: _unavailableSprite,
    };

    current = HeartState.available;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (game.health < heartNumber) {
      current = HeartState.unavailable;
    } else {
      current = HeartState.available;
    }
    super.update(dt);
  }
}
