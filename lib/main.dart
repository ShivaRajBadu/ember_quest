import 'package:ember_quest/ember_quest.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Flame.device.fullScreen();
  // await Flame.device.setLandscape();

  runApp(
    const GameWidget.controlled(
      gameFactory: EmberQuest.new,
    ),
  );
}
