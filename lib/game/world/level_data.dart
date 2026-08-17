import 'package:flame/components.dart';

class LevelData {
  const LevelData({required this.name, required this.width, required this.floorY});
  final String name;
  final double width;
  final double floorY;

  static const levels = [
    LevelData(name: 'Green Valley', width: 5000, floorY: 520),
    LevelData(name: 'Crystal Cave', width: 5600, floorY: 520),
    LevelData(name: 'Sky Ruins', width: 6200, floorY: 440),
    LevelData(name: 'Lava Factory', width: 6500, floorY: 520),
    LevelData(name: 'Shadow Fortress', width: 7200, floorY: 520),
  ];

  Vector2 spawnPoint() => Vector2(140, floorY - 60);
}
