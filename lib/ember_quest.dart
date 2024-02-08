import 'dart:async';
import 'dart:ui';

import 'package:ember_quest/actors/ember.dart';
import 'package:ember_quest/actors/water_enemy.dart';
import 'package:ember_quest/managers/segment_manager.dart';
import 'package:ember_quest/objects/ground_block.dart';
import 'package:ember_quest/objects/platform_block.dart';
import 'package:ember_quest/objects/star.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';

class EmberQuest extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  late EmberPlayer _ember;

  double objectSpeed = 0.0;
  late double lastBlockXPosition = 0.0;
  late UniqueKey lastBlockKey;

  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 173, 223, 247);
  }

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();
    camera.viewfinder.anchor = Anchor.topLeft;

    initializeGame();
    return super.onLoad();
  }

  void initializeGame() {
    final segmentToLoad = (size.x / 640).ceil();

    segmentToLoad.clamp(0, segments.length);
    for (var i = 0; i < segmentToLoad; i++) {
      loadGameSegments(i, (640 * i).toDouble());
    }
    _ember = EmberPlayer(
      position: Vector2(128, canvasSize.y - 128),
    );
    world.add(_ember);
  }

  void loadGameSegments(int segmentIndex, double xPositionOffset) {
    for (final block in segments[segmentIndex]) {
      switch (block.blockType) {
        case GroundBlock:
          world.add(
            GroundBlock(
              gridPosition: block.gridPosition,
              xOffset: xPositionOffset,
            ),
          );
          break;
        case PlatformBlock:
          add(PlatformBlock(
            gridPosition: block.gridPosition,
            xOffset: xPositionOffset,
          ));
          break;
        case Star:
          world.add(
              Star(gridPosition: block.gridPosition, xOffset: xPositionOffset));
          break;
        case WaterEnemy:
          world.add(WaterEnemy(
              gridPosition: block.gridPosition, xOffset: xPositionOffset));
          break;
        default:
      }
    }
  }
}
