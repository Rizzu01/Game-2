import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'game/game_state.dart';
import 'game/player/player.dart';
import 'game/player/player_controller.dart';
import 'game/world/platform.dart';
import 'game/world/level_data.dart';
import 'game/collectibles/coin.dart';
import 'game/enemies/walker_enemy.dart';
import 'widgets/virtual_controls.dart';

void main() => runApp(const PixelQuestApp());

class PixelQuestApp extends StatelessWidget {
  const PixelQuestApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pixel Quest: Shadow Runner',
        theme: ThemeData.dark(useMaterial3: true),
        home: const MainMenu(),
      );
}

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF0B1020), Color(0xFF17304A)]),
          ),
          child: Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Text('PIXEL QUEST', style: TextStyle(fontSize: 42, fontWeight: FontWeight.w900, letterSpacing: 4)),
              const Text('SHADOW RUNNER', style: TextStyle(color: Color(0xFF66E3FF), letterSpacing: 3, fontWeight: FontWeight.bold)),
              const SizedBox(height: 36),
              FilledButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const GamePage())), child: const Text('PLAY')),
              const SizedBox(height: 10),
              OutlinedButton(onPressed: () {}, child: const Text('LEVELS')),
              const SizedBox(height: 10),
              OutlinedButton(onPressed: () {}, child: const Text('SETTINGS')),
            ]),
          ),
        ),
      );
}

class GamePage extends StatefulWidget {
  const GamePage({super.key});
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late final PlayerController controller;
  late final PixelQuestGame game;
  @override
  void initState() {
    super.initState();
    controller = PlayerController();
    game = PixelQuestGame(controller: controller);
  }
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(children: [
          GameWidget(game: game),
          VirtualControls(controller: controller),
          SafeArea(child: Padding(
            padding: const EdgeInsets.all(14),
            child: AnimatedBuilder(animation: game, builder: (_, __) => Row(children: [
              Text('♥ ${game.state.health}'), const SizedBox(width: 18),
              Text('COINS ${game.state.coins.toString().padLeft(3, '0')}'), const Spacer(),
              Text('SCORE ${game.state.score}'), const SizedBox(width: 12),
              IconButton(onPressed: () => game.state.mode = game.state.mode == GameMode.paused ? GameMode.playing : GameMode.paused, icon: const Icon(Icons.pause_circle_filled)),
            ])),
          )),
        ]),
      );
}

class PixelQuestGame extends FlameGame {
  PixelQuestGame({required this.controller});
  final PlayerController controller;
  final state = GameState();
  late Player player;
  late LevelData level;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    state.startRun();
    level = LevelData.levels.first;
    player = Player(controller: controller);
    world.add(player);
    world.add(PlatformBlock(position: Vector2(0, level.floorY), size: Vector2(level.width, 80)));
    for (var i = 0; i < 18; i++) {
      final x = 300.0 + i * 250;
      world.add(Coin(position: Vector2(x, level.floorY - 110 - (i % 2) * 70)));
    }
    for (var i = 0; i < 10; i++) {
      world.add(PlatformBlock(position: Vector2(240 + i * 460, level.floorY - 100 - (i % 3) * 65), size: Vector2(150, 24)));
    }
    for (var i = 0; i < 6; i++) {
      world.add(WalkerEnemy(position: Vector2(650 + i * 600, level.floorY - 38)));
    }
    camera.follow(player);
    camera.viewfinder.zoom = 1.15;
  }

  @override
  void update(double dt) {
    if (state.mode == GameMode.paused) return;
    super.update(dt);
    if (state.mode == GameMode.playing) state.elapsed += dt;
    if (player.position.x > level.width - 180) state.mode = GameMode.levelComplete;
    if (player.position.y > level.floorY + 250) {
      player.position = level.spawnPoint();
      state.health--;
      if (state.health <= 0) state.mode = GameMode.gameOver;
    }
  }

  @override
  Color backgroundColor() => const Color(0xFF0D1526);
}
