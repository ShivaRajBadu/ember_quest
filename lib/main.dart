import 'package:ember_quest/ember_quest.dart';
import 'package:ember_quest/overlays/game_over.dart';
import 'package:ember_quest/overlays/main_menu.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Flame.device.fullScreen();
  // await Flame.device.setLandscape();

  runApp(
    GameWidget.controlled(
      gameFactory: EmberQuest.new,
      overlayBuilderMap: {
        "MainMenu": (_, game) => MainMenu(game: game as EmberQuest),
        "GameOver": (_, game) => GameOver(game: game as EmberQuest),
      },
      initialActiveOverlays: const ['MainMenu'],
    ),
  );
}
